module SlippyMap.Interactive
    exposing
        ( Config
        , Msg
        , State
        , around
        , at
        , config
        , subscriptions
        , update
        , view
        )

{-|

@docs Config, config, State, at, around, Msg, update, view, subscriptions

-}

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Config as Config
import SlippyMap.Map.Msg as Msg
import SlippyMap.Map.State as State
import SlippyMap.Map.Subscriptions as Subscriptions
import SlippyMap.Map.Types as Types exposing (Scene, Size)
import SlippyMap.Map.Update as Update
import SlippyMap.Map.View as View


-- CONFIG


{-| -}
type alias Config msg =
    Config.Config msg


{-| -}
config : Size -> (Msg -> msg) -> Config msg
config size =
    Config.interactive (Point.fromSize size)



-- STATE


{-| -}
type alias State =
    State.State


{-| -}
at : Config msg -> Scene -> State
at =
    State.at


{-| -}
around : Config msg -> Location.Bounds -> State
around =
    State.around



-- UPDATE


{-| -}
type alias Msg =
    Msg.Msg


{-| -}
update : Config msg -> Msg -> State -> State
update =
    Update.update



-- SUBSCRIPTIONS


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions =
    Subscriptions.subscriptions



-- VIEW


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view =
    View.view
