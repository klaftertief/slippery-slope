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
        [ renderGeoJsonObject project geoJsonObject ]


renderGeoJsonObject : (GeoJson.Position -> Point) -> GeoJson.GeoJsonObject -> Svg msg
renderGeoJsonObject project geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            renderGeoJsonGeometry project geometry

        GeoJson.Feature featureObject ->
            renderGeoJsonFeatureObject project featureObject

        GeoJson.FeatureCollection featureCollection ->
            Svg.g []
                (List.map (renderGeoJsonFeatureObject project) featureCollection)


renderGeoJsonFeatureObject : (GeoJson.Position -> Point) -> GeoJson.FeatureObject -> Svg msg
renderGeoJsonFeatureObject project featureObject =
    Maybe.map (renderGeoJsonGeometry project) featureObject.geometry
        |> Maybe.withDefault (Svg.text "")


renderGeoJsonGeometry : (GeoJson.Position -> Point) -> GeoJson.Geometry -> Svg msg
renderGeoJsonGeometry project geometry =
    case geometry of
        GeoJson.Point position ->
            renderGeoJsonPoint project position

        GeoJson.MultiPoint positionList ->
            Svg.g []
                (List.map (renderGeoJsonPoint project) positionList)

        GeoJson.LineString positionList ->
            renderGeoJsonLineString project positionList

        GeoJson.MultiLineString positionListList ->
            Svg.g []
                (List.map (renderGeoJsonLineString project) positionListList)

        GeoJson.Polygon positionListList ->
            renderGeoJsonPolygon project positionListList

        GeoJson.MultiPolygon positionListListList ->
            Svg.g []
                (List.map (renderGeoJsonPolygon project) positionListListList)

        GeoJson.GeometryCollection geometryList ->
            Svg.g []
                (List.map (renderGeoJsonGeometry project) geometryList)


renderGeoJsonPoint : (GeoJson.Position -> Point) -> GeoJson.Position -> Svg msg
renderGeoJsonPoint project position =
    let
        { x, y } =
            project position
    in
        Svg.circle
            [ Svg.Attributes.cx (toString x)
            , Svg.Attributes.cy (toString y)
            , Svg.Attributes.r "2"
            ]
            []


renderGeoJsonLineString : (GeoJson.Position -> Point) -> List GeoJson.Position -> Svg msg
renderGeoJsonLineString project positionList =
    Svg.polyline
        [ positionList
            |> List.map project
            |> List.map (\{ x, y } -> toString x ++ "," ++ toString y)
            |> String.join " "
            |> Svg.Attributes.points
        , Svg.Attributes.fill "none"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.strokeWidth "1"
        ]
        []


renderGeoJsonPolygon : (GeoJson.Position -> Point) -> List (List GeoJson.Position) -> Svg msg
renderGeoJsonPolygon project positionListList =
    Svg.g []
        (List.map
            (\positionList ->
                Svg.polygon
                    [ positionList
                        |> List.map project
                        |> List.map (\{ x, y } -> toString x ++ "," ++ toString y)
                        |> String.join " "
                        |> Svg.Attributes.points
                    , Svg.Attributes.fill "#999"
                    , Svg.Attributes.stroke "#999"
                    , Svg.Attributes.strokeWidth "1"
                    ]
                    []
            )
            positionListList
        )
