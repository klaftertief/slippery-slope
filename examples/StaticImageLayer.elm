module StaticImageLayer exposing (..)

import Shared
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Map.Static as StaticMap
import Svg exposing (Svg)


main : Svg msg
main =
    StaticMap.container
        Shared.transform
        [ StaticImage.layer
            (StaticImage.url "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
        ]
