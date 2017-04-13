module SlippyMap.LowLevel exposing (..)

import SlippyMap.Geo.PixelPoint as PixelPoint exposing (PixelPoint)
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
tileLayer toRender renderer transform =
    let
        scale =
            Transform.zoomScale
                (toFloat (floor transform.zoom) - transform.zoom)

        centerPoint =
            Transform.locationToPixelPoint transform transform.center
                |> (\{ x, y } -> { x = toFloat x, y = toFloat y })

        topLeftCoordinate =
            Transform.pixelPointToCoordinate transform
                ({ x = centerPoint.x - transform.width / 2
                 , y = centerPoint.y - transform.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bottomRightCoordinate =
            Transform.pixelPointToCoordinate transform
                ({ x = centerPoint.x + transform.width / 2
                 , y = centerPoint.y + transform.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
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
        Svg.Keyed.node "g"
            [ Svg.Attributes.transform
                (""
                    ++ " translate("
                    ++ toString centerPoint.x
                    ++ " "
                    ++ toString centerPoint.y
                    ++ ")"
                    ++ " "
                    ++ "scale("
                    ++ toString scale
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString -centerPoint.x
                    ++ " "
                    ++ toString -centerPoint.y
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString ((transform.width / 2 - centerPoint.x) / scale)
                    ++ " "
                    ++ toString ((transform.height / 2 - centerPoint.y) / scale)
                    ++ ")"
                )
            ]
            (List.map (tile (toRender >> renderer) transform) tiles)


tile : (Tile -> Svg msg) -> Transform -> Tile -> ( String, Svg msg )
tile renderer transform ({ z, x, y } as tile) =
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
            Transform.coordinateToPixelPoint transform tileCoordinate
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
            [ renderer tile ]
        )


gridLayer : Transform -> Svg msg
gridLayer transform =
    let
        centerPoint =
            Transform.locationToPixelPoint transform transform.center

        nw =
            { x = toFloat centerPoint.x - transform.width / 2
            , y = toFloat centerPoint.y - transform.height / 2
            }
                |> (\{ x, y } -> { x = floor x, y = floor y })
                |> Transform.pixelPointToLocation transform

        se =
            { x = toFloat centerPoint.x + transform.width / 2
            , y = toFloat centerPoint.y + transform.height / 2
            }
                |> (\{ x, y } -> { x = floor x, y = floor y })
                |> Transform.pixelPointToLocation transform

        lons =
            List.range (floor nw.lon) (ceiling se.lon)
                |> List.map toFloat
                |> List.map
                    (\lon ->
                        ( Transform.locationToPixelPoint transform
                            { lon = lon, lat = se.lat }
                        , Transform.locationToPixelPoint transform
                            { lon = lon, lat = nw.lat }
                        )
                    )

        lats =
            List.range (floor se.lat) (ceiling nw.lat)
                |> List.map toFloat
                |> List.map
                    (\lat ->
                        ( Transform.locationToPixelPoint transform
                            { lon = nw.lon, lat = lat }
                        , Transform.locationToPixelPoint transform
                            { lon = se.lon, lat = lat }
                        )
                    )
    in
        Svg.g []
            [ Svg.g
                [ Svg.Attributes.transform ("translate(" ++ toString (toFloat -centerPoint.x + transform.width / 2 |> floor) ++ " " ++ toString (toFloat -centerPoint.y + transform.height / 2 |> floor) ++ ")") ]
                (List.map line lons ++ List.map line lats)
            ]


line : ( PixelPoint, PixelPoint ) -> Svg msg
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
