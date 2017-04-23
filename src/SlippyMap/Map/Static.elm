module SlippyMap.Map.Static exposing (..)

import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes


container : Transform -> List (Layer msg) -> Svg msg
container ({ width, height } as transform) layers =
    Svg.svg
        [ Svg.Attributes.height (toString height)
        , Svg.Attributes.width (toString width)
        ]
        (List.map ((|>) transform) layers)
