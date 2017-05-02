module DynamicImageLayer exposing (..)

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Layer.Grid as Grid
import SlippyMap.Layer.LowLevel as Layer
import SlippyMap.Layer.Marker as Marker
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Map.LowLevel as Map
import SlippyMap.Map.Static as StaticMap


type alias Model =
    { mapState : Map.State }


type Msg
    = MapMsg Map.Msg


init : ( Model, Cmd Msg )
init =
    Model (StaticMap.center { lon = 7, lat = 51 } 8)
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            let
                newMapState =
                    Map.update mapMsg model.mapState
            in
                Model newMapState ! []


mapConfig : Map.Config Msg
mapConfig =
    Map.dynamicConfig MapMsg


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "padding", "50px" ) ] ]
        [ StaticMap.view mapConfig
            model.mapState
            [ StaticImage.layer
                (StaticImage.withUrl "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ])
                (Layer.withAttribution "© OpenStreetMap contributors")
            , Grid.layer Grid.defaultConfig
            , Marker.simpleLayer Marker.defaultConfig
                [ { lon = 6, lat = 50 }
                , { lon = 7, lat = 51 }
                , { lon = 8, lat = 52 }
                ]
            ]
        , Html.div []
            [ Html.text (toString model.mapState) ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Map.subscriptions mapConfig model.mapState


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
