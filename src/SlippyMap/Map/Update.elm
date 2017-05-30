module SlippyMap.Map.Update exposing (Msg(..), DragMsg(..), PinchMsg(..), update)

{-|
@docs Msg, update
-}

import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Map.State as State exposing (State(..), Interaction(..), Drag, Pinch, Focus)


{-| -}
type Msg
    = ZoomIn
    | ZoomOut
    | ZoomInAround Point
    | ZoomByAround Float Point
    | DragMsg DragMsg
    | PinchMsg PinchMsg
    | SetFocus Focus
    | KeyboardNavigation KeyCode


type DragMsg
    = DragStart Position
    | DragAt Position
    | DragEnd Position


type PinchMsg
    = PinchStart ( Position, Position )
    | PinchAt ( Position, Position )
    | PinchEnd ( Position, Position )


{-| -}
update : Msg -> State -> State
update msg ((State { transform }) as state) =
    case msg of
        ZoomIn ->
            State.zoomIn state

        ZoomOut ->
            State.zoomOut state

        ZoomInAround point ->
            State.zoomInAround point state

        ZoomByAround delta point ->
            State.zoomByAround delta point state

        DragMsg dragMsg ->
            updateDrag dragMsg state

        PinchMsg pinchMsg ->
            updatePinch pinchMsg state

        SetFocus focus ->
            State.setFocus focus state

        KeyboardNavigation keyCode ->
            let
                offset =
                    50

                moveBy =
                    case keyCode of
                        -- Left
                        37 ->
                            { x = -offset, y = 0 }

                        -- Up
                        38 ->
                            { x = 0, y = -offset }

                        -- Right
                        39 ->
                            { x = offset, y = 0 }

                        -- Down
                        40 ->
                            { x = 0, y = offset }

                        _ ->
                            { x = 0, y = 0 }
            in
                State.setTransform
                    (Transform.moveTo transform
                        { x = transform.width / 2 + moveBy.x
                        , y = transform.height / 2 + moveBy.y
                        }
                    )
                    state


updateDrag : DragMsg -> State -> State
updateDrag dragMsg ((State { interaction }) as state) =
    State.withInteractionTransform <|
        case dragMsg of
            DragStart xy ->
                State.setInteraction
                    (Just <| Dragging (Drag xy xy))
                    state

            DragAt xy ->
                State.setInteraction
                    (Maybe.map
                        (\i ->
                            case i of
                                Dragging { current } ->
                                    Dragging (Drag current xy)

                                Pinching { current } ->
                                    Dragging (Drag (Tuple.first current) xy)
                        )
                        interaction
                    )
                    state

            DragEnd _ ->
                State.setInteraction Nothing state



--|> Debug.log "drag end"


updatePinch : PinchMsg -> State -> State
updatePinch pinchMsg ((State { interaction }) as state) =
    State.withInteractionTransform <|
        case pinchMsg of
            PinchStart touches ->
                State.setInteraction (Just <| Pinching (Pinch touches touches)) state

            PinchAt touches ->
                let
                    newInteraction =
                        case interaction of
                            Nothing ->
                                Just <| Pinching (Pinch touches touches)

                            Just (Dragging { current }) ->
                                Just <| Pinching (Pinch ( current, current ) touches)

                            Just (Pinching { current }) ->
                                Just <| Pinching (Pinch current touches)
                in
                    State.setInteraction newInteraction state

            PinchEnd _ ->
                State.setInteraction Nothing state
