module SlippyMap.Map.Update exposing (update)

{-|

@docs Msg, update

-}

import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.Msg as Msg exposing (DragMsg(..), Msg(..), PinchMsg(..))
import SlippyMap.Map.State as State exposing (Drag, Focus, Interaction(..), Pinch, State(..))


{-| -}
update : Config msg -> Msg -> State -> State
update ((Config { size }) as config) msg ((State { scene }) as state) =
    safeState config state <|
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
                state

            Step duration ->
                state

            PanTo duration center ->
                state


updateDrag : DragMsg -> State -> State
updateDrag dragMsg ((State { interaction }) as state) =
    State.withInteraction <|
        case dragMsg of
            DragStart xy ->
                State.setInteraction
                    (Dragging (Drag xy xy))
                    state

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

            DragEnd _ ->
                State.setInteraction NoInteraction state


updatePinch : PinchMsg -> State -> State
updatePinch pinchMsg ((State { interaction }) as state) =
    State.withInteraction <|
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


{-| TODO: Well, thos is not really the way to do it.
-}
safeState : Config msg -> State -> State -> State
safeState (Config config) oldState ((State { scene }) as newState) =
    if
        (config.minZoom <= scene.zoom)
            && (config.maxZoom >= scene.zoom)
    then
        newState
    else
        oldState
