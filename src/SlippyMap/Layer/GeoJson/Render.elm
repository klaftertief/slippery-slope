module SlippyMap.Layer.GeoJson.Render exposing (..)

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.Point as Point exposing (Point)
import Svg exposing (Svg)
import Svg.Attributes


renderGeoJson : (GeoJson.Position -> Point) -> GeoJson -> Svg msg
renderGeoJson project ( geoJsonObject, _ ) =
    Svg.g []
        (renderGeoJsonObject project geoJsonObject)


renderGeoJsonObject : (GeoJson.Position -> Point) -> GeoJson.GeoJsonObject -> List (Svg msg)
renderGeoJsonObject project geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            renderGeoJsonGeometry project [] geometry

        GeoJson.Feature featureObject ->
            renderGeoJsonFeatureObject project featureObject

        GeoJson.FeatureCollection featureCollection ->
            List.concatMap (renderGeoJsonFeatureObject project) featureCollection


renderGeoJsonFeatureObject : (GeoJson.Position -> Point) -> GeoJson.FeatureObject -> List (Svg msg)
renderGeoJsonFeatureObject project featureObject =
    Maybe.map (renderGeoJsonGeometry project [])
        featureObject.geometry
        |> Maybe.withDefault []


renderGeoJsonGeometry : (GeoJson.Position -> Point) -> List (Svg.Attribute msg) -> GeoJson.Geometry -> List (Svg msg)
renderGeoJsonGeometry project attributes geometry =
    case geometry of
        GeoJson.Point position ->
            renderGeoJsonPoint project attributes position

        GeoJson.MultiPoint positionList ->
            List.concatMap (renderGeoJsonPoint project attributes) positionList

        GeoJson.LineString positionList ->
            renderGeoJsonLineString project attributes positionList

        GeoJson.MultiLineString positionListList ->
            List.concatMap (renderGeoJsonLineString project attributes) positionListList

        GeoJson.Polygon positionListList ->
            renderGeoJsonPolygon project attributes positionListList

        GeoJson.MultiPolygon positionListListList ->
            List.concatMap (renderGeoJsonPolygon project attributes) positionListListList

        GeoJson.GeometryCollection geometryList ->
            List.concatMap (renderGeoJsonGeometry project attributes) geometryList


renderGeoJsonPoint : (GeoJson.Position -> Point) -> List (Svg.Attribute msg) -> GeoJson.Position -> List (Svg msg)
renderGeoJsonPoint project attributes position =
    let
        { x, y } =
            project position
    in
        [ Svg.circle
            (attributes
                ++ [ Svg.Attributes.cx (toString x)
                   , Svg.Attributes.cy (toString y)
                   ]
            )
            []
        ]


renderGeoJsonLineString : (GeoJson.Position -> Point) -> List (Svg.Attribute msg) -> List GeoJson.Position -> List (Svg msg)
renderGeoJsonLineString project attributes positionList =
    [ Svg.polyline
        (attributes
            ++ [ points project positionList
                    |> Svg.Attributes.points
               ]
        )
        []
    ]


renderGeoJsonPolygon : (GeoJson.Position -> Point) -> List (Svg.Attribute msg) -> List (List GeoJson.Position) -> List (Svg msg)
renderGeoJsonPolygon project attributes positionListList =
    let
        pathDefinition =
            positionListList
                |> List.map (pathPoints project)
                |> String.join " "
    in
        [ Svg.path
            (attributes
                ++ [ Svg.Attributes.fillRule "evenodd", Svg.Attributes.d pathDefinition ]
            )
            []
        ]


pathPoints : (GeoJson.Position -> Point) -> List GeoJson.Position -> String
pathPoints project positionList =
    positionList
        |> List.map
            (\position ->
                project position
                    |> (\{ x, y } -> toString x ++ " " ++ toString y)
            )
        |> String.join "L"
        |> (\ll -> "M" ++ ll)


points : (GeoJson.Position -> Point) -> List GeoJson.Position -> String
points project positionList =
    List.foldl
        (\position accum ->
            project position
                |> (\{ x, y } -> toString x ++ "," ++ toString y)
                |> (\xy -> accum ++ " " ++ xy)
        )
        ""
        positionList
