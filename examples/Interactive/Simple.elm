module Interactive.Simple exposing (..)

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Bundle.Interactive as Map
import SlippyMap.Geo.Location as Location exposing (Location)


type alias Model =
    { map : Map.State }


type Msg
    = MapMsg Map.Msg


init : ( Model, Cmd Msg )
init =
    { map =
        Map.at config
            { center = Location 0 0
            , zoom = 3
            }
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
            [ Html.text "Simple interactive map" ]
        , Map.view config
            model.map
            [ Map.tileLayer "http://localhost:9000/styles/positron/{z}/{x}/{y}.png"
                |> Map.withAttribution "© OpenMapTiles © OpenStreetMap contributors"
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
