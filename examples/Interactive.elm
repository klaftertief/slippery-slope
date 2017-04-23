module Interactive exposing (..)

import Collage
import Color
import Data
import Element
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Mouse exposing (Position)
import Shared
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.StaticImage as StaticImage
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events


type alias Model =
    { transform : Transform
    , drag : Maybe Drag
    }


type alias Drag =
    { last : Position
    , current : Position
    }


type Msg
    = ZoomIn
    | ZoomOut
    | ZoomInAround Point
    | ZoomByAround Float Point
    | DragMsg DragMsg


type DragMsg
    = DragStart Position
    | DragAt Position
    | DragEnd Position


init : ( Model, Cmd Msg )
init =
    { transform = Shared.transform
    , drag = Nothing
    }
        ! []


view : Model -> Svg Msg
view model =
    Html.div []
        [ LowLevel.container model.transform
            [ StaticImage.tileLayer model.transform
            , LowLevel.overlayLayer model.transform
                [ ( { southWest = { lon = -74.22655, lat = 40.712216 }
                    , northEast = { lon = -74.12544, lat = 40.773941 }
                    }
                  , "http://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg"
                  )
                ]
            , zoomControls
            ]

        --, heatmapLayer model
        --, collageLayer model
        , gestureLayer model
        ]


heatmapLayer : Model -> Html Msg
heatmapLayer model =
    let
        heatmapMatrix =
            """
            0 0 0 0 1
            0 0 0 -1 1
            0 0 0 0 0
            0 0 0 1 0
            """

        --heatmapMatrix =
        --    """
        --    0 0 0 0 0
        --    0 0 0 0 0
        --    0 0 0 0 0
        --    0 0 0 1 0
        --    """
        locationData =
            Data.locationData

        project location =
            let
                centerPoint =
                    Transform.locationToPoint model.transform model.transform.center

                point =
                    Transform.locationToPoint model.transform location
            in
                { x = point.x - centerPoint.x + model.transform.width / 2
                , y = point.y - centerPoint.y + model.transform.height / 2
                }
    in
        Html.div
            [ Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "pointer-events", "none" )
                , ( "top", "0" )
                , ( "left", "0" )
                , ( "width", toString model.transform.width ++ "px" )
                , ( "height", toString model.transform.height ++ "px" )
                ]
            ]
            [ Svg.svg
                [ Svg.Attributes.height (toString model.transform.height)
                , Svg.Attributes.width (toString model.transform.width)
                ]
                [ Svg.defs []
                    [ Svg.radialGradient
                        [ Svg.Attributes.id "radialGradient" ]
                        [ Svg.stop
                            [ Svg.Attributes.offset "0%"
                            , Svg.Attributes.stopColor "black"
                            , Svg.Attributes.stopOpacity "1"
                            ]
                            []
                        , Svg.stop
                            [ Svg.Attributes.offset "100%"
                            , Svg.Attributes.stopColor "black"
                            , Svg.Attributes.stopOpacity "0"
                            ]
                            []
                        ]
                    ]
                , Svg.filter
                    [ Svg.Attributes.id "heatmapFilter2"
                    ]
                    [ Svg.feGaussianBlur
                        [ Svg.Attributes.in_ "SourceGraphic"
                        , Svg.Attributes.stdDeviation "5"
                        ]
                        []
                    , Svg.feComponentTransfer []
                        [ Svg.feFuncA
                            [ Svg.Attributes.type_ "table"
                            , Svg.Attributes.tableValues "0 1 1 0"
                            ]
                            []
                        ]
                    ]
                , Svg.filter
                    [ Svg.Attributes.id "heatmapFilter" ]
                    [ Svg.feGaussianBlur
                        [ Svg.Attributes.in_ "SourceGraphic"
                        , Svg.Attributes.stdDeviation "5"
                        ]
                        []
                    , Svg.feColorMatrix
                        [ Svg.Attributes.colorInterpolationFilters "sRGB"
                        , Svg.Attributes.type_ "matrix"
                        , Svg.Attributes.values heatmapMatrix
                        ]
                        []
                    ]
                , Svg.g
                    [ Svg.Attributes.filter "url(#heatmapFilter)" ]
                    (locationData
                        |> List.map
                            (\{ location, value } ->
                                let
                                    { x, y } =
                                        project location

                                    radius =
                                        Maybe.withDefault 10 value
                                            |> (\v ->
                                                    if isNaN v then
                                                        10
                                                    else
                                                        v / 100
                                               )
                                in
                                    Svg.circle
                                        [ Svg.Attributes.cx (toString x)
                                        , Svg.Attributes.cy (toString y)
                                        , Svg.Attributes.r (toString radius)
                                        , Svg.Attributes.fill "url(#radialGradient)"
                                        ]
                                        []
                            )
                    )
                ]
            ]


collageLayer : Model -> Html Msg
collageLayer model =
    let
        locations =
            List.range -18 18
                |> List.concatMap
                    (\lng ->
                        List.range -8 8
                            |> List.map ((*) 10 >> toFloat >> Location (10 * toFloat lng))
                    )

        project location =
            let
                centerPoint =
                    Transform.locationToPoint model.transform model.transform.center

                point =
                    Transform.locationToPoint model.transform location
            in
                ( point.x - centerPoint.x, centerPoint.y - point.y )
    in
        Html.div
            [ Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "pointer-events", "none" )
                , ( "top", "0" )
                , ( "left", "0" )
                , ( "width", toString model.transform.width ++ "px" )
                , ( "height", toString model.transform.height ++ "px" )
                ]
            ]
            [ Collage.collage
                (round model.transform.width)
                (round model.transform.height)
                (List.map
                    (\location ->
                        Collage.filled Color.red (Collage.circle 5)
                            |> Collage.move (project location)
                    )
                    locations
                )
                |> Element.toHtml
            ]


gestureLayer : Model -> Html Msg
gestureLayer model =
    Html.div
        [ Html.Attributes.style
            [ ( "position", "absolute" )
            , ( "top", "0" )
            , ( "left", "0" )
            , ( "width", toString model.transform.width ++ "px" )
            , ( "height", toString model.transform.height ++ "px" )
            , ( "cursor"
              , (case model.drag of
                    Just _ ->
                        "-webkit-grabbing"

                    Nothing ->
                        "-webkit-grab"
                )
              )
            ]
        , Html.Events.on "dblclick"
            (Decode.map ZoomInAround clientPosition)
        , Html.Events.onWithOptions "wheel"
            { preventDefault = True
            , stopPropagation = True
            }
            (Decode.map2 ZoomByAround
                (Decode.field "deltaY" Decode.float
                    |> Decode.map (\y -> -y / 100)
                )
                clientPosition
            )
        , Html.Events.on "mousedown"
            (Decode.map (DragMsg << DragStart) Mouse.position)
        ]
        []


clientPosition : Decoder Point
clientPosition =
    Decode.map2 Point
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)


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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ZoomIn ->
            let
                transform =
                    model.transform

                newTransform =
                    { transform | zoom = transform.zoom + 1 }

                newModel =
                    { model | transform = newTransform }
            in
                newModel ! []

        ZoomOut ->
            let
                transform =
                    model.transform

                newTransform =
                    { transform | zoom = transform.zoom - 1 }

                newModel =
                    { model | transform = newTransform }
            in
                newModel ! []

        ZoomInAround point ->
            let
                transform =
                    model.transform

                newTransform =
                    LowLevel.zoomToAround transform (transform.zoom + 1) point

                newModel =
                    { model | transform = newTransform }
            in
                newModel ! []

        ZoomByAround delta point ->
            let
                transform =
                    model.transform

                newTransform =
                    LowLevel.zoomToAround transform (transform.zoom + delta) point

                newModel =
                    { model | transform = newTransform }
            in
                newModel ! []

        DragMsg dragMsg ->
            let
                draggedModel =
                    updateDrag dragMsg model

                newModel =
                    { draggedModel
                        | transform = getTransform draggedModel
                    }
            in
                newModel ! []


updateDrag : DragMsg -> Model -> Model
updateDrag dragMsg ({ drag } as model) =
    case dragMsg of
        DragStart xy ->
            { model | drag = Just (Drag xy xy) }

        DragAt xy ->
            { model
                | drag =
                    Maybe.map
                        (\{ current } -> Drag current xy)
                        drag
            }

        DragEnd _ ->
            { model | drag = Nothing }


getTransform : Model -> Transform
getTransform { transform, drag } =
    case drag of
        Nothing ->
            transform

        Just { last, current } ->
            LowLevel.moveTo transform
                { x = transform.width / 2 + toFloat (last.x - current.x)
                , y = transform.height / 2 + toFloat (last.y - current.y)
                }


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.drag of
        Nothing ->
            Sub.none

        Just _ ->
            Sub.batch
                [ Mouse.moves (DragMsg << DragAt)
                , Mouse.ups (DragMsg << DragEnd)
                ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
