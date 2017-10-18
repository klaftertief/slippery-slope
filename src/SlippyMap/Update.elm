module SlippyMap.Update exposing (Msg, update)

{-|

@docs update, Msg

-}

import Keyboard exposing (KeyCode)
import SlippyMap.Config exposing (Config(..))
import SlippyMap.Geo.Point exposing (Point)
import SlippyMap.Msg exposing (DragMsg(..), Msg(..), PinchMsg(..))
import SlippyMap.State as State exposing (State)
import SlippyMap.Types exposing (Drag, Interaction(..), Pinch, Transition(..))


{-| -}
type alias Msg =
    SlippyMap.Msg.Msg


{-| -}
update : Config msg -> Msg -> State -> State
update config msg state =
    case msg of
        ZoomIn ->
            State.animate 400
                (State.zoomIn config)
                state

        ZoomOut ->
            State.animate 400
                (State.zoomOut config)
                state

        ZoomInAround point ->
            State.zoomInAround config point state

        ZoomByAround delta point ->
            State.zoomByAround config delta point state

        DragMsg dragMsg ->
            updateDrag config dragMsg state

        PinchMsg pinchMsg ->
            updatePinch config pinchMsg state

        SetFocus focus ->
            State.setFocus focus state

        KeyboardNavigation keyCode ->
            State.animate 400
                (updateKeyboardNavigation config
                    (keyboardNavigation keyCode)
                )
                state

        Tick diff ->
            State.tickTransition diff state


type KeyboardNavigation
    = KeyboardMoveBy Point
    | KeyboardZoomIn
    | KeyboardZoomOut
    | NoKeyboardNavigation


keyboardNavigation : KeyCode -> KeyboardNavigation
keyboardNavigation keyCode =
    let
        distance =
            50
    in
    case keyCode of
        -- Left
        37 ->
            KeyboardMoveBy { x = -distance, y = 0 }

        -- Up
        38 ->
            KeyboardMoveBy { x = 0, y = -distance }

        -- Right
        39 ->
            KeyboardMoveBy { x = distance, y = 0 }

        -- Down
        40 ->
            KeyboardMoveBy { x = 0, y = distance }

        187 ->
            KeyboardZoomIn

        107 ->
            KeyboardZoomIn

        61 ->
            KeyboardZoomIn

        171 ->
            KeyboardZoomIn

        189 ->
            KeyboardZoomOut

        109 ->
            KeyboardZoomOut

        54 ->
            KeyboardZoomOut

        173 ->
            KeyboardZoomOut

        _ ->
            NoKeyboardNavigation


updateKeyboardNavigation : Config msg -> KeyboardNavigation -> State -> State
updateKeyboardNavigation config keyboard state =
    case keyboard of
        KeyboardMoveBy offset ->
            State.moveBy config offset state

        KeyboardZoomIn ->
            State.zoomIn config state

        KeyboardZoomOut ->
            State.zoomOut config state

        NoKeyboardNavigation ->
            state


updateDrag : Config msg -> DragMsg -> State -> State
updateDrag config dragMsg state =
    let
        interaction =
            State.interaction state
    in
    State.withInteraction config <|
        case dragMsg of
            DragStart xy ->
                state
                    |> State.setTransition
                        NoTransition
                    |> State.setInteraction
                        (Dragging (Drag xy xy))

            DragAt xy ->
                let
                    newInteraction =
                        case interaction of
                            NoInteraction ->
                                Dragging (Drag xy xy)

                            Dragging { current } ->
                                Dragging (Drag current xy)

                            Pinching { current } ->
                                Dragging (Drag (Tuple.first current) xy)
                in
                State.setInteraction newInteraction
                    state

            DragEnd xy ->
                let
                    maybeAnimate =
                        case interaction of
                            NoInteraction ->
                                identity

                            Dragging { current, last } ->
                                if xy == last then
                                    identity
                                else
                                    let
                                        speed =
                                            5
                                    in
                                    State.moveBy config
                                        { x = (last.x - current.x) * speed |> toFloat
                                        , y = (last.y - current.y) * speed |> toFloat
                                        }
                                        |> State.animate 400

                            Pinching _ ->
                                -- identity
                                State.snapZoom config
                in
                state
                    |> State.setInteraction NoInteraction
                    |> maybeAnimate


updatePinch : Config msg -> PinchMsg -> State -> State
updatePinch config pinchMsg state =
    let
        interaction =
            State.interaction state
    in
    case pinchMsg of
        PinchStart touches ->
            State.setInteraction (Pinching (Pinch touches touches)) state

        PinchAt touches ->
            let
                newInteraction =
                    case interaction of
                        NoInteraction ->
                            Pinching (Pinch touches touches)

                        Dragging { current } ->
                            Pinching (Pinch ( current, current ) touches)

                        Pinching { current } ->
                            Pinching (Pinch current touches)
            in
            State.setInteraction newInteraction state
                |> State.withInteraction config

        PinchEnd _ ->
            State.setInteraction NoInteraction state
                -- state
                |> State.snapZoom config
