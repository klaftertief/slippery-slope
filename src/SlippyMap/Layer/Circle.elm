module SlippyMap.Layer.Circle
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to render a Circle at a given location.

@docs Config, config, layer
-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform
import SlippyMap.Layer.GeoJson.Render as Render
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config msg
    = Config
        { radius : Float
        , style : List (Svg.Attribute msg)
        }


{-| -}
config : Float -> Config msg
config radius =
    Config
        { radius = radius
        , style =
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
layer : Config msg -> Location -> Layer msg
layer config location =
    Layer.withRender Layer.overlay (render config location)


render : Config msg -> Location -> Layer.RenderState -> Svg msg
render (Config internalConfig) { lon, lat } ({ locationToContainerPoint } as renderState) =
    let
        -- TODO: convert meters to pixels at given location
        radius =
            (internalConfig.radius / 100000)
                * (Transform.zoomScale renderState.zoom)

        style =
            [ Svg.Attributes.r (toString radius) ]
                ++ internalConfig.style

        point =
            ( lon, lat, 0 )

        project ( lon, lat, _ ) =
            locationToContainerPoint { lon = lon, lat = lat }

        renderConfig =
            Render.Config
                { project = project
                , style = always style
                }
    in
        Svg.g []
            (Render.renderGeoJsonPoint renderConfig
                style
                point
            )
