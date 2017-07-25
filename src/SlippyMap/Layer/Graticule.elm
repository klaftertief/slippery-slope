module SlippyMap.Layer.Graticule
    exposing
        ( graticule
        , layer
        )

{-| A layer to display graticlues.

@docs layer, graticule

-}

import GeoJson exposing (GeoJson)
import Json.Encode as Json
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)


{-| -}
layer : Layer msg
layer =
    Layer.withRender Layer.overlay render


render : Layer.RenderState -> Svg msg
render renderState =
    Svg.g [] []


{-| -}
graticule : GeoJson
graticule =
    ( GeoJson.FeatureCollection (lons ++ lats)
    , Nothing
    )


lats : List GeoJson.FeatureObject
lats =
    List.range -18 18
        |> List.map toFloat
        |> List.map
            (\lon ->
                List.range -80 80
                    |> List.map toFloat
                    |> List.map
                        (\lat ->
                            ( lon * 10 - 0.001, lat, 0 )
                        )
            )
        |> List.map
            (\points ->
                { id = Nothing
                , properties = Json.null
                , geometry =
                    Just
                        (GeoJson.LineString points)
                }
            )


lons : List GeoJson.FeatureObject
lons =
    List.range -8 8
        |> List.map toFloat
        |> List.map
            (\lat ->
                List.range -180 180
                    |> List.map toFloat
                    |> List.map
                        (\lon ->
                            ( lon - 0.001, lat * 10, 0 )
                        )
            )
        |> List.map
            (\points ->
                { id = Nothing
                , properties = Json.null
                , geometry =
                    Just
                        (GeoJson.LineString points)
                }
            )
