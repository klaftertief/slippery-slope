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
