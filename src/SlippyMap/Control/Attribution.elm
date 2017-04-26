module SlippyMap.Control.Attribution exposing (..)

{-| Attributions for a map.
-}

import Svg exposing (Svg)
import Svg.Attributes


attribution : Maybe String -> List String -> Svg msg
attribution prefix attributions =
    let
        prefixText =
            prefix
                |> Maybe.map (\p -> p ++ " | ")
                |> Maybe.withDefault ""
    in
        Svg.g [ Svg.Attributes.class "esm__atttribution" ]
            [ Svg.text_
                [ Svg.Attributes.x "600"
                , Svg.Attributes.y "400"
                , Svg.Attributes.dx "-4"
                , Svg.Attributes.dy "-4"
                , Svg.Attributes.textAnchor "end"
                , Svg.Attributes.fontFamily "sans-serif"
                , Svg.Attributes.fontSize "12px"
                ]
                [ Svg.text (prefixText ++ String.join ", " attributions) ]
            ]
