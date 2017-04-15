module SlippyMap.LowLevel exposing (..)

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


container : Transform -> List (Svg msg) -> Svg msg
container ({ width, height } as transform) elements =
    Svg.svg
        [ Svg.Attributes.height (toString height)
        , Svg.Attributes.width (toString width)
        ]
        elements


tileLayer : (Tile -> a) -> (a -> Svg msg) -> Transform -> Svg msg
tileLayer fromTile render transform =
    let
        ( tileTransform, scale, tiles, centerPoint ) =
            toTransformScaleCoverCenter transform
    in
        Svg.Keyed.node "g"
            [ Svg.Attributes.transform
                (""
                    ++ "translate("
                    ++ toString (round centerPoint.x)
                    ++ " "
                    ++ toString (round centerPoint.y)
                    ++ ")"
                    ++ " "
                    ++ "scale("
                    ++ toString scale
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString (round -centerPoint.x)
                    ++ " "
                    ++ toString (round -centerPoint.y)
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString (round ((tileTransform.width / 2 - centerPoint.x) / scale))
                    ++ " "
                    ++ toString (round ((tileTransform.height / 2 - centerPoint.y) / scale))
                    ++ ")"
                )
            ]
            (List.map (tile (fromTile >> render) tileTransform) tiles)


toTransformScaleCoverCenter : Transform -> ( Transform, Float, List Tile, Point )
toTransformScaleCoverCenter transform =
    let
        -- Change transform zoom to an integer as tile data is not available for float values in general.
        tileTransform =
            { transform | zoom = toFloat (round transform.zoom) }

        -- As the zoom in the transform is changed the tiles need to be scaled to match the actual zoom value.
        scale =
            Transform.zoomScale
                (transform.zoom - tileTransform.zoom)

        centerPoint =
            Transform.locationToPoint tileTransform tileTransform.center

        -- Scale the bounds points to take the zoom differences into account
        ( topLeftCoordinate, bottomRightCoordinate ) =
            ( Transform.pointToCoordinate tileTransform
                { x = centerPoint.x - tileTransform.width / 2 / scale
                , y = centerPoint.y - tileTransform.height / 2 / scale
                }
            , Transform.pointToCoordinate tileTransform
                { x = centerPoint.x + tileTransform.width / 2 / scale
                , y = centerPoint.y + tileTransform.height / 2 / scale
                }
            )

        bounds =
            { topLeft = topLeftCoordinate
            , topRight =
                { topLeftCoordinate | column = bottomRightCoordinate.column }
            , bottomRight = bottomRightCoordinate
            , bottomLeft =
                { topLeftCoordinate | row = bottomRightCoordinate.row }
            }

        tiles =
            Tile.cover bounds
    in
        ( tileTransform, scale, tiles, centerPoint )


tile : (Tile -> Svg msg) -> Transform -> Tile -> ( String, Svg msg )
tile render transform ({ z, x, y } as tile) =
    let
        key =
            toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        point =
            Transform.coordinateToPoint transform tileCoordinate
    in
        ( key
        , Svg.g
            [ Svg.Attributes.transform
                ("translate("
                    ++ toString point.x
                    ++ " "
                    ++ toString point.y
                    ++ ")"
                )
            ]
            [ render tile ]
        )


markerLayer : Svg msg -> Transform -> List Location -> Svg msg
markerLayer markerSvg transform markerLocations =
    let
        centerPoint =
            Transform.locationToPoint transform transform.center
    in
        Svg.g
            [ Svg.Attributes.transform
                (""
                    ++ "translate("
                    ++ toString (round (transform.width / 2 - centerPoint.x))
                    ++ " "
                    ++ toString (round (transform.height / 2 - centerPoint.y))
                    ++ ")"
                )
            ]
            (List.map (marker markerSvg transform) markerLocations)


marker : Svg msg -> Transform -> Location -> Svg msg
marker markerSvg transform markerLocation =
    let
        markerPoint =
            Transform.locationToPoint transform markerLocation
    in
        Svg.g
            [ Svg.Attributes.transform
                ("translate("
                    ++ toString markerPoint.x
                    ++ " "
                    ++ toString markerPoint.y
                    ++ ")"
                )
            ]
            [ markerSvg ]


gridLayer : Transform -> Svg msg
gridLayer transform =
    let
        centerPoint =
            Transform.locationToPoint transform transform.center

        nw =
            { x = centerPoint.x - transform.width / 2
            , y = centerPoint.y - transform.height / 2
            }
                |> Transform.pointToLocation transform

        se =
            { x = centerPoint.x + transform.width / 2
            , y = centerPoint.y + transform.height / 2
            }
                |> Transform.pointToLocation transform

        lons =
            List.range (floor nw.lon) (ceiling se.lon)
                |> List.map toFloat
                |> List.map
                    (\lon ->
                        ( Transform.locationToPoint transform
                            { lon = lon, lat = se.lat }
                        , Transform.locationToPoint transform
                            { lon = lon, lat = nw.lat }
                        )
                    )

        lats =
            List.range (floor se.lat) (ceiling nw.lat)
                |> List.map toFloat
                |> List.map
                    (\lat ->
                        ( Transform.locationToPoint transform
                            { lon = nw.lon, lat = lat }
                        , Transform.locationToPoint transform
                            { lon = se.lon, lat = lat }
                        )
                    )
    in
        Svg.g []
            [ Svg.g
                [ Svg.Attributes.transform
                    ("translate("
                        ++ toString (-centerPoint.x + transform.width / 2 |> floor)
                        ++ " "
                        ++ toString (-centerPoint.y + transform.height / 2 |> floor)
                        ++ ")"
                    )
                ]
                (List.map line lons ++ List.map line lats)
            ]


line : ( Point, Point ) -> Svg msg
line ( p1, p2 ) =
    Svg.line
        [ Svg.Attributes.x1 (toString p1.x)
        , Svg.Attributes.y1 (toString p1.y)
        , Svg.Attributes.x2 (toString p2.x)
        , Svg.Attributes.y2 (toString p2.y)
        , Svg.Attributes.stroke "blue"
        , Svg.Attributes.strokeWidth "1"
        , Svg.Attributes.shapeRendering "crispEdges"
        ]
        []


zoomToAround : Transform -> Float -> Point -> Transform
zoomToAround transform newZoom around =
    let
        transformZoomed =
            { transform | zoom = newZoom }

        centerPoint =
            Transform.locationToPoint transform transform.center

        aroundPoint =
            { x = around.x + centerPoint.x - transform.width / 2
            , y = around.y + centerPoint.y - transform.height / 2
            }

        aroundLocation =
            Transform.pointToLocation transform aroundPoint

        aroundPointZoomed =
            Transform.locationToPoint transformZoomed aroundLocation

        aroundPointDiff =
            { x = aroundPointZoomed.x - aroundPoint.x
            , y = aroundPointZoomed.y - aroundPoint.y
            }

        newCenter =
            Transform.pointToLocation transformZoomed
                { x = centerPoint.x + aroundPointDiff.x
                , y = centerPoint.y + aroundPointDiff.y
                }
    in
        { transform
            | zoom = newZoom
            , center = newCenter
        }
