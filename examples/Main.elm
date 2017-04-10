module Main exposing (..)

import Geo.PixelPoint as PixelPoint exposing (PixelPoint)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode as Json
import SlippyMap
import Svg exposing (Svg)
import Svg.Attributes
import String


type alias Model =
    SlippyMap.MapConfig


type Msg
    = ZoomTo Float
    | ZoomInAround PixelPoint
    | LonTo Float
    | LatTo Float


init : ( Model, Cmd Msg )
init =
    initialMapConfig ! []


initialMapConfig : SlippyMap.MapConfig
initialMapConfig =
    { width = 600
    , height = 400
    , center =
        { lon = 7
        , lat = 51
        }
    , zoom = 5
    , bearing = 0
    }


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.style
            [ ( "margin", "50px" )
            , ( "position", "relative" )
            ]
        ]
        [ SlippyMap.container model []
        , Html.div
            [ Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "left", "0" )
                , ( "top", "0" )
                , ( "width", "600px" )
                , ( "height", "400px" )
                ]
            , Html.Events.on "click"
                (clientPosition |> Json.map ZoomInAround)
            ]
            []
        , Html.div []
            [ Html.input
                [ Html.Attributes.type_ "range"
                , Html.Attributes.min "4"
                , Html.Attributes.max "8"
                , Html.Attributes.step "0.01"
                , Html.Attributes.value (toString model.zoom)
                , Html.Events.on "input" (targetFloat model.zoom |> Json.map ZoomTo)
                ]
                []
            , Html.input
                [ Html.Attributes.type_ "range"
                , Html.Attributes.min "0"
                , Html.Attributes.max "20"
                , Html.Attributes.step "0.1"
                , Html.Attributes.value (toString model.center.lon)
                , Html.Events.on "input" (targetFloat model.center.lon |> Json.map LonTo)
                ]
                []
            , Html.input
                [ Html.Attributes.type_ "range"
                , Html.Attributes.min "40"
                , Html.Attributes.max "60"
                , Html.Attributes.step "0.1"
                , Html.Attributes.value (toString model.center.lat)
                , Html.Events.on "input" (targetFloat model.center.lat |> Json.map LatTo)
                ]
                []
            ]
        , Html.div []
            [ Html.text <| toString model ]
        , SlippyMap.staticMap
            [ SlippyMap.size ( 360, 360 )
            , SlippyMap.zoom 4
            ]
            []
        ]


targetFloat : Float -> Json.Decoder Float
targetFloat currentValue =
    Html.Events.targetValue
        |> Json.map (String.toFloat >> Result.withDefault currentValue)


clientPosition : Json.Decoder PixelPoint
clientPosition =
    Json.map2 PixelPoint
        (Json.field "offsetX" Json.int)
        (Json.field "offsetY" Json.int)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ZoomTo zoom ->
            { model | zoom = zoom } ! []

        ZoomInAround aroundPoint ->
            let
                newZoom =
                    model.zoom + 0.05
            in
                SlippyMap.zoomToAround model newZoom aroundPoint
                    ! []

        LonTo lon ->
            { model
                | center =
                    { lon = lon, lat = model.center.lat }
            }
                ! []

        LatTo lat ->
            { model
                | center =
                    { lon = model.center.lon, lat = lat }
            }
                ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
