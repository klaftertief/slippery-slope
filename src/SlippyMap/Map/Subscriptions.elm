module SlippyMap.Map.Subscriptions exposing (subscriptions)

{-|

@docs subscriptions

-}

import AnimationFrame
import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.Msg as Msg exposing (DragMsg(..), Msg(..))
import SlippyMap.Map.State as State exposing (Drag, Focus(..), Interaction(..), State(..), Target(..))


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions (Config config) ((State { interaction, focus, target }) as state) =
    case config.toMsg of
        Just toMsg ->
            let
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

                stepSubscriptions =
                    case target of
                        NoTarget ->
                            []

                        MoveTo _ ->
                            [ AnimationFrame.diffs Step ]
            in
            (dragSubscriptions
                ++ keyboardNavigationSubscriptions
                ++ stepSubscriptions
            )
                |> List.map (Sub.map toMsg)
                |> Sub.batch

        Nothing ->
            Sub.none
