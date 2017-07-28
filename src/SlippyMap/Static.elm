module SlippyMap.Static exposing (view)

{-| Just a static map.

@docs view

-}

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Config as Config
import SlippyMap.Map.State as State
import SlippyMap.Map.View as View


{-| Show a map, no interactions.
-}
view : { width : Int, height : Int } -> Location -> Float -> List (Layer msg) -> Html msg
view { width, height } location zoom =
    let
        config =
            Config.static { x = toFloat width, y = toFloat height }
    in
    View.view config
        (State.center config location zoom)
