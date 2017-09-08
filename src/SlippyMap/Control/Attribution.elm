module SlippyMap.Control.Attribution exposing (control)

{-| Attributions for a map.
-}

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)


{-| -}
control : Maybe String -> List String -> Layer msg
control prefix attributions =
    Layer.custom (render prefix attributions) Layer.control


render : Maybe String -> List String -> Layer.RenderParameters msg -> Html msg
render prefix attributions _ =
    let
        prefixText =
            prefix
                |> Maybe.map (\p -> p ++ " | ")
                |> Maybe.withDefault ""
    in
    Html.div
        [ Html.Attributes.class "esm__attribution"
        , Html.Attributes.style
            [ ( "position", "absolute" )
            , ( "bottom", "0" )
            , ( "right", "0" )
            ]
        ]
        [ Html.text (prefixText ++ String.join ", " attributions) ]
