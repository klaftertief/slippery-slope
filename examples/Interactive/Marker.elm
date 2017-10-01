module Interactive.Marker exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Set exposing (Set)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Interactive as Map
import SlippyMap.Layer.Marker.Circle as Marker
import SlippyMap.Map.Config as MapConfig
import SlippyMap.Map.State as MapState


type alias Model =
    { map : Map.State
    , pois : List Poi
    }


type alias Poi =
    { name : String
    , location : Location
    , selected : Bool
    }


type Msg
    = MapMsg Map.Msg
    | ToggleSelected String


init : ( Model, Cmd Msg )
init =
    { map = Map.around config (bounds initialPois)
    , pois = initialPois
    }
        ! []


initialPois : List Poi
initialPois =
    [ Poi "London" (Location 0.1275 51.507222) False
    , Poi "Madrid" (Location -3.716667 40.383333) False
    , Poi "Berlin" (Location 13.383333 52.516667) False
    ]


bounds : List Poi -> Location.Bounds
bounds pois =
    case Location.maybeBounds (List.map .location pois) of
        Just bounds ->
            bounds

        Nothing ->
            { southWest = Location -11 35
            , northEast = Location 32 58
            }


selectionBounds : List Poi -> Location.Bounds
selectionBounds pois =
    bounds (List.filter .selected pois)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            ( { model
                | map =
                    Map.update config
                        mapMsg
                        model.map
              }
            , Cmd.none
            )

        ToggleSelected name ->
            let
                newPois =
                    List.map (toggle name) model.pois

                newMap =
                    MapState.animate 1800
                        (MapState.fitBounds config
                            (selectionBounds newPois)
                        )
                        model.map
            in
            ( { model
                | pois = newPois
                , map = newMap
              }
            , Cmd.none
            )


toggle : String -> Poi -> Poi
toggle name poi =
    if poi.name == name then
        { poi | selected = not poi.selected }
    else
        poi


config : Map.Config Msg
config =
    Map.config { width = 600, height = 400 } MapMsg
        |> MapConfig.withMaxZoom 9


subscriptions : Model -> Sub Msg
subscriptions model =
    Map.subscriptions config model.map


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.style
            [ ( "padding", "1.5rem" ) ]
        ]
        [ Html.h1 []
            [ Html.text "List of Pois with different markers" ]
        , viewMap model
        , viewPois model
        ]


viewMap : Model -> Html Msg
viewMap model =
    Map.view
        config
        model.map
        [ Map.tileLayer "http://localhost:9000/styles/positron/{z}/{x}/{y}.png"
            |> Map.withAttribution "© OpenMapTiles © OpenStreetMap contributors"
        , Marker.individualMarker .location
            (always Marker.icon)
            [ Marker.onClick (.name >> ToggleSelected) ]
            model.pois
        ]


viewPois : Model -> Html Msg
viewPois model =
    Html.div []
        (List.map viewPoi model.pois)


viewPoi : Poi -> Html Msg
viewPoi poi =
    let
        background =
            if poi.selected then
                "#ccc"
            else
                "transparent"
    in
    Html.div
        [ Html.Events.onClick (ToggleSelected poi.name)
        , Html.Attributes.style
            [ ( "background", background ) ]
        ]
        [ Html.text poi.name ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
