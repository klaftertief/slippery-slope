module SlippyMap.Map.Update exposing (Msg(..), DragMsg(..), update)

{-|
@docs Msg, update
-}

import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Map.State as State exposing (State(..), Drag, Focus)


{-| -}
type Msg
    = ZoomIn
    | ZoomOut
    | ZoomInAround Point
    | ZoomByAround Float Point
    | DragMsg DragMsg
    | SetFocus Focus
    | KeyboardNavigation KeyCode


type DragMsg
    = DragStart Position
    | DragAt Position
    | DragEnd Position


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

            DragAt xy ->
                State.setDrag
                    (Maybe.map
                        (\{ current } -> Drag current xy)
                        drag
                    )
                    state

            DragEnd _ ->
                State.setDrag Nothing state
