module SlippyMap.Static
    exposing
        ( around
        , at
        , tileLayer
        )

{-| Just a static map.

@docs at, around, tileLayer

-}

import Html exposing (Html)
import SlippyMap.Geo.Location as Location
import SlippyMap.Geo.Point as Point
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.StaticImage as StaticImageLayer
import SlippyMap.Map.Config as Config
import SlippyMap.Map.State as State
import SlippyMap.Map.Types as Types exposing (Scene, Size)
import SlippyMap.Map.View as View


-- VIEW


{-| Render a map at a given center and zoom.
-}
at : Size -> Scene -> List (Layer msg) -> Html msg
at size scene =
    let
        config =
            Config.static (Point.fromSize size)
    in
    View.view config
        (State.at config scene)


{-| Render a map around given bounds.
-}
around : Size -> Location.Bounds -> List (Layer msg) -> Html msg
around size bounds =
    let
        config =
            Config.static (Point.fromSize size)
    in
    View.view config
        (State.around config bounds)



-- LAYER


{-| -}
tileLayer : Layer msg
tileLayer =
    StaticImageLayer.layer
        (StaticImageLayer.config "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ])
        |> Layer.withAttribution "© OpenStreetMap contributors"
