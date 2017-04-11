module SlippyMap.StaticImage exposing (..)

import SlippyMap.LowLevel as LowLevel
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


tileLayer : Transform -> Svg msg
tileLayer =
    LowLevel.tileLayer tileRenderer


tileRenderer : Tile -> Svg msg
tileRenderer { z, x, y } =
    Svg.image
        [ Svg.Attributes.xlinkHref
            ("//a.tile.openstreetmap.org/"
                ++ toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
                ++ ".png"
            )
        ]
        []
