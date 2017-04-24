module StaticImageLayer exposing (..)

import Shared
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Layer.LowLevel as Layer
import SlippyMap.Map.LowLevel as Map exposing (Config(Config), State(State))
import SlippyMap.Map.Static as StaticMap
import Svg exposing (Svg)


main : Svg msg
main =
    StaticMap.view
        (Config
            { attributionPrefix = Nothing
            , minZoom = 0
            , maxZoom = 22
            }
        )
        (State
            { transform = Shared.transform
            , attributions = []
            }
        )
        [ StaticImage.layer
            (StaticImage.url "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
            (Layer.Config
                { attribution = Nothing }
            )
        ]
