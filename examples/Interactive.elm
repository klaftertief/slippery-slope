module Interactive exposing (..)

import Html
import Shared
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.StaticImage as StaticImage
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events


type alias Model =
    Transform


type Msg
    = ZoomIn
    | ZoomOut


model : Model
model =
    Shared.transform


view : Model -> Svg Msg
view model =
    LowLevel.container model
        [ StaticImage.tileLayer model
        , zoomControls
        ]


zoomControls : Svg Msg
zoomControls =
    Svg.g [ Svg.Attributes.transform "translate(10, 10)" ]
        [ Svg.rect
            [ Svg.Attributes.width "24"
            , Svg.Attributes.height "48"
            , Svg.Attributes.rx "2"
            , Svg.Attributes.ry "2"
            , Svg.Attributes.fill "white"
            , Svg.Attributes.stroke "grey"
            ]
            []
        , Svg.text_
            [ Svg.Events.onClick ZoomIn
            , Svg.Attributes.x "8"
            , Svg.Attributes.y "16"
            ]
            [ Svg.text "+" ]
        , Svg.text_
            [ Svg.Events.onClick ZoomOut
            , Svg.Attributes.x "8"
            , Svg.Attributes.y "36"
            ]
            [ Svg.text "-" ]
        ]


update : Msg -> Model -> Model
update msg model =
    case msg of
        ZoomIn ->
            { model | zoom = model.zoom + 1 }

        ZoomOut ->
            { model | zoom = model.zoom - 1 }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
