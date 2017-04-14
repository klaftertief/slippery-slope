module LowLevel exposing (..)

import Shared
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.LowLevel as LowLevel
import Svg exposing (Svg)
import Svg.Attributes


view : Transform -> Svg msg
view transform =
    LowLevel.container transform
        [ LowLevel.tileLayer identity (tile transform) transform
        , LowLevel.gridLayer transform
        , LowLevel.markerLayer marker
            transform
            [ { lon = 6, lat = 50 }
            , { lon = 7, lat = 51 }
            , { lon = 8, lat = 52 }
            ]
        ]


marker : Svg msg
marker =
    Svg.circle
        [ Svg.Attributes.r "8"
        , Svg.Attributes.fill "green"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.strokeWidth "2"
        ]
        []


tile : Transform -> Tile -> Svg msg
tile { tileSize } { z, x, y } =
    let
        key =
            toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
    in
        Svg.g []
            [ Svg.rect
                [ Svg.Attributes.width (toString tileSize)
                , Svg.Attributes.height (toString tileSize)
                , Svg.Attributes.fill "none"
                , Svg.Attributes.stroke "red"
                ]
                []
            , Svg.text_
                [ Svg.Attributes.x "10"
                , Svg.Attributes.y "20"
                ]
                [ Svg.text key ]
            ]


main : Svg msg
main =
    view Shared.transform
