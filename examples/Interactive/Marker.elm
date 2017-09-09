module Interactive.Marker exposing (..)

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Set exposing (Set)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Interactive as Map
import SlippyMap.Layer.Marker.Circle as Marker
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Map.State as MapState


type alias Model =
    { map : Map.State
    , pois : List Poi
    , poiSelection : Set Int
    }


type alias Poi =
    { name : String
    , location : Location
    }


type Msg
    = MapMsg Map.Msg
    | Select Int
    | Deselect Int


init : ( Model, Cmd Msg )
init =
    { map = Map.around config (bounds initialPois)
    , pois = initialPois
    , poiSelection = Set.empty
    }
        ! []


initialPois : List Poi
initialPois =
    [ Poi "London" (Location 0.1275 51.507222)
    , Poi "Madrid" (Location -3.716667 40.383333)
    , Poi "Berlin" (Location 13.383333 52.516667)
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


selectionBounds : Set Int -> List Poi -> Location.Bounds
selectionBounds selection pois =
    let
        selectionList =
            Set.toList selection

        selectedPois =
            pois
                |> List.indexedMap
                    (\index poi ->
                        if List.member index selectionList then
                            Just poi
                        else
                            Nothing
                    )
                |> List.filterMap identity
    in
    bounds selectedPois


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            { model
                | map =
                    Map.update config
                        mapMsg
                        model.map
            }
                ! []

        Select index ->
            updateSelection Set.insert index model ! []

        Deselect index ->
            updateSelection Set.remove index model
                ! []


updateSelection : (Int -> Set Int -> Set Int) -> Int -> Model -> Model
updateSelection updater index model =
    let
        newSelection =
            updater index model.poiSelection

        newMap =
            Map.setMapState config
                (flip MapState.fitBounds
                    (selectionBounds newSelection model.pois)
                )
                model.map
    in
    { model
        | poiSelection = newSelection
        , map = newMap
    }


config : Map.Config Msg
config =
    Map.config { width = 600, height = 400 } MapMsg


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
    Map.view MapMsg
        config
        model.map
        []
        [ Map.tileLayer

        -- , Marker.marker (List.map .location model.pois)
        -- , Popup.layer Popup.config [ ( Location -3.716667 40.383333, "I popped up, merry poppin!" ) ]
        , Map.markerLayer MapMsg
            (List.map
                (\p -> ( p.location, p.name ))
                model.pois
            )
        ]


viewPois : Model -> Html Msg
viewPois model =
    Html.div []
        (List.indexedMap (viewPoi model.poiSelection) model.pois)


viewPoi : Set Int -> Int -> Poi -> Html Msg
viewPoi selection index poi =
    let
        isSelected =
            Set.member index selection

        ( background, toggle ) =
            if isSelected then
                ( "#ccc", Deselect )
            else
                ( "transparent", Select )
    in
    Html.div
        [ Html.Events.onClick (toggle index)
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
