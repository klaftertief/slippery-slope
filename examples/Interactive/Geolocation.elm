module Interactive.Geolocation exposing (..)

import Geolocation
import Html exposing (Html)
import Html.Attributes
import Html.Events
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Interactive as Map
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Circle as Circle
import SlippyMap.Layer.Marker.Circle as Marker
import SlippyMap.Map.State as MapState
import Task


type alias Model =
    { map : Map.State
    , userLocation : Maybe Geolocation.Location
    }


type Msg
    = MapMsg Map.Msg
    | LocationChange Geolocation.Location
    | RequestLocation
    | RequestLocationResponse (Result Geolocation.Error Geolocation.Location)


init : ( Model, Cmd Msg )
init =
    { map =
        Map.at config
            { center = Location 0 0
            , zoom = 3
            }
    , userLocation = Nothing
    }
        ! []


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

        LocationChange location ->
            let
                newMap =
                    MapState.setScene
                        --config
                        { center = toLocation location
                        , zoom = 15
                        }
                        model.map
            in
            { model
                | map = newMap
                , userLocation = Just location
            }
                ! []

        RequestLocation ->
            model ! [ Task.attempt RequestLocationResponse Geolocation.now ]

        RequestLocationResponse response ->
            case response of
                Ok location ->
                    let
                        newMap =
                            MapState.setScene
                                --config
                                { center = toLocation location
                                , zoom = 15
                                }
                                model.map
                    in
                    { model
                        | map = newMap
                        , userLocation = Just location
                    }
                        ! []

                Err err ->
                    let
                        _ =
                            Debug.log "location error" err
                    in
                    model ! []


config : Map.Config Msg
config =
    Map.config { width = 600, height = 400 } MapMsg


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Map.subscriptions config model.map
        , Geolocation.changes LocationChange
        ]


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.style
            [ ( "padding", "1.5rem" ) ]
        ]
        [ Html.h1 []
            [ Html.text "Interactive map with user location" ]
        , viewMap model
        , Html.p []
            [ Html.button
                [ Html.Events.onClick RequestLocation ]
                [ Html.text "Where am I?" ]
            ]
        ]


viewMap : Model -> Html Msg
viewMap model =
    let
        userLayer =
            Maybe.map toUserLayer model.userLocation
                |> Maybe.withDefault []
    in
    Map.view config
        model.map
        (Map.tileLayer :: userLayer)


toUserLayer : Geolocation.Location -> List (Layer msg)
toUserLayer ({ accuracy } as geolocation) =
    let
        location =
            toLocation geolocation
    in
    [ Circle.layer (Circle.config (accuracy / 1000)) location
    , Marker.marker [ location ]
    ]


toLocation : Geolocation.Location -> Location
toLocation { longitude, latitude } =
    Location longitude latitude


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
