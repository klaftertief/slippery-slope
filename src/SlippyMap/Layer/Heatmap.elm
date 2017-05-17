module SlippyMap.Layer.Heatmap
    exposing
        ( Config
        , defaultConfig
        , layer
        )

{-| A heatmap layer.

@docs Config, defaultConfig, layer
-}

import Color exposing (Color)
import Heatmap
import Heatmap.Gradient as Heatmap exposing (Gradient)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config data
    = Config
        { heatmap : Transform -> Heatmap.Config ( Location, data )
        }


{-| -}
defaultConfig : Config Float
defaultConfig =
    Config
        { heatmap = defaultHeatmapConfig
        }


defaultHeatmapConfig : Transform -> Heatmap.Config ( Location, Float )
defaultHeatmapConfig transform =
    Heatmap.config
        { toPoint =
            (\( location, value ) ->
                let
                    { x, y } =
                        Transform.locationToPoint transform location
                in
                    { x = x, y = y, weight = value }
            )
        , gradient = defaultGradient
        }
        |> Heatmap.withRadius (transform.zoom * 2)


defaultGradient : Gradient
defaultGradient =
    [ ( 0.4, Color.rgb 0 0 255 )
    , ( 0.5, Color.rgb 0 255 255 )
    , ( 0.7, Color.rgb 0 255 0 )
    , ( 0.8, Color.rgb 255 255 0 )
    , ( 1, Color.rgb 255 0 0 )
    ]



-- LAYER


{-| -}
layer : Config data -> List ( Location, data ) -> Layer msg
layer config dataLocations =
    Layer.withRender Layer.overlay (render config dataLocations)


render : Config data -> List ( Location, data ) -> Layer.RenderState -> Svg msg
render (Config config) dataLocations ({ transform } as renderState) =
    let
        centerPoint =
            renderState.centerPoint

        bounds =
            renderState.locationBounds

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
            [ Heatmap.view (config.heatmap transform)
                dataLocationsFiltered
            ]
