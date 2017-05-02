module SlippyMap.Geo.Transform exposing (..)

import SlippyMap.Geo.Coordinate as Coordinate exposing (Coordinate)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Mercator as Mercator


type alias Transform =
    { tileSize : Int
    , width : Float
    , height : Float
    , center : Location
    , zoom : Float
    }


locationToPoint : Transform -> Location -> Point
locationToPoint transform location =
    locationToCoordinate transform location
        |> coordinateToPoint transform


pointToLocation : Transform -> Point -> Location
pointToLocation transform point =
    pointToCoordinate transform point
        |> coordinateToLocation transform


{-| Converts given location in WGS84 Datum to a Coordinate.

    >>> locationToCoordinate testTransform { lon = 6.96, lat = 50.94 }
    { column = 8508.757333333333
    , row = 5489.3311249
    , zoom = 14
    }
-}
locationToCoordinate : Transform -> Location -> Coordinate
locationToCoordinate transform location =
    Mercator.project location
        |> mercatorPointToCoordinate transform


coordinateToLocation : Transform -> Coordinate -> Location
coordinateToLocation transform coordinate =
    coordinateToMercatorPoint transform coordinate
        |> Mercator.unproject


pointToCoordinate : Transform -> Point -> Coordinate
pointToCoordinate transform { x, y } =
    let
        scale =
            toFloat transform.tileSize
    in
        { column = x / scale
        , row = y / scale
        , zoom = transform.zoom
        }


coordinateToPoint : Transform -> Coordinate -> Point
coordinateToPoint transform coordinate =
    let
        { column, row, zoom } =
            Coordinate.zoomTo transform.zoom coordinate

        scale =
            toFloat transform.tileSize
    in
        { x = column * scale
        , y = row * scale
        }


{-| Converts a EPSG:900913 point in radians to pyramid pixel coordinates for a given transform Transform.
-}
mercatorPointToCoordinate : Transform -> Point -> Coordinate
mercatorPointToCoordinate transform =
    mercatorPointToRelativePoint >> relativePointToCoordinate transform


{-| Converts pyramid pixel coordinates with given zoom level to EPSG:900913 in normalized radians.
-}
coordinateToMercatorPoint : Transform -> Coordinate -> Point
coordinateToMercatorPoint transform =
    coordinateToRelativePoint transform >> relativePointToMercatorPoint


coordinateToRelativePoint : Transform -> Coordinate -> Point
coordinateToRelativePoint transform coordinate =
    let
        { column, row, zoom } =
            Coordinate.zoomTo transform.zoom coordinate

        scale =
            zoomScale zoom
    in
        { x = column / scale
        , y = row / scale
        }


relativePointToCoordinate : Transform -> Point -> Coordinate
relativePointToCoordinate { zoom } { x, y } =
    let
        scale =
            zoomScale zoom
    in
        { column = x * scale
        , row = y * scale
        , zoom = zoom
        }


mercatorPointToRelativePoint : Point -> Point
mercatorPointToRelativePoint { x, y } =
    { x = (1 + x / pi) / 2
    , y = (1 - y / pi) / 2
    }


relativePointToMercatorPoint : Point -> Point
relativePointToMercatorPoint { x, y } =
    { x = (x * 2 - 1) * pi
    , y = -(y * 2 - 1) * pi
    }


tileZoom : Transform -> Float
tileZoom =
    .zoom >> floor >> toFloat


zoomScale : Float -> Float
zoomScale zoom =
    2 ^ zoom



-- MAP AND LAYER HELPER


{-| Change transform zoom to an integer as tile data is not available for float values in general.
-}
tileTransform : Transform -> Transform
tileTransform transform =
    { transform | zoom = toFloat (round transform.zoom) }


tileScale : Transform -> Float
tileScale transform =
    zoomScale
        (transform.zoom - (tileTransform transform |> .zoom))


centerPoint : Transform -> Point
centerPoint transform =
    locationToPoint transform transform.center


bounds : Transform -> Coordinate.Bounds
bounds =
    scaledBounds 1


tileBounds : Transform -> Coordinate.Bounds
tileBounds transform =
    scaledBounds (tileScale transform)
        (tileTransform transform)


scaledBounds : Float -> Transform -> Coordinate.Bounds
scaledBounds scale transform =
    let
        center =
            centerPoint transform

        ( topLeftCoordinate, bottomRightCoordinate ) =
            ( pointToCoordinate transform
                { x = center.x - transform.width / 2 / scale
                , y = center.y - transform.height / 2 / scale
                }
            , pointToCoordinate transform
                { x = center.x + transform.width / 2 / scale
                , y = center.y + transform.height / 2 / scale
                }
            )
    in
        { topLeft = topLeftCoordinate
        , topRight =
            { topLeftCoordinate
                | column = bottomRightCoordinate.column
            }
        , bottomRight = bottomRightCoordinate
        , bottomLeft =
            { topLeftCoordinate
                | row = bottomRightCoordinate.row
            }
        }



-- UPDATE HELPER


moveTo : Transform -> Point -> Transform
moveTo transform toPoint =
    let
        currentCenterPoint =
            centerPoint transform

        newCenterPoint =
            { x = toPoint.x + currentCenterPoint.x - transform.width / 2
            , y = toPoint.y + currentCenterPoint.y - transform.height / 2
            }
    in
        { transform | center = pointToLocation transform newCenterPoint }


zoomToAround : Transform -> Float -> Point -> Transform
zoomToAround transform newZoom around =
    let
        transformZoomed =
            { transform | zoom = newZoom }

        currentCenterPoint =
            centerPoint transform

        aroundPoint =
            { x = around.x + currentCenterPoint.x - transform.width / 2
            , y = around.y + currentCenterPoint.y - transform.height / 2
            }

        aroundLocation =
            pointToLocation transform aroundPoint

        aroundPointZoomed =
            locationToPoint transformZoomed aroundLocation

        aroundPointDiff =
            { x = aroundPointZoomed.x - aroundPoint.x
            , y = aroundPointZoomed.y - aroundPoint.y
            }

        newCenter =
            pointToLocation transformZoomed
                { x = currentCenterPoint.x + aroundPointDiff.x
                , y = currentCenterPoint.y + aroundPointDiff.y
                }
    in
        { transform
            | zoom = newZoom
            , center = newCenter
        }
