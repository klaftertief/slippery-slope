module Interactive exposing (..)

import Html
import Shared
import SlippyMap.Geo.Point as Point exposing (Point)
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
    | ZoomInAround Point


model : Model
model =
    Shared.transform


view : Model -> Svg Msg
view model =
    LowLevel.container model
        [ StaticImage.tileLayer model
        , zoomControls
        , Svg.text_
            [ Svg.Events.onClick (ZoomInAround { x = 10, y = 200 })
            , Svg.Attributes.transform "translate(10, 200)"
            ]
            [ Svg.text "000" ]
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
            , Svg.Attributes.x "12"
            , Svg.Attributes.y "16"
            , Svg.Attributes.textAnchor "middle"
            ]
            [ Svg.text "+" ]
        , Svg.text_
            [ Svg.Events.onClick ZoomOut
            , Svg.Attributes.x "12"
            , Svg.Attributes.y "36"
            , Svg.Attributes.textAnchor "middle"
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

        ZoomInAround point ->
            zoomToAround model (model.zoom + 0.1) point


zoomToAround : Transform -> Float -> Point -> Transform
zoomToAround transform newZoom around =
    let
        transformZoomed =
            { transform | zoom = newZoom }

        centerPoint =
            Transform.locationToPoint transform transform.center

        aroundPoint =
            { x = around.x + centerPoint.x - transform.width / 2
            , y = around.y + centerPoint.y - transform.height / 2
            }

        aroundLocation =
            Transform.pointToLocation transform aroundPoint

        aroundPointZoomed =
            Transform.locationToPoint transformZoomed aroundLocation

        aroundPointDiff =
            { x = aroundPointZoomed.x - aroundPoint.x
            , y = aroundPointZoomed.y - aroundPoint.y
            }

        newCenter =
            Transform.pointToLocation transformZoomed
                { x = centerPoint.x + aroundPointDiff.x
                , y = centerPoint.y + aroundPointDiff.y
                }
    in
        { transform
            | zoom = newZoom
            , center = newCenter
        }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }
