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
type Config
    = Config


{-| -}
defaultConfig : Config
defaultConfig =
    Config



-- LAYER


{-| -}
layer : Config -> GeoJson -> Layer msg
layer config geoJson =
    Layer.withRender (Layer.withoutAttribution) (render config geoJson)


render : Config -> GeoJson -> Transform -> Svg msg
render config geoJson transform =
    let
        centerPoint =
            Transform.centerPoint transform

        project ( lon, lat, _ ) =
            Transform.locationToPoint transform
                { lon = lon, lat = lat }
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
            [ Render.renderGeoJson project geoJson ]
