module SlippyMap.Layer.GeoJson.Render exposing (..)

{-| GeoJson renderer.
@docs Config, pathPoints, points, renderGeoJson, renderGeoJsonFeatureObject, renderGeoJsonGeometry, renderGeoJsonLineString, renderGeoJsonObject, renderGeoJsonPoint, renderGeoJsonPolygon
-}

import GeoJson exposing (GeoJson)
import Json.Encode as Json
import SlippyMap.Geo.Point as Point exposing (Point)
import Svg exposing (Svg)
import Svg.Attributes


{-| TODO: support custom point rendering, see leaflet
-}
type Config msg
    = Config
        { project : GeoJson.Position -> Point
        , style : GeoJson.FeatureObject -> List (Svg.Attribute msg)
        }


{-| -}
renderGeoJson : Config msg -> GeoJson -> Svg msg
renderGeoJson config ( geoJsonObject, _ ) =
    Svg.g []
        (renderGeoJsonObject config geoJsonObject)


{-| -}
renderGeoJsonObject : Config msg -> GeoJson.GeoJsonObject -> List (Svg msg)
renderGeoJsonObject config geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            --renderGeoJsonGeometry config [] geometry
            renderGeoJsonFeatureObject config
                { id = Nothing
                , properties = Json.null
                , geometry = Just geometry
                }

        GeoJson.Feature featureObject ->
            renderGeoJsonFeatureObject config featureObject

        GeoJson.FeatureCollection featureCollection ->
            List.concatMap (renderGeoJsonFeatureObject config) featureCollection


{-| -}
renderGeoJsonFeatureObject : Config msg -> GeoJson.FeatureObject -> List (Svg msg)
renderGeoJsonFeatureObject ((Config { style }) as config) featureObject =
    Maybe.map (renderGeoJsonGeometry config (style featureObject))
        featureObject.geometry
        |> Maybe.withDefault []


{-| -}
renderGeoJsonGeometry : Config msg -> List (Svg.Attribute msg) -> GeoJson.Geometry -> List (Svg msg)
renderGeoJsonGeometry config attributes geometry =
    case geometry of
        GeoJson.Point position ->
            renderGeoJsonPoint config attributes position

        GeoJson.MultiPoint positionList ->
            List.concatMap (renderGeoJsonPoint config attributes) positionList

        GeoJson.LineString positionList ->
            renderGeoJsonLineString config attributes positionList

        GeoJson.MultiLineString positionListList ->
            List.concatMap (renderGeoJsonLineString config attributes) positionListList

        GeoJson.Polygon positionListList ->
            renderGeoJsonPolygon config attributes positionListList

        GeoJson.MultiPolygon positionListListList ->
            List.concatMap (renderGeoJsonPolygon config attributes) positionListListList

        GeoJson.GeometryCollection geometryList ->
            List.concatMap (renderGeoJsonGeometry config attributes) geometryList


{-| -}
renderGeoJsonPoint : Config msg -> List (Svg.Attribute msg) -> GeoJson.Position -> List (Svg msg)
renderGeoJsonPoint (Config internalConfig) attributes position =
    let
        { x, y } =
            internalConfig.project position
    in
        [ Svg.circle
            (attributes
                ++ [ Svg.Attributes.cx (toString x)
                   , Svg.Attributes.cy (toString y)
                   ]
            )
            []
        ]


{-| -}
renderGeoJsonLineString : Config msg -> List (Svg.Attribute msg) -> List GeoJson.Position -> List (Svg msg)
renderGeoJsonLineString config attributes positionList =
    [ Svg.path
        (attributes
            ++ [ pathPoints config positionList
                    |> Svg.Attributes.points
               ]
        )
        []
    ]


{-| -}
renderGeoJsonPolygon : Config msg -> List (Svg.Attribute msg) -> List (List GeoJson.Position) -> List (Svg msg)
renderGeoJsonPolygon config attributes positionListList =
    let
        pathDefinition =
            (positionListList
                |> List.map (pathPoints config)
                |> String.join " "
            )
                ++ "Z"
    in
        [ Svg.path
            (attributes
                ++ [ Svg.Attributes.fillRule "evenodd", Svg.Attributes.d pathDefinition ]
            )
            []
        ]


{-| -}
pathPoints : Config msg -> List GeoJson.Position -> String
pathPoints (Config internalConfig) positionList =
    positionList
        |> List.map
            (\position ->
                internalConfig.project position
                    |> (\{ x, y } -> toString x ++ " " ++ toString y)
            )
        |> String.join "L"
        |> (\ll -> "M" ++ ll)


{-| -}
points : Config msg -> List GeoJson.Position -> String
points (Config internalConfig) positionList =
    List.foldl
        (\position accum ->
            internalConfig.project position
                |> (\{ x, y } -> toString x ++ "," ++ toString y)
                |> (\xy -> accum ++ " " ++ xy)
        )
        ""
        positionList
