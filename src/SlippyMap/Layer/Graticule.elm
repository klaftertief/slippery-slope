module SlippyMap.Layer.Graticule
    exposing
        ( graticule
        , layer
        )

{-| A layer to display graticlues.

@docs Config, defaultConfig, layer

-}

import GeoJson exposing (GeoJson)
import SlippyMap.Layer.GeoJson.Render as Render
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
    ( GeoJson.Geometry
        (GeoJson.MultiLineString (lons ++ lats))
    , Nothing
    )


lats : List (List GeoJson.Position)
lats =
    List.range -17 18
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


lons : List (List GeoJson.Position)
lons =
    List.range -80 80
        |> List.map toFloat
        |> List.map
            (\lat ->
                List.range -179 180
                    |> List.map toFloat
                    |> List.map
                        (\lon ->
                            ( lon - 0.001, lat * 10, 0 )
                        )
            )
