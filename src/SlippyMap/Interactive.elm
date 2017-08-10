module SlippyMap.Interactive
    exposing
        ( Config
        , Msg
        , State
        , around
        , center
        , config
        , jumpTo
        , panTo
        , subscriptions
        , update
        , view
        , withCRS
        )

{-|

@docs Config, config, State, center, around, jumpTo, panTo, Msg, update, view, subscriptions, withCRS

-}

import Html exposing (Html)
import SlippyMap.Geo.CRS as CRS exposing (CRS)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Config as Config
import SlippyMap.Map.Msg as Msg
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
config : { width : Int, height : Int } -> (Msg -> msg) -> Config msg
config { width, height } toMsg =
    let
        size =
            { x = toFloat width, y = toFloat height }
    in
    Config <|
        Config.interactive size (Msg >> toMsg)


{-| -}
withCRS : CRS -> Config msg -> Config msg
withCRS crs (Config config) =
    Config <|
        Config.withCRS crs config



-- STATE


{-| -}
type State
    = State State.State


{-| -}
center : Config msg -> Location -> Float -> State
center (Config config) initialCenter initialZoom =
    State.center config initialCenter initialZoom
        |> State


{-| -}
around : Config msg -> Location.Bounds -> State
around (Config config) initialBounds =
    State.around config initialBounds
        |> State


{-| -}
jumpTo : Config msg -> Location -> Float -> State -> State
jumpTo (Config config) center zoom (State state) =
    state
        |> State.setCenter config center
        |> State.setZoom config zoom
        |> State


{-| -}
panTo : Config msg -> Location -> State -> State
panTo config center state =
    update config (Msg <| Msg.PanTo 1000 center) state



-- UPDATE


{-| -}
type Msg
    = Msg Msg.Msg


{-| -}
update : Config msg -> Msg -> State -> State
update (Config config) (Msg msg) (State state) =
    State <|
        Update.update config msg state



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
