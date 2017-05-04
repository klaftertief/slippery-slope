module SlippyMap.Layer.Heatmap
    exposing
        ( Config
        , defaultConfig
        , layer
        )

{-| A layer to display markers.
-}

import Color exposing (Color)
import Color.Gradient as Gradient exposing (Gradient, Palette)
import Color.Interpolate as Interpolate
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config data
    = Config
        { radius : data -> Float
        , palette : Palette
        }


defaultConfig : Config Float
defaultConfig =
    Config
        { radius = identity
        , palette = defaultPalette
        }


defaultPalette : Palette
defaultPalette =
    Gradient.linearGradientFromStops Interpolate.RGB
        [ ( 0.4, Color.rgb 0 0 255 )
        , ( 0.5, Color.rgb 0 255 255 )
        , ( 0.7, Color.rgb 0 255 0 )
        , ( 0.8, Color.rgb 255 255 0 )
        , ( 1, Color.rgb 255 0 0 )
        ]
        8



-- LAYER


layer : Config data -> List ( Location, data ) -> Layer msg
layer config dataLocations =
    Layer.withRender (Layer.withoutAttribution) (render config dataLocations)


render : Config data -> List ( Location, data ) -> Transform -> Svg msg
render (Config config) dataLocations transform =
    let
        centerPoint =
            Transform.centerPoint transform

        bounds =
            Transform.locationBounds transform

        dataLocationsFiltered =
            List.filter
                (\( location, _ ) ->
                    Location.isInsideBounds bounds location
                )
                dataLocations
    in
        Svg.g
            [ Svg.Attributes.transform
                (""
                    ++ "translate("
                    ++ toString (round (transform.width / 2 - centerPoint.x))
                    ++ " "
                    ++ toString (round (transform.height / 2 - centerPoint.y))
                    ++ ")"
                )
            ]
            [ Svg.defs []
                [ Svg.radialGradient
                    [ Svg.Attributes.id "radialGradient" ]
                    [ Svg.stop
                        [ Svg.Attributes.offset "0%"
                        , Svg.Attributes.stopColor "black"
                        , Svg.Attributes.stopOpacity "0.4"
                        ]
                        []
                    , Svg.stop
                        [ Svg.Attributes.offset "100%"
                        , Svg.Attributes.stopColor "black"
                        , Svg.Attributes.stopOpacity "0"
                        ]
                        []
                    ]
                ]
            , heatmapFilter config.palette
            , Svg.g [ Svg.Attributes.filter "url(#heatmapFilter)" ]
                ((Svg.rect
                    [ Svg.Attributes.x "-100"
                    , Svg.Attributes.y "-100"
                    , Svg.Attributes.width (toString (transform.width + 200))
                    , Svg.Attributes.height (toString (transform.height + 200))
                    , Svg.Attributes.fill "white"
                    , Svg.Attributes.fillOpacity "0.2"
                    , Svg.Attributes.transform
                        (""
                            ++ "translate("
                            ++ toString (centerPoint.x - transform.width / 2)
                            ++ " "
                            ++ toString (centerPoint.y - transform.height / 2)
                            ++ ")"
                        )
                    ]
                    []
                 )
                    :: (List.map (renderLocation (Config config) transform) dataLocationsFiltered)
                )
            ]


renderLocation : Config data -> Transform -> ( Location, data ) -> Svg msg
renderLocation (Config config) transform ( location, data ) =
    let
        { x, y } =
            Transform.locationToPoint transform location
    in
        Svg.circle
            [ Svg.Attributes.cx (toString x)
            , Svg.Attributes.cy (toString y)
            , Svg.Attributes.r (toString <| config.radius data)
            , Svg.Attributes.fill "url(#radialGradient)"
            ]
            []


heatmapFilter : Palette -> Svg msg
heatmapFilter palette =
    let
        componentTransferPalette =
            palette
                |> List.reverse
                |> List.map Color.toRgb
                |> List.map
                    (\{ red, green, blue } ->
                        { red = toFloat red / 256
                        , green = toFloat green / 256
                        , blue = toFloat blue / 256
                        }
                    )

        componentTransferTableValues color =
            componentTransferPalette
                |> List.map (color >> toString)
                |> String.join " "
    in
        Svg.filter
            [ Svg.Attributes.id "heatmapFilter" ]
            [ Svg.feGaussianBlur
                [ Svg.Attributes.in_ "SourceGraphic"
                , Svg.Attributes.stdDeviation "15"
                ]
                []

            --, Svg.feFlood
            --    [ Svg.Attributes.x "0"
            --    , Svg.Attributes.y "0"
            --    , Svg.Attributes.width "100%"
            --    , Svg.Attributes.height "100%"
            --    , Svg.Attributes.floodColor "green"
            --    , Svg.Attributes.floodOpacity "0.5"
            --    ]
            --    []
            , Svg.feComponentTransfer []
                [ Svg.feFuncR
                    [ Svg.Attributes.type_ "table"
                    , Svg.Attributes.tableValues
                        (componentTransferTableValues .red)
                    ]
                    []
                , Svg.feFuncG
                    [ Svg.Attributes.type_ "table"
                    , Svg.Attributes.tableValues
                        (componentTransferTableValues .green)
                    ]
                    []
                , Svg.feFuncB
                    [ Svg.Attributes.type_ "table"
                    , Svg.Attributes.tableValues
                        (componentTransferTableValues .blue)
                    ]
                    []
                , Svg.feFuncA
                    [ Svg.Attributes.type_ "table"
                    , Svg.Attributes.tableValues "0 0 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1"
                    ]
                    []
                ]
            ]
