module Layer.Debug exposing (layer)

{-| A debug layer.

Used to test layer "plugins".

@docs layer

-}

import GeoJson exposing (GeoJson)
import Json.Encode as Json
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.GeoJson.Svg as Render
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- LAYER


{-| -}
layer : Layer msg
layer =
    TileLayer.layer identity tile TileLayer.config


{-| TODO: think about how to make it not always depend on Transform.
-}
tile : Transform -> Tile -> Svg msg
tile transform ({ z, x, y } as tile) =
    let
        scale =
            transform.crs.scale transform.zoom / transform.crs.scale (toFloat z)

        size =
            256 * scale

        tileScale =
            transform.crs.scale
                (transform.zoom - toFloat z)

        originPoint =
            Transform.origin transform

        tilePoint =
            { x = toFloat x
            , y = toFloat y
            }
                |> Point.multiplyBy tileScale
                |> Point.subtract originPoint

        tileLocations =
            List.concat
                [ List.range 0 10
                    |> List.map
                        (\i ->
                            { x = toFloat x + toFloat i * 0.1
                            , y = toFloat y
                            }
                        )
                , List.range 0 10
                    |> List.map
                        (\i ->
                            { x = toFloat x + 1
                            , y = toFloat y + toFloat i * 0.1
                            }
                        )
                , List.range 0 10
                    |> List.map
                        (\i ->
                            { x = toFloat x + 1 - toFloat i * 0.1
                            , y = toFloat y + 1
                            }
                        )
                , List.range 0 10
                    |> List.map
                        (\i ->
                            { x = toFloat x
                            , y = toFloat y + 1 - toFloat i * 0.1
                            }
                        )
                ]
                |> List.map
                    (Point.multiplyBy tileScale
                        >> Point.subtract originPoint
                        >> Transform.pointToLocation transform
                        >> (\{ lon, lat } ->
                                ( lon, lat, 0 )
                           )
                    )

        project ( lon, lat, _ ) =
            { lon = lon, lat = lat }
                |> Transform.locationToPoint transform
                |> Point.subtract tilePoint
    in
    Svg.g
        []
        -- [ Svg.rect
        --     [ Svg.Attributes.fill "none"
        --     , Svg.Attributes.strokeWidth "1"
        --     , Svg.Attributes.stroke "#ff0000"
        --     , Svg.Attributes.x "0"
        --     , Svg.Attributes.y "0"
        --     , Svg.Attributes.width (toString size)
        --     , Svg.Attributes.height (toString size)
        --     ]
        --     []
        -- , Svg.text_
        --     [ Svg.Attributes.textAnchor "middle"
        --     , Svg.Attributes.x (toString <| size / 2)
        --     , Svg.Attributes.y (toString <| size / 2)
        --     ]
        --     [ Svg.text (toString tile) ]
        -- ]
        [ Svg.rect
            [ Svg.Attributes.fill "none"
            , Svg.Attributes.strokeWidth "3"
            , Svg.Attributes.stroke "#ffff00"
            , Svg.Attributes.x "0"
            , Svg.Attributes.y "0"
            , Svg.Attributes.width (toString size)
            , Svg.Attributes.height (toString size)
            ]
            []
        , Render.renderGeoJson (renderConfig project)
            ( GeoJson.Feature
                { id = Nothing
                , properties = Json.null
                , geometry =
                    Just (GeoJson.Polygon [ tileLocations ])
                }
            , Nothing
            )
        ]


style : GeoJson.FeatureObject -> List (Svg.Attribute msg)
style { properties } =
    [ Svg.Attributes.stroke "#ff0000"
    , Svg.Attributes.strokeWidth "1"
    , Svg.Attributes.fill "none"
    ]


renderConfig : (GeoJson.Position -> Point) -> Render.Config msg
renderConfig project =
    Render.Config
        { project = project
        , style = style
        }
