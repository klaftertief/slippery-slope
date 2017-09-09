module SlippyMap.Layer.Circle
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to render a Circle at a given location.

@docs Config, config, layer

-}

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.GeoJson as GeoJsonLayer
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
            [ Svg.Attributes.stroke "#8833ff"
            , Svg.Attributes.strokeWidth "3"
            , Svg.Attributes.fill "#ff33ff"
            , Svg.Attributes.fillOpacity "0.2"
            , Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            ]
        }



-- LAYER


{-| -}
layer : Config msg -> Location -> Layer msg
layer (Config { style, radius }) location =
    GeoJsonLayer.layer
        (GeoJsonLayer.styleConfig (always style))
        (circle radius location)


circle : Float -> Location -> GeoJson
circle radius { lon, lat } =
    let
        distanceX =
            radius / (111.32 * cos (lat * pi / 180))

        distanceY =
            radius / 110.574

        steps =
            90

        points =
            List.range 0 steps
                |> List.map
                    (\i ->
                        let
                            theta =
                                (toFloat i / toFloat steps) * 2 * pi

                            x =
                                distanceX * cos theta

                            y =
                                distanceY * sin theta
                        in
                        ( lon + x, lat + y, 0 )
                    )
    in
    ( GeoJson.Geometry (GeoJson.Polygon [ points ])
    , Nothing
    )
