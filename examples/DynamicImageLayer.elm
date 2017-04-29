module DynamicImageLayer exposing (..)

import Html exposing (Html)
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Layer.LowLevel as Layer
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
    StaticMap.view mapConfig
        model.mapState
        [ StaticImage.layer
            (StaticImage.url "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
            (Layer.Config
                { attribution = Just "© OpenStreetMap contributors" }
            )
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
