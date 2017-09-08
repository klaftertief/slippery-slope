module SlippyMap.Interactive
    exposing
        ( Config
        , Layer
        , Msg
        , State
        , around
        , at
        , config
        , getScene
        , markerLayer
        , setMapState
        , subscriptions
        , tileLayer
        , update
        , view
        )

{-| A convenience module wrapping or re-exposing various specialised functions and types to quickly create a basic interactive map with a default configuration.

@docs Config, config, State, at, around, Msg, update, view, subscriptions, Layer, tileLayer, markerLayer, setMapState, getScene

-}

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer as Layer
import SlippyMap.Layer.Marker.Pin as Marker
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Layer.StaticImage as StaticImageLayer
import SlippyMap.Map.Config as Config
import SlippyMap.Map.Events as Events exposing (Event)
import SlippyMap.Map.Msg as MapMsg
import SlippyMap.Map.State as MapState
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
config size msg =
    Config.interactive (Point.fromSize size)
        (MapMsg >> msg)



-- STATE


{-| -}
type State
    = State
        { mapState : MapState.State
        , popup : Maybe ( Location, String )
        }


{-| -}
at : Config msg -> Scene -> State
at config scene =
    State
        { mapState = MapState.at config scene
        , popup = Nothing
        }


{-| -}
around : Config msg -> Location.Bounds -> State
around config bounds =
    State
        { mapState = MapState.around config bounds
        , popup = Nothing
        }


{-| -}
getScene : State -> Scene
getScene (State { mapState }) =
    MapState.getScene mapState


{-| -}
setMapState : Config msg -> (Config msg -> MapState.State -> MapState.State) -> State -> State
setMapState config f (State state) =
    State
        { state | mapState = f config state.mapState }



-- UPDATE


{-| -}
type Msg
    = MapMsg MapMsg.Msg
    | OpenPopup ( Location, String )
    | ClosePopup


{-| -}
update : Config msg -> Msg -> State -> State
update config msg (State state) =
    case msg of
        MapMsg mapMsg ->
            State
                { state
                    | mapState =
                        Update.update config
                            mapMsg
                            state.mapState
                }

        OpenPopup popup ->
            State { state | popup = Just popup }

        ClosePopup ->
            State { state | popup = Nothing }



-- SUBSCRIPTIONS


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions config (State { mapState }) =
    Subscriptions.subscriptions config mapState



-- VIEW


{-| TODO: Do not depend on `toMsg`, this should go into a wrapped Config.
-}
view : (Msg -> msg) -> Config msg -> State -> List (Event msg) -> List (Layer msg) -> Html msg
view toMsg config (State { mapState, popup }) events layers =
    let
        popupLayers =
            popup
                |> Maybe.map
                    (\p ->
                        [ Popup.layer
                            (Popup.withCloseMsg (toMsg ClosePopup)
                                Popup.config
                            )
                            [ p ]
                        ]
                    )
                |> Maybe.withDefault []
    in
    View.viewWithEvents config mapState events (layers ++ popupLayers)



-- LAYER


{-| -}
type alias Layer msg =
    Layer.Layer msg


{-| -}
tileLayer : Layer msg
tileLayer =
    StaticImageLayer.layer
        (StaticImageLayer.config "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ])
        |> Layer.withAttribution "© OpenStreetMap contributors"


{-| -}
markerLayer : (Msg -> msg) -> List ( Location, String ) -> Layer msg
markerLayer toMsg locations =
    Marker.individualMarker Tuple.first
        (\( location, title ) ->
            Marker.icon
                |> Marker.onClick
                    (toMsg <| OpenPopup ( location, title ))
        )
        locations
