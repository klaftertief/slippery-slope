module SlippyMap.Map.Static exposing (..)

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.LowLevel as Map exposing (Config, State)
import Svg exposing (Svg)


view : Config -> State -> List (Layer msg) -> Svg msg
view =
    Map.view
