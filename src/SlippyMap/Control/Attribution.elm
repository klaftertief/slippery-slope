module SlippyMap.Control.Attribution exposing (control)

{-| Attributions for a map.
-}

import Html exposing (Html)
import Html.Attributes


control : Maybe String -> List String -> Html msg
control prefix attributions =
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
