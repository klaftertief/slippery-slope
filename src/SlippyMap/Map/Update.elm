module SlippyMap.Map.Update exposing (update)

{-|
@docs Msg, update
-}

import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.Msg as Msg exposing (Msg(..), DragMsg(..), PinchMsg(..))
import SlippyMap.Map.State as State exposing (State(..), Interaction(..), Drag, Pinch, Focus)


{-| -}
update : Config msg -> Msg -> State -> State
update config msg ((State { transform }) as state) =
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


{-| TODO: Well, thos is not really the way to do it.
-}
safeState : Config msg -> State -> State -> State
safeState (Config config) oldState ((State { transform }) as newState) =
    if
        (config.minZoom <= transform.zoom)
            && (config.maxZoom >= transform.zoom)
    then
        newState
    else
        oldState
