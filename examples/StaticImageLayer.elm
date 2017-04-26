module StaticImageLayer exposing (..)

import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Layer.LowLevel as Layer
import SlippyMap.Map.LowLevel as Map
import SlippyMap.Map.Static as StaticMap
import Svg exposing (Svg)


main : Svg msg
main =
    StaticMap.view Map.staticConfig
        (StaticMap.center { lon = 7, lat = 51 } 8)
        [ StaticImage.layer
            (StaticImage.url "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
            (Layer.Config
                { attribution = Just "© OpenStreetMap contributors" }
            )
        ]
