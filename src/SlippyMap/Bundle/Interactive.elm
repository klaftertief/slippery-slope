module SlippyMap.Bundle.Interactive
    exposing
        ( Config
        , Layer
        , Msg
        , State
        , around
        , at
        , config
        , geoJsonLayer
        , markerLayer
        , on
        , popupLayer
        , subscriptions
        , tileLayer
        , update
        , view
        , viewWithEvents
        , withAttribution
        )

{-| A convenience module wrapping or re-exposing various specialised functions and types to quickly create a basic interactive map with a default configuration.

@docs Config, config, State, at, around, Msg, update, view, viewWithEvents, subscriptions, Layer, tileLayer, markerLayer, geoJsonLayer, popupLayer, withAttribution, on

-}

import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Json.Decode exposing (Decoder)
import SlippyMap.Config as Config
import SlippyMap.Events as Events exposing (Event, MapEvent)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer as Layer
import SlippyMap.Layer.GeoJson as GeoJson
import SlippyMap.Layer.Marker.Circle as Marker
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Layer.StaticImage as StaticImageLayer
import SlippyMap.Msg as MapMsg
import SlippyMap.State as MapState
import SlippyMap.Subscriptions as Subscriptions
import SlippyMap.Types exposing (Scene, Size)
import SlippyMap.Update as Update
import SlippyMap.View as View


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
    MapState.State


{-| -}
at : Config msg -> Scene -> State
at =
    MapState.at


{-| -}
around : Config msg -> Location.Bounds -> State
around =
    MapState.around



-- UPDATE


{-| -}
type alias Msg =
    MapMsg.Msg


{-| -}
update : Config msg -> Msg -> State -> State
update config msg state =
    Update.update config msg state
        |> Tuple.first



-- SUBSCRIPTIONS


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions =
    Subscriptions.subscriptions



-- VIEW


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view config state layers =
    View.view config state layers
        |> Tuple.first


{-| -}
viewWithEvents : Config msg -> State -> List (MapEvent msg) -> List (Layer msg) -> Html msg
viewWithEvents config state events layers =
    View.viewWithEvents config state events layers
        |> Tuple.first


{-| -}
on : String -> (( Point, Location ) -> Decoder msg) -> Event ( Point, Location ) msg
on =
    Events.on



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


{-| -}
withAttribution : String -> Layer msg -> Layer msg
withAttribution =
    Layer.withAttribution
