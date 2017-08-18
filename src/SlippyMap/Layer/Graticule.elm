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
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.GeoJson.Render as Render
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
layer : Layer msg
layer =
    Layer.custom render Layer.overlay


render : Transform -> Svg msg
render transform =
    let
        project ( lon, lat, _ ) =
            Transform.locationToScreenPoint transform (Location lon lat)
    in
    Svg.g []
        [ Render.renderGeoJson (renderConfig project) graticule
        ]


style : GeoJson.FeatureObject -> List (Svg.Attribute msg)
style { properties } =
    [ Svg.Attributes.stroke "#666"
    , Svg.Attributes.strokeWidth "0.5"
    , Svg.Attributes.strokeOpacity "0.5"

    -- , Svg.Attributes.strokeDasharray "2"
    -- , Svg.Attributes.shapeRendering "crispEdges"
    , Svg.Attributes.fill "none"
    ]


renderConfig : (GeoJson.Position -> Point) -> Render.Config msg
renderConfig project =
    Render.Config
        { project = project
        , style = style
        }


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
                , properties =
                    Json.object
                        [ ( "title", Json.string "Some lat" )
                        ]
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
                , properties =
                    Json.object
                        [ ( "title", Json.string "Some lon" ) ]
                , geometry =
                    Just
                        (GeoJson.LineString points)
                }
            )
