module Static exposing (..)

import Shared
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.StaticImage as StaticImage
import Svg exposing (Svg)
import Svg.Attributes


view : Transform -> Svg msg
view transform =
    LowLevel.container transform
        [ StaticImage.tileLayer transform ]


main : Svg msg
main =
    view Shared.transform
