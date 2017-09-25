module SlippyMap.Map.Subscriptions exposing (subscriptions)

{-|

@docs subscriptions

-}

import AnimationFrame
import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.Msg as Msg exposing (DragMsg(..), Msg(..))
import SlippyMap.Map.State as State exposing (State(..))
import SlippyMap.Map.Types as Types exposing (Drag, Focus(..), Interaction(..), Transition(..))


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions config state =
    case Config.tagger config of
        Just toMsg ->
            let
                ( interaction, focus, transition ) =
                    ( State.interaction state
                    , State.focus state
                    , State.transition state
                    )

                dragSubscriptions =
                    case interaction of
                        NoInteraction ->
                            []

                        Pinching _ ->
                            []

                        Dragging _ ->
                            [ Mouse.moves (DragAt >> DragMsg)
                            , Mouse.ups (DragEnd >> DragMsg)
                            ]

                keyboardNavigationSubscriptions =
                    case focus of
                        HasFocus ->
                            [ Keyboard.downs KeyboardNavigation ]

                        HasNoFocus ->
                            []

                transitionSubscriptions =
                    case transition of
                        NoTransition ->
                            []

                        MoveTo _ ->
                            [ AnimationFrame.diffs Tick ]

                        FlyTo _ ->
                            [ AnimationFrame.diffs Tick ]
            in
            (dragSubscriptions
                ++ keyboardNavigationSubscriptions
                ++ transitionSubscriptions
            )
                |> List.map (Sub.map toMsg)
                |> Sub.batch

        Nothing ->
            Sub.none
