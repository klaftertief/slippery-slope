module SlippyMap.Map.Update exposing (Msg(..), DragMsg(..), PinchMsg(..), update)

{-|
@docs Msg, update
-}

import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Map.State as State exposing (State(..), Drag, Pinch, Focus)


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
update msg ((State { transform, drag }) as state) =
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
updateDrag dragMsg ((State { drag }) as state) =
    State.withDragTransform <|
        case dragMsg of
            DragStart xy ->
                State.setDrag (Just (Drag xy xy)) state
                    --|> Debug.log "drag Start"
                    |> State.setPinch Nothing

            DragAt xy ->
                State.setDrag
                    (Maybe.map
                        (\{ current } -> Drag current xy)
                        drag
                    )
                    state
                    --|> Debug.log "drag at"
                    |> State.setPinch Nothing

            DragEnd _ ->
                State.setDrag Nothing state
                    --|> Debug.log "drag end"
                    |> State.setPinch Nothing


updatePinch : PinchMsg -> State -> State
updatePinch pinchMsg ((State { pinch, drag }) as state) =
    State.withPinchTransform <|
        case pinchMsg of
            PinchStart touches ->
                State.setPinch (Just (Pinch touches touches)) state
                    |> State.setDrag Nothing

            PinchAt touches ->
                let
                    newPinch =
                        case ( pinch, drag ) of
                            ( Nothing, Nothing ) ->
                                Just (Pinch touches touches)

                            ( Nothing, Just { current } ) ->
                                Just (Pinch ( current, current ) touches)

                            ( Just { current }, _ ) ->
                                Just (Pinch current touches)
                in
                    State.setPinch newPinch state
                        |> State.setDrag Nothing

            PinchEnd _ ->
                State.setPinch Nothing state
                    |> State.setDrag Nothing
