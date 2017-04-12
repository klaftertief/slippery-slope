module SlippyMap.StaticImage exposing (tileLayer)

import SlippyMap.LowLevel as LowLevel
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


tileLayer : Transform -> Svg msg
tileLayer transform =
    LowLevel.tileLayer (tileRenderer transform) transform


tileRenderer : Transform -> Tile -> Svg msg
tileRenderer transform { z, x, y } =
    Svg.image
        [ Svg.Attributes.width (toString transform.tileSize)
        , Svg.Attributes.height (toString transform.tileSize)
        , Svg.Attributes.xlinkHref
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
