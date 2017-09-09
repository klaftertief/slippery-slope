module SlippyMap.Layer.GeoJson
    exposing
        ( Config
        , defaultConfig
        , layer
        )

{-| A layer to render GeoJson.

@docs Config, defaultConfig, layer

-}

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.GeoJson.Svg as Render
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Config as Map
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config msg
    = Config
        { style : GeoJson.FeatureObject -> List (Svg.Attribute msg)
        }


{-| -}
defaultConfig : (GeoJson.FeatureObject -> List (Svg.Attribute msg)) -> Config msg
defaultConfig events =
    Config
        { style =
            \featureObject ->
                [ Svg.Attributes.stroke "#3388ff"
                , Svg.Attributes.strokeWidth "2"
                , Svg.Attributes.fill "#3388ff"
                , Svg.Attributes.fillOpacity "0.2"
                , Svg.Attributes.strokeLinecap "round"
                , Svg.Attributes.strokeLinejoin "round"
                ]
                    ++ events featureObject
        }



-- LAYER


{-| -}
layer : Config msg -> GeoJson -> Layer msg
layer config geoJson =
    Layer.custom (render config geoJson) Layer.overlay


render : Config msg -> GeoJson -> Layer.RenderParameters msg -> Svg msg
render (Config internalConfig) geoJson { transform, mapConfig } =
    let
        size =
            Map.size mapConfig

        project ( lon, lat, _ ) =
            Transform.locationToScreenPoint transform (Location lon lat)

        renderConfig =
            Render.Config
                { project = project
                , style = internalConfig.style
                , renderPoint =
                    \attrs ->
                        Svg.circle (attrs ++ [ Svg.Attributes.r "8" ]) []
                }
    in
    Svg.svg
        [ -- Important for touch pinching
          Svg.Attributes.pointerEvents "none"
        , Svg.Attributes.width (toString size.x)
        , Svg.Attributes.height (toString size.y)
        , Svg.Attributes.style "position: absolute;"
        ]
        [ Render.renderGeoJson renderConfig geoJson ]
