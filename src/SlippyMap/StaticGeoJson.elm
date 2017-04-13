module SlippyMap.StaticGeoJSon exposing (..)

import GeoJson exposing (GeoJson)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.Geo.PixelPoint as PixelPoint exposing (PixelPoint)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


tileLayer : (Tile -> GeoJson) -> Transform -> Svg msg
tileLayer tileToGeoJson transform =
    LowLevel.tileLayer (tile tileToGeoJson transform) transform


tile : (Tile -> GeoJson) -> Transform -> Tile -> Svg msg
tile tileToGeoJson transform ({ z, x, y } as tile) =
    let
        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        coordinatePoint =
            Transform.coordinateToPixelPoint transform tileCoordinate

        project ( lon, lat, _ ) =
            Transform.locationToPixelPoint transform { lon = lon, lat = lat }
                |> (\{ x, y } -> { x = x - coordinatePoint.x, y = y - coordinatePoint.y })

        geojson =
            tileToGeoJson tile
    in
        renderGeoJson project geojson


renderGeoJson : (GeoJson.Position -> PixelPoint) -> GeoJson -> Svg msg
renderGeoJson project ( geoJsonObject, _ ) =
    Svg.g []
        [ renderGeoJsonObject project geoJsonObject ]


renderGeoJsonObject : (GeoJson.Position -> PixelPoint) -> GeoJson.GeoJsonObject -> Svg msg
renderGeoJsonObject project geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            renderGeoJsonGeometry project geometry

        GeoJson.Feature featureObject ->
            renderGeoJsonFeatureObject project featureObject

        GeoJson.FeatureCollection featureCollection ->
            Svg.g []
                (List.map (renderGeoJsonFeatureObject project) featureCollection)


renderGeoJsonFeatureObject : (GeoJson.Position -> PixelPoint) -> GeoJson.FeatureObject -> Svg msg
renderGeoJsonFeatureObject project featureObject =
    Maybe.map (renderGeoJsonGeometry project) featureObject.geometry
        |> Maybe.withDefault (Svg.text "")


renderGeoJsonGeometry : (GeoJson.Position -> PixelPoint) -> GeoJson.Geometry -> Svg msg
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


renderGeoJsonPoint : (GeoJson.Position -> PixelPoint) -> GeoJson.Position -> Svg msg
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


renderGeoJsonLineString : (GeoJson.Position -> PixelPoint) -> List GeoJson.Position -> Svg msg
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


renderGeoJsonPolygon : (GeoJson.Position -> PixelPoint) -> List (List GeoJson.Position) -> Svg msg
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
                    , Svg.Attributes.strokeWidth "0"
                    ]
                    []
            )
            positionListList
        )
