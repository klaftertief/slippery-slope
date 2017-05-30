module SlippyMap.Control.Attribution exposing (control)

{-| Attributions for a map.
-}

import Svg exposing (Svg)
import Svg.Attributes


control : ( Float, Float ) -> Maybe String -> List String -> Svg msg
control ( width, height ) prefix attributions =
    let
        prefixText =
            prefix
                |> Maybe.map (\p -> p ++ " | ")
                |> Maybe.withDefault ""
    in
        Svg.g [ Svg.Attributes.class "esm__atttribution" ]
            [ Svg.text_
                [ Svg.Attributes.x (toString width)
                , Svg.Attributes.y (toString height)
                , Svg.Attributes.dx "-4"
                , Svg.Attributes.dy "-4"
                , Svg.Attributes.textAnchor "end"
                , Svg.Attributes.fontFamily "sans-serif"
                , Svg.Attributes.fontSize "12px"
                ]
                [ Svg.text (prefixText ++ String.join ", " attributions) ]
            ]
