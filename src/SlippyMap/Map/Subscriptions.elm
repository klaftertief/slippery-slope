module SlippyMap.Map.Subscriptions exposing (subscriptions)

{-|
@docs subscriptions
-}

import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.State as State exposing (State(..), Interaction(..), Drag, Focus(..))
import SlippyMap.Map.Update as Update exposing (Msg(..), DragMsg(..))


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions (Config config) ((State { interaction, focus }) as state) =
    case config.toMsg of
        Just toMsg ->
            let
                dragSubscriptions =
                    case interaction of
                        Nothing ->
                            []

                        Just (Pinching _) ->
                            []

                        Just (Dragging _) ->
                            [ Mouse.moves (DragAt >> DragMsg)
                            , Mouse.ups (DragEnd >> DragMsg)
                            ]

                keyboardNavigationSubscriptions =
                    case focus of
                        HasFocus ->
                            [ Keyboard.downs KeyboardNavigation ]

                        HasNoFocus ->
                            []
            in
                (dragSubscriptions ++ keyboardNavigationSubscriptions)
                    |> List.map (Sub.map toMsg)
                    |> Sub.batch

        Nothing ->
            Sub.none
