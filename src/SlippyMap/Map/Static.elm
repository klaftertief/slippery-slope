module SlippyMap.Map.Static exposing (view, center)

{-| Just a static map.

@docs view, center
-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.LowLevel as Map exposing (Config, State)
import Svg exposing (Svg)


{-| -}
center : Location -> Float -> State
center =
    Map.center


{-| -}
view : Config msg -> State -> List (Layer msg) -> Svg msg
view =
    Map.view
