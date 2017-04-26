module DynamicImageLayer exposing (..)

import Html exposing (Html)
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Layer.LowLevel as Layer
import SlippyMap.Map.LowLevel as Map
import SlippyMap.Map.Static as StaticMap


type alias Model =
    { mapState : Map.State }


type Msg
    = NewMapState Map.State


init : ( Model, Cmd Msg )
init =
    Model (StaticMap.center { lon = 7, lat = 51 } 8)
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewMapState newMapState ->
            Model newMapState ! []


view : Model -> Html Msg
view model =
    StaticMap.view (Map.dynamicConfig NewMapState)
        model.mapState
        [ StaticImage.layer
            (StaticImage.url "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")
            (Layer.Config
                { attribution = Just "© OpenStreetMap contributors" }
            )
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
