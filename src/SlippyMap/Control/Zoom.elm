module SlippyMap.Control.Zoom exposing (control)

{-| Zoom control for a map.
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.Update as Update exposing (Msg(ZoomIn, ZoomOut))
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events


control : Layer.RenderState -> Svg Msg
control renderState =
    Svg.g [ Svg.Attributes.transform "translate(8, 8)" ]
        [ Svg.g
            [ Svg.Attributes.style "cursor:pointer;"
            , Svg.Events.onClick ZoomIn
            ]
            [ Svg.rect
                [ Svg.Attributes.fill "#fff"
                , Svg.Attributes.strokeWidth "1"
                , Svg.Attributes.stroke "#aaa"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "0"
                , Svg.Attributes.width (toString buttonSize)
                , Svg.Attributes.height (toString buttonSize)
                ]
                []
            , Svg.path
                [ Svg.Attributes.d "M6,12L18,12M12,6L12,18"
                , Svg.Attributes.strokeWidth "2"
                , Svg.Attributes.stroke "#444"
                ]
                []
            ]
        , Svg.g
            [ Svg.Attributes.transform
                ("translate(0, " ++ (toString buttonSize) ++ ")")
            , Svg.Attributes.style "cursor:pointer;"
            , Svg.Events.onClick ZoomOut
            ]
            [ Svg.rect
                [ Svg.Attributes.fill "#fff"
                , Svg.Attributes.strokeWidth "1"
                , Svg.Attributes.stroke "#aaa"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "0"
                , Svg.Attributes.width (toString buttonSize)
                , Svg.Attributes.height (toString buttonSize)
                ]
                []
            , Svg.path
                [ Svg.Attributes.d "M6,12L18,12"
                , Svg.Attributes.strokeWidth "2"
                , Svg.Attributes.stroke "#444"
                ]
                []
            ]
        ]


buttonSize : Int
buttonSize =
    24
