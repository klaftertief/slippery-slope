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
import SlippyMap.Layer.GeoJson.Render as Render
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
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
defaultConfig : Config msg
defaultConfig =
    Config
        { style =
            always
                [ Svg.Attributes.stroke "#3388ff"
                , Svg.Attributes.strokeWidth "3"
                , Svg.Attributes.fill "#3388ff"
                , Svg.Attributes.fillOpacity "0.2"
                , Svg.Attributes.strokeLinecap "round"
                , Svg.Attributes.strokeLinejoin "round"
                ]
        }



-- LAYER


{-| -}
layer : Config msg -> GeoJson -> Layer msg
layer config geoJson =
    Layer.withRender Layer.overlay (render config geoJson)


render : Config msg -> GeoJson -> Layer.RenderState -> Svg msg
render (Config internalConfig) geoJson ({ transform } as renderstate) =
    let
        centerPoint =
            renderstate.centerPoint

        project ( lon, lat, _ ) =
            Transform.locationToPoint transform
                { lon = lon, lat = lat }

        renderConfig =
            Render.Config
                { project = project
                , style = internalConfig.style
                }
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
            [ Render.renderGeoJson renderConfig geoJson ]
