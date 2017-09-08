module SlippyMap.Control.Attribution exposing (control)

{-| Attributions for a map.
-}

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Config as Config
import SlippyMap.Map.Transform as Transform exposing (Transform)


{-| -}
control : List String -> Layer msg
control attributions =
    Layer.custom (render attributions) Layer.control


render : List String -> Layer.RenderParameters msg -> Html msg
render attributions { mapConfig } =
    let
        prefixText =
            Config.attributionPrefix mapConfig
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
