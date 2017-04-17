module SlippyMap.SimpleGeoJson exposing (..)

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Lazy


tileLayer : (Tile -> ( Tile, GeoJson )) -> Transform -> Svg msg
tileLayer tileToGeoJsonTile transform =
    LowLevel.tileLayer tileToGeoJsonTile (Svg.Lazy.lazy (tile transform)) transform


tile : Transform -> ( Tile, GeoJson ) -> Svg msg
tile transform ( { z, x, y }, geojson ) =
    let
        ( _, scale, _, _ ) =
            LowLevel.toTransformScaleCoverCenter transform

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        coordinatePoint =
            Transform.coordinateToPoint transform tileCoordinate

        project ( lon, lat, _ ) =
            Transform.locationToPoint transform { lon = lon, lat = lat }
                |> (\{ x, y } ->
                        { x = (x - coordinatePoint.x) / scale
                        , y = (y - coordinatePoint.y) / scale
                        }
                   )
    in
        renderGeoJson project geojson


renderGeoJson : (GeoJson.Position -> Point) -> GeoJson -> Svg msg
renderGeoJson project ( geoJsonObject, _ ) =
    Svg.g []
        (renderGeoJsonObject project geoJsonObject)


renderGeoJsonObject : (GeoJson.Position -> Point) -> GeoJson.GeoJsonObject -> List (Svg msg)
renderGeoJsonObject project geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            renderGeoJsonGeometry project geometry

        GeoJson.Feature featureObject ->
            renderGeoJsonFeatureObject project featureObject

        GeoJson.FeatureCollection featureCollection ->
            List.concatMap (renderGeoJsonFeatureObject project) featureCollection


renderGeoJsonFeatureObject : (GeoJson.Position -> Point) -> GeoJson.FeatureObject -> List (Svg msg)
renderGeoJsonFeatureObject project featureObject =
    Maybe.map (renderGeoJsonGeometry project)
        featureObject.geometry
        |> Maybe.withDefault []


renderGeoJsonGeometry : (GeoJson.Position -> Point) -> GeoJson.Geometry -> List (Svg msg)
renderGeoJsonGeometry project geometry =
    case geometry of
        GeoJson.Point position ->
            renderGeoJsonPoint project position

        GeoJson.MultiPoint positionList ->
            List.concatMap (renderGeoJsonPoint project) positionList

        GeoJson.LineString positionList ->
            renderGeoJsonLineString project positionList

        GeoJson.MultiLineString positionListList ->
            List.concatMap (renderGeoJsonLineString project) positionListList

        GeoJson.Polygon positionListList ->
            renderGeoJsonPolygon project positionListList

        GeoJson.MultiPolygon positionListListList ->
            List.concatMap (renderGeoJsonPolygon project) positionListListList

        GeoJson.GeometryCollection geometryList ->
            List.concatMap (renderGeoJsonGeometry project) geometryList


renderGeoJsonPoint : (GeoJson.Position -> Point) -> GeoJson.Position -> List (Svg msg)
renderGeoJsonPoint project position =
    let
        { x, y } =
            project position
    in
        [ Svg.circle
            [ Svg.Attributes.cx (toString x)
            , Svg.Attributes.cy (toString y)
            , Svg.Attributes.r "2"
            ]
            []
        ]


renderGeoJsonLineString : (GeoJson.Position -> Point) -> List GeoJson.Position -> List (Svg msg)
renderGeoJsonLineString project positionList =
    [ Svg.polyline
        [ points project positionList
            |> Svg.Attributes.points
        ]
        []
    ]


renderGeoJsonPolygon : (GeoJson.Position -> Point) -> List (List GeoJson.Position) -> List (Svg msg)
renderGeoJsonPolygon project positionListList =
    List.map
        (\positionList ->
            Svg.polygon
                [ points project positionList
                    |> Svg.Attributes.points
                ]
                []
        )
        positionListList


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
