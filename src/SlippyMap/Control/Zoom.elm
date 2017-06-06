module SlippyMap.Control.Zoom exposing (control)

{-| Zoom control for a map.
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.Msg as Msg exposing (Msg(ZoomIn, ZoomOut))
import Html exposing (Html)
import Html.Attributes
import Html.Events


control : Layer.RenderState -> Html Msg
control renderState =
    Html.div
        [ Html.Attributes.class "esm__zoom"
        , Html.Attributes.style
            [ ( "position", "absolute" )
            , ( "top", "0" )
            , ( "left", "0" )
            ]
        ]
        [ Html.button
            [ Html.Attributes.style [ ( "cursor", "pointer" ) ]
            , Html.Events.onClick ZoomIn
            ]
            [ Html.text "+" ]
        , Html.button
            [ Html.Attributes.style [ ( "cursor", "pointer" ) ]
            , Html.Events.onClick ZoomOut
            ]
            [ Html.text "-" ]
        ]
