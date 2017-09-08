module SlippyMap.Control.Zoom exposing (Config, config, control)

{-| Zoom control for a map.
-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Msg as Msg exposing (Msg(ZoomIn, ZoomOut))
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
type Config msg
    = Config { toMsg : Msg -> msg }


{-| -}
config : (Msg -> msg) -> Config msg
config toMsg =
    Config
        { toMsg = toMsg
        }


{-| -}
control : Config msg -> Layer msg
control config =
    Layer.custom (render config) Layer.control


{-| TODO: This also needs the general map config, or at least its min- and maxZoom
-}
render : Config msg -> Layer.RenderParameters msg -> Html msg
render (Config { toMsg }) { transform } =
    Html.map toMsg <|
        Html.div
            [ Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "top", "0" )
                , ( "left", "0" )
                ]
            ]
            [ Html.button
                [ Html.Attributes.style
                    (buttonStyleProperties
                        ++ [ ( "top", "12px" )
                           , ( "border-radius", "2px 2px 0 0" )
                           ]
                    )
                , Html.Events.onClick ZoomIn
                ]
                [ Svg.svg
                    [ Svg.Attributes.width "24"
                    , Svg.Attributes.height "24"
                    ]
                    [ Svg.path
                        [ Svg.Attributes.d "M6,12L18,12M12,6L12,18"
                        , Svg.Attributes.strokeWidth "2"
                        , Svg.Attributes.stroke "#444"
                        ]
                        []
                    ]
                ]
            , Html.button
                [ Html.Attributes.style
                    (buttonStyleProperties
                        ++ [ ( "top", "37px" )
                           , ( "border-radius", "0 0 2px 2px" )
                           ]
                    )
                , Html.Events.onClick ZoomOut
                ]
                [ Svg.svg
                    [ Svg.Attributes.width "24"
                    , Svg.Attributes.height "24"
                    ]
                    [ Svg.path
                        [ Svg.Attributes.d "M6,12L18,12"
                        , Svg.Attributes.strokeWidth "2"
                        , Svg.Attributes.stroke "#444"
                        ]
                        []
                    ]
                ]
            ]


buttonStyleProperties : List ( String, String )
buttonStyleProperties =
    [ ( "cursor", "pointer" )
    , ( "box-sizing", "content-box" )
    , ( "width", "24px" )
    , ( "height", "24px" )
    , ( "padding", "0" )
    , ( "background-color", "#fff" )
    , ( "color", "#000" )
    , ( "border", "1px solid #aaa" )
    , ( "position", "absolute" )
    , ( "left", "12px" )
    ]
