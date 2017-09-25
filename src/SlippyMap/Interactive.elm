module SlippyMap.Interactive
    exposing
        ( Config
        , Layer
        , Msg
        , State
        , around
        , at
        , closePopup
        , config
        , geoJsonLayer
        , getScene
        , markerLayer
        , on
        , popupLayer
        , setMapState
        , subscriptions
        , tileLayer
        , update
        , view
        , viewWithEvents
        , withAttribution
        )

{-| A convenience module wrapping or re-exposing various specialised functions and types to quickly create a basic interactive map with a default configuration.

@docs Config, config, State, at, around, Msg, update, view, viewWithEvents, subscriptions, Layer, tileLayer, markerLayer, setMapState, getScene, closePopup, geoJsonLayer, popupLayer, withAttribution, on

-}

import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Json.Decode exposing (Decoder)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer as Layer
import SlippyMap.Layer.GeoJson as GeoJson
import SlippyMap.Layer.Marker.Circle as Marker
import SlippyMap.Layer.Marker.Pin as PinMarker
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Layer.StaticImage as StaticImageLayer
import SlippyMap.Map.Config as Config
import SlippyMap.Map.Events as Events exposing (Event, MapEvent)
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
            closePopup (State state)


{-| -}
closePopup : State -> State
closePopup (State state) =
    State { state | popup = Nothing }



-- SUBSCRIPTIONS


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions config (State { mapState }) =
    Subscriptions.subscriptions config mapState



-- VIEW


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view config (State { mapState }) layers =
    View.view config mapState layers


{-| -}
viewWithEvents : Config msg -> State -> List (MapEvent msg) -> List (Layer msg) -> Html msg
viewWithEvents config (State { mapState }) events layers =
    View.viewWithEvents config mapState events layers


{-| -}
on : String -> (( Point, Location ) -> Decoder msg) -> Event ( Point, Location ) msg
on =
    Events.on


{-| TODO: Do not depend on `toMsg`, this should go into a wrapped Config.
-}
viewWithMsg : (Msg -> msg) -> Config msg -> State -> List (Event ( Point, Location ) msg) -> List (Layer msg) -> Html msg
viewWithMsg toMsg config (State { mapState, popup }) events layers =
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
tileLayer : String -> Layer msg
tileLayer urlTemplate =
    StaticImageLayer.layer
        (StaticImageLayer.config urlTemplate [])


{-| -}
markerLayer : List Location -> Layer msg
markerLayer locations =
    Marker.marker locations


{-| -}
geoJsonLayer : GeoJson -> Layer msg
geoJsonLayer =
    GeoJson.layer (GeoJson.defaultConfig (always []))


{-| -}
popupLayer : List ( Location, String ) -> Layer msg
popupLayer =
    Popup.layer Popup.config


{-| TODO: Do not depend on `toMsg`, this should go into a wrapped Config.
-}
markerPopupLayer : (Msg -> msg) -> List ( Location, String ) -> Layer msg
markerPopupLayer toMsg locations =
    PinMarker.individualMarker Tuple.first
        (\( location, title ) ->
            PinMarker.icon
                |> PinMarker.onClick
                    (toMsg <| OpenPopup ( location, title ))
        )
        locations


{-| -}
withAttribution : String -> Layer msg -> Layer msg
withAttribution =
    Layer.withAttribution
