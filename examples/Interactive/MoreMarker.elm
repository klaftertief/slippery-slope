module Interactive.MoreMarker exposing (..)

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Interactive as Map
import SlippyMap.Layer.Marker.Circle as Marker
import SlippyMap.Map.Config as MapConfig


type alias Model =
    { map : Map.State
    , pois : List Poi
    }


type alias Poi =
    { name : String
    , location : Location
    }


type Msg
    = MapMsg Map.Msg
    | AddPoi Poi


init : ( Model, Cmd Msg )
init =
    { map =
        Map.around config
            { southWest = Location -11 35
            , northEast = Location 32 58
            }
    , pois = initialPois
    }
        ! []


initialPois : List Poi
initialPois =
    [ Poi "London" (Location 0.1275 51.507222)
    , Poi "Madrid" (Location -3.716667 40.383333)
    , Poi "Berlin" (Location 13.383333 52.516667)
    ]


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

        AddPoi poi ->
            { model | pois = poi :: model.pois } ! []


config : Map.Config Msg
config =
    Map.config { width = 600, height = 400 } MapMsg
        |> MapConfig.onClick (Poi "Custom" >> AddPoi)


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
            [ Html.text "Interactive map with marker playground" ]
        , Map.view config
            model.map
            [ Map.tileLayer
            , Marker.layer (List.map .location model.pois)
            ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
