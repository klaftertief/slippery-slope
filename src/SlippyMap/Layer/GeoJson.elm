module SlippyMap.Layer.GeoJson
    exposing
        ( Config
        , defaultConfig
        , layer
        , styleConfig
        )

{-| A layer to render GeoJson.

@docs Config, defaultConfig, styleConfig, layer

-}

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.GeoJson.Svg as Render
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Map as Map exposing (Map)
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


{-| -}
styleConfig : (GeoJson.FeatureObject -> List (Svg.Attribute msg)) -> Config msg
styleConfig style =
    Config
        { style = style }



-- LAYER


{-| -}
layer : Config msg -> GeoJson -> Layer msg
layer config geoJson =
    Layer.custom (render config geoJson) Layer.overlay


render : Config msg -> GeoJson -> Map msg -> Svg msg
render (Config internalConfig) geoJson map =
    let
        size =
            Map.size map

        project ( lon, lat, _ ) =
            Map.locationToScreenPoint map (Location lon lat)

        renderConfig =
            Render.config project
    in
    Svg.svg
        [ -- Important for touch pinching
          Svg.Attributes.pointerEvents "none"
        , Svg.Attributes.width (toString size.x)
        , Svg.Attributes.height (toString size.y)
        , Svg.Attributes.style "position: absolute;"
        ]
        [ Render.renderGeoJson renderConfig geoJson ]
