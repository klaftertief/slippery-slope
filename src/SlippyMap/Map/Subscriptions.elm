module SlippyMap.Map.Subscriptions exposing (subscriptions)

{-|
@docs subscriptions
-}

import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.State as State exposing (State(..), Drag, Focus(..))
import SlippyMap.Map.Update as Update exposing (Msg(..), DragMsg(..))


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions (Config config) ((State { drag, focus }) as state) =
    case config.toMsg of
        Just toMsg ->
            let
                dragSubscriptions =
                    case drag of
                        Nothing ->
                            []

                        Just _ ->
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
