module SlippyMap.Interactive
    exposing
        ( Config
        , config
        , State
        , center
        , Msg
        , update
        , view
        , subscriptions
        )

{-|
@docs Config, config, State, center, Msg, update, view, subscriptions
-}

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.Config as Config
import SlippyMap.Map.State as State
import SlippyMap.Map.Subscriptions as Subscriptions
import SlippyMap.Map.Update as Update
import SlippyMap.Map.View as View


-- CONFIG


{-| Configuration for the map.
-}
type Config msg
    = Config (Config.Config msg)


{-| -}
config : (Msg -> msg) -> Config msg
config toMsg =
    Config <|
        Config.dynamicConfig (Msg >> toMsg)



-- STATE


{-| -}
type State
    = State State.State


{-| -}
center : Location -> Float -> State
center initialCenter initialZoom =
    State.defaultState
        |> State.setCenter initialCenter
        |> State.setZoom initialZoom
        |> State



-- UPDATE


{-| -}
type Msg
    = Msg Update.Msg


{-| -}
update : Msg -> State -> State
update (Msg msg) (State state) =
    State <|
        Update.update msg state



-- SUBSCRIPTIONS


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions (Config config) (State state) =
    Subscriptions.subscriptions config state



-- VIEW


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view (Config config) (State state) =
    View.view config state
