module SlippyMap.Map.Update exposing (update)

{-|

@docs update

-}

import Keyboard exposing (KeyCode)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.Msg as Msg exposing (DragMsg(..), Msg(..), PinchMsg(..))
import SlippyMap.Map.State as State exposing (State(..))
import SlippyMap.Map.Types as Types exposing (Drag, Focus, Interaction(..), Pinch, Transition(..))


{-| -}
update : Config msg -> Msg -> State -> State
update config msg ((State { scene }) as state) =
    case msg of
        ZoomIn ->
            State.zoomIn config state

        ZoomOut ->
            State.zoomOut config state

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
            case keyboardNavigation keyCode of
                KeyboardMoveBy offset ->
                    State.moveByAnimated config offset state

                KeyboardZoomIn ->
                    State.zoomIn config state

                KeyboardZoomOut ->
                    State.zoomOut config state

                NoKeyboardNavigation ->
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


updateDrag : Config msg -> DragMsg -> State -> State
updateDrag config dragMsg ((State { interaction }) as state) =
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
                                    State.moveByAnimated config
                                        { x = (last.x - current.x) * speed |> toFloat
                                        , y = (last.y - current.y) * speed |> toFloat
                                        }

                            Pinching { last } ->
                                identity
                in
                state
                    |> State.setInteraction NoInteraction
                    |> maybeAnimate


updatePinch : Config msg -> PinchMsg -> State -> State
updatePinch config pinchMsg ((State { interaction }) as state) =
    State.withInteraction config <|
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

            PinchEnd _ ->
                State.setInteraction NoInteraction state
