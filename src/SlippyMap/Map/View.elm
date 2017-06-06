module SlippyMap.Map.View exposing (view)

{-|
@docs view
-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Mouse exposing (Position)
import SlippyMap.Control.Attribution as Attribution
import SlippyMap.Control.Zoom as Zoom
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.Msg as Msg exposing (Msg(..), DragMsg(..), PinchMsg(..))
import SlippyMap.Map.State as State exposing (State(..), Focus(..))
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view (Config config) ((State { transform, interaction }) as state) layers =
    let
        renderState =
            Layer.transformToRenderState transform

        -- TODO: onlye get attributions from currentlyc visible layers, whatever that means or how it's implemented
        layerAttributions =
            List.map Layer.getAttribution layers
                |> List.filterMap identity

        -- TODO: make list depend on config
        handlers =
            case config.toMsg of
                Just toMsg ->
                    List.map
                        (Html.Attributes.map toMsg)
                        [ Html.Events.on "dblclick"
                            (Decode.map ZoomInAround clientPosition)
                        , Html.Events.on "mousedown"
                            (Decode.map (DragStart >> DragMsg) Mouse.position)
                        , Html.Events.onWithOptions "touchstart"
                            { preventDefault = True
                            , stopPropagation = True
                            }
                            (Decode.map touchesStartMsg touchesDecoder)
                        , Html.Events.on "touchmove"
                            (Decode.map touchesMoveMsg touchesDecoder)
                        , Html.Events.on "touchend"
                            (Decode.map touchesEndMsg (Decode.succeed (Tap (Position 0 0))))
                        , Html.Events.on "touchcancel"
                            (Decode.map touchesEndMsg (Decode.succeed (Tap (Position 0 0))))
                        , Html.Events.onWithOptions "wheel"
                            { preventDefault = True
                            , stopPropagation = True
                            }
                            (Decode.map2 (\offset point -> ZoomByAround offset point)
                                (Decode.field "deltaY" Decode.float
                                    |> Decode.map (\y -> -y / 100)
                                )
                                clientPosition
                            )
                        , Html.Events.onFocus (SetFocus HasFocus)
                        , Html.Events.onBlur (SetFocus HasNoFocus)
                        ]

                Nothing ->
                    []
    in
        Html.div
            ([ Html.Attributes.tabindex 0
             , Html.Attributes.style
                [ ( "position", "relative" )
                , ( "width", toString transform.width ++ "px" )
                , ( "height", toString transform.height ++ "px" )
                , ( "background", "#eee" )
                ]
             , Html.Attributes.classList
                [ ( "with-interaction", interaction /= Nothing ) ]
             ]
                ++ handlers
            )
            [ Html.div
                ([ Html.Attributes.style
                    [ ( "position"
                      , if interaction /= Nothing then
                            "fixed"
                        else
                            "absolute"
                      )
                    , ( "left", "0" )
                    , ( "top", "0" )
                    , ( "right", "0" )
                    , ( "bottom", "0" )
                    ]
                 ]
                )
                []
            , Svg.svg
                [ Svg.Attributes.class "esm__map"
                , Svg.Attributes.height (toString transform.height)
                , Svg.Attributes.width (toString transform.width)
                , Svg.Attributes.style "position: absolute;"
                ]
                [ Svg.g
                    [ Svg.Attributes.class "esm__layers" ]
                    (List.concatMap
                        (viewPane (Config config) renderState layers)
                        Layer.panes
                    )
                ]

            -- This is needed at the moment as a touch event target for panning. The touchmove gets lost when it originates in a tile that gets removed during panning.
            --, Html.div
            --    [ Html.Attributes.style
            --        [ ( "position", "absolute" )
            --        , ( "left", "0" )
            --        , ( "top", "0" )
            --        , ( "right", "0" )
            --        , ( "bottom", "0" )
            --        ]
            --    ]
            --    []
            , Html.div
                [ Html.Attributes.class "esm__controls" ]
                [ Attribution.control config.attributionPrefix
                    layerAttributions
                , case config.toMsg of
                    Just toMsg ->
                        Html.map toMsg <| Zoom.control renderState

                    Nothing ->
                        Html.text ""
                ]
            ]


viewPane : Config msg -> Layer.RenderState -> List (Layer msg) -> Layer.Pane -> List (Svg msg)
viewPane (Config config) renderState layers pane =
    layers
        |> List.filter (Layer.getPane >> (==) pane)
        |> List.map (\layer -> Layer.render layer renderState)


clientPosition : Decoder Point
clientPosition =
    Decode.map2 Point
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)


type Touches
    = Tap Position
    | Pinch ( Position, Position )


touchesStartMsg : Touches -> Msg
touchesStartMsg touches =
    case touches of
        Tap position ->
            DragStart position |> DragMsg

        Pinch positions ->
            PinchStart positions |> PinchMsg


touchesMoveMsg : Touches -> Msg
touchesMoveMsg touches =
    case touches of
        Tap position ->
            DragAt position |> DragMsg

        Pinch positions ->
            PinchAt positions |> PinchMsg


touchesEndMsg : Touches -> Msg
touchesEndMsg touches =
    case touches of
        Tap position ->
            DragEnd position |> DragMsg

        Pinch positions ->
            PinchEnd positions |> PinchMsg


touchesDecoder : Decoder Touches
touchesDecoder =
    Decode.oneOf
        [ Decode.map Pinch pinchDecoder
        , Decode.map Tap tapDecoder
        ]


tapDecoder : Decoder Position
tapDecoder =
    tapDecoderAt 0


pinchDecoder : Decoder ( Position, Position )
pinchDecoder =
    Decode.map2 (,)
        (tapDecoderAt 0)
        (tapDecoderAt 1)


tapDecoderAt : Int -> Decoder Position
tapDecoderAt index =
    Decode.map2 Position
        (Decode.at [ "targetTouches", toString index, "clientX" ] Decode.int)
        (Decode.at [ "targetTouches", toString index, "clientY" ] Decode.int)
