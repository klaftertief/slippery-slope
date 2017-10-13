module SlippyMap.Control.Zoom exposing (Config, config, control)

{-| Zoom control for a map.

@docs Config, config, control

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import SlippyMap.Layer exposing (Layer)
import SlippyMap.Layer.Control as Control
import SlippyMap.Map.Config as Map
import SlippyMap.Map.Map as Map exposing (Map)
import SlippyMap.Map.Msg exposing (Msg(ZoomIn, ZoomOut))
import SlippyMap.Map.State as Map
import Svg
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
    Control.control Control.topLeft (render config)


{-| TODO: This also needs the general map config, or at least its min- and maxZoom
-}
render : Config msg -> Map msg -> Html msg
render (Config { toMsg }) map =
    let
        ( currentZoom, minZoom, maxZoom ) =
            ( Map.state map |> Map.getScene |> .zoom
            , Map.config map |> Map.minZoom
            , Map.config map |> Map.maxZoom
            )
    in
    Html.map toMsg <|
        Html.div []
            [ Html.button
                [ Html.Attributes.style
                    (buttonStyleProperties
                        ++ [ ( "top", "12px" )
                           , ( "border-radius", "2px 2px 0 0" )
                           ]
                    )
                , Html.Attributes.disabled (currentZoom >= maxZoom)
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
                , Html.Attributes.disabled (currentZoom <= minZoom)
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
    , ( "pointer-events", "all" )
    ]
