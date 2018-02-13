module SlippyMap.View exposing (view)

{-|

@docs view

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Mouse exposing (Position)
import SlippyMap.Config as Config exposing (Config(..))
import SlippyMap.Control.Attribution as Attribution
import SlippyMap.Control.Zoom as Zoom
import SlippyMap.Geo.Point exposing (Point)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map as Map exposing (Map)
import SlippyMap.Msg exposing (DragMsg(..), Msg(..), PinchMsg(..))
import SlippyMap.State as State exposing (State(..))
import SlippyMap.Types as Types exposing (Focus(..))


{-| -}
view : Config msg -> State -> List (Layer msg) -> ( Html msg, Map msg )
view config state nestedLayers =
    let
        ( _, interaction ) =
            ( State.getScene state
            , State.interaction state
            )

        map =
            Map.make config state

        size =
            Map.size map

        attributions =
            List.concatMap Layer.attributions nestedLayers

        attributionControl =
            [ Attribution.control attributions ]

        tagger =
            Config.tagger config

        zoomControl =
            case tagger of
                Just toMsg ->
                    if Config.zoomControl config then
                        [ Zoom.control (Zoom.config toMsg) ]
                    else
                        []

                Nothing ->
                    []

        layersWithControls =
            List.concat
                [ nestedLayers
                , attributionControl
                , zoomControl
                ]

        layers =
            Layer.flatten layersWithControls

        pointerPositionDecoder =
            Config.pointerPositionDecoder config

        interactionAttributesInternal =
            case tagger of
                Just toMsg ->
                    List.map
                        (Html.Attributes.map toMsg)
                        (eventAttributes pointerPositionDecoder <| Config.interactions config)

                Nothing ->
                    []

        userEventAttributes =
            List.map
                (\{ name, toDecoder } ->
                    Html.Events.on name
                        (pointerPositionDecoder
                            |> Decode.map
                                (\point ->
                                    ( point, Map.screenPointToLocation map point )
                                )
                            |> Decode.andThen toDecoder
                        )
                )
                (Config.events config)
    in
    ( Html.div
        ([ Html.Attributes.style
            [ ( "position", "relative" )
            , ( "width", toString size.x ++ "px" )
            , ( "height", toString size.y ++ "px" )
            , ( "background", "#eee" )
            ]
         , Html.Attributes.classList
            [ ( "with-interaction", interaction /= Types.NoInteraction ) ]
         ]
            ++ interactionAttributesInternal
            ++ userEventAttributes
        )
        [ {- Html.div
                 [ -- This is needed at the moment as a touch event target for panning. The touchmove gets lost when it originates in a tile that gets removed during panning.
                   Html.Attributes.style
                     [ ( "position"
                       , if interaction /= Types.NoInteraction then
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
                 []
             ,
          -}
          Html.div
            [ Html.Attributes.class "esm__map"
            , Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "overflow", "hidden" )
                , ( "width", toString size.x ++ "px" )
                , ( "height", toString size.y ++ "px" )
                ]
            ]
            (List.map
                (\layer ->
                    Html.div
                        [ Html.Attributes.class "esm__layer"
                        , Html.Attributes.style
                            [ ( "position", "absolute" )
                            , ( "left", "0" )
                            , ( "top", "0" )
                            , ( "width", toString size.x ++ "px" )
                            , ( "height", toString size.y ++ "px" )
                            , ( "pointer-events", "none" )
                            ]
                        ]
                        [ Layer.render map layer ]
                )
                layers
            )
        ]
    , map
    )


eventAttributes : Decoder Point -> Config.Interactions -> List (Html.Attribute Msg)
eventAttributes pointerPositionDecoder interactions =
    let
        scrollWheelZoom =
            if interactions.scrollWheelZoom then
                [ Html.Events.onWithOptions "wheel"
                    { preventDefault = True
                    , stopPropagation = True
                    }
                    (Decode.map2 (\offset point -> ZoomByAround offset point)
                        (Decode.field "deltaY" Decode.float
                            |> Decode.map (\y -> -y / 100)
                        )
                        pointerPositionDecoder
                    )
                ]
            else
                []

        doubleClickZoom =
            if interactions.doubleClickZoom then
                [ Html.Events.on "dblclick"
                    (Decode.map ZoomInAround pointerPositionDecoder)
                ]
            else
                []

        keyboardControl =
            if interactions.keyboardControl then
                [ Html.Events.onFocus (SetFocus HasFocus)
                , Html.Events.onBlur (SetFocus HasNoFocus)
                , Html.Attributes.tabindex 0
                ]
            else
                []
    in
    List.concat
        [ scrollWheelZoom
        , doubleClickZoom
        , keyboardControl
        , [ Html.Events.on "mousedown"
                (Decode.map (DragStart >> DragMsg) Mouse.position)
          , Html.Events.onWithOptions "touchstart"
                { preventDefault = True
                , stopPropagation = False
                }
                (Decode.map touchesStartMsg touchesDecoder)
          , Html.Events.on "touchmove"
                (Decode.map touchesMoveMsg touchesDecoder)
          , Html.Events.on "touchend"
                (Decode.map touchesEndMsg (Decode.succeed (Tap (Position 0 0))))
          , Html.Events.on "touchcancel"
                (Decode.map touchesEndMsg (Decode.succeed (Tap (Position 0 0))))
          ]
        ]


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
        (Decode.at [ "touches", toString index, "clientX" ] Decode.float
            |> Decode.andThen (round >> Decode.succeed)
        )
        (Decode.at [ "touches", toString index, "clientY" ] Decode.float
            |> Decode.andThen (round >> Decode.succeed)
        )
