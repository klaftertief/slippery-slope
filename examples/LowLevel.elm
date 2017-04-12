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
        [ LowLevel.tileLayer (tile transform) transform
        , LowLevel.gridLayer transform
        ]


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
