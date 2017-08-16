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
import SlippyMap.Layer.GeoJson.Render as Render
import SlippyMap.Map.Transform as Transform exposing (Transform)
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
            , Svg.Attributes.fill "#8833ff"
            , Svg.Attributes.fillOpacity "0.2"
            , Svg.Attributes.strokeLinecap "round"
            , Svg.Attributes.strokeLinejoin "round"
            ]
        }



-- LAYER


{-| -}
layer : Config msg -> Location -> Layer msg
layer config location =
    Layer.withRenderer Layer.overlay (render config location)


render : Config msg -> Location -> Transform -> Svg msg
render ((Config internalConfig) as config) location transform =
    let
        project ( lon, lat, _ ) =
            Transform.locationToScreenPoint transform (Location lon lat)

        renderConfig =
            Render.Config
                { project = project
                , style = always internalConfig.style
                }
    in
    Svg.g []
        [ Render.renderGeoJson renderConfig (circle config location)
        ]


{-| -}
circle : Config msg -> Location -> GeoJson
circle (Config { radius }) { lon, lat } =
    let
        distanceX =
            radius / (111.32 * cos (lat * pi / 180))

        distanceY =
            radius / 110.574

        steps =
            64

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
