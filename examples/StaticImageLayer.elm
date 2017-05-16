module StaticImageLayer exposing (..)

import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Static as Map
import Svg exposing (Svg)


main : Svg msg
main =
    Map.view
        (Map.center { lon = 7, lat = 51 } 8)
        [ StaticImage.layer
            (StaticImage.config "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ]
                |> StaticImage.withAttribution "© OpenStreetMap contributors"
            )
        ]
