module Remote exposing (..)

import Dict exposing (Dict)
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Http
import Json.Decode as Decode exposing (Decoder)
import Mouse exposing (Position)
import RemoteData exposing (WebData, RemoteData(..))
import Shared
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.SimpleGeoJson as SimpleGeoJson
import Svg exposing (Svg)
import Svg.Attributes


type alias Model =
    { transform : Transform
    , tiles : Dict Tile.Comparable (WebData (List Feature))
    , drag : Maybe Drag
    }


type alias Feature =
    { properties : Maybe FeatureProperties
    , geometry : GeoJson.Geometry
    }


type alias FeatureProperties =
    { layerName : String
    , name : Maybe String
    , kind : String
    , minZoom : Float
    , sortRank : Int
    , labelPlacement : Bool
    }


type alias Drag =
    { last : Position
    , current : Position
    }


type Msg
    = GeoJsonTileResponse Tile.Comparable (WebData (List ( String, GeoJson )))
    | ZoomIn
    | ZoomOut
    | ZoomInAround Point
    | ZoomByAround Float Point
    | DragMsg DragMsg


type DragMsg
    = DragStart Position
    | DragAt Position
    | DragEnd Position


init : Transform -> ( Model, Cmd Msg )
init transform =
    let
        ( _, _, tilesToLoad, _ ) =
            LowLevel.toTransformScaleCoverCenter transform
    in
        { transform = transform
        , tiles = Dict.empty
        , drag = Nothing
        }
            ! (List.map getGeoJsonTile tilesToLoad)


view : Model -> Svg Msg
view model =
    Html.div []
        [ Html.node "style" [] [ Html.text layerStyles ]
        , LowLevel.container model.transform
            [ tileLayer (tileToGeoJson model) model.transform
            ]
        , gestureLayer model
        ]


gestureLayer : Model -> Html Msg
gestureLayer model =
    Html.div
        [ Html.Attributes.style
            [ ( "position", "absolute" )
            , ( "top", "0" )
            , ( "left", "0" )
            , ( "width", toString model.transform.width ++ "px" )
            , ( "height", toString model.transform.height ++ "px" )
            , ( "cursor"
              , (case model.drag of
                    Just _ ->
                        "-webkit-grabbing"

                    Nothing ->
                        "-webkit-grab"
                )
              )
            ]
        , Html.Events.on "dblclick"
            (Decode.map ZoomInAround clientPosition)
        , Html.Events.onWithOptions "wheel"
            { preventDefault = True
            , stopPropagation = True
            }
            (Decode.map2 ZoomByAround
                (Decode.field "deltaY" Decode.float
                    |> Decode.map (\y -> -y / 100)
                )
                clientPosition
            )
        , Html.Events.on "mousedown"
            (Decode.map (DragMsg << DragStart) Mouse.position)
        ]
        []


layerStyles : String
layerStyles =
    """
.tile polyline {
  fill: none;
  stroke: #fff;
  stroke-linejoin: round;
  stroke-linecap: round;
}
.tile polygon {
  fill: none;
  stroke: #fff;
  stroke-linejoin: round;
  stroke-linecap: round;
}
.tile circle {
  fill: none;
  stroke: #fff;
  stroke-linejoin: round;
  stroke-linecap: round;
}
.tile path {
  fill: none;
  stroke: #fff;
  stroke-linejoin: round;
  stroke-linecap: round;
}

.tile .water-layer, .tile .river, .tile .stream, .tile .canal { fill: none; stroke: #9DD9D2; stroke-width: 1.5px; }
.tile .water, .tile .ocean { fill: #9DD9D2; }
.tile .riverbank { fill: #9DD9D2; }
.tile .water_boundary, .tile .ocean_boundary, .tile .riverbank_boundary { fill: none; stroke: #93cbc4; stroke-width: 0.5px; }
.tile .major_road { stroke: #fb7b7a; stroke-width: 1px; }
.tile .minor_road { stroke: #999; stroke-width: 0.5px; }
.tile .highway { stroke: #FA4A48; stroke-width: 1.5px; }
.tile .transit-layer { stroke: none; }
.tile .buildings-layer { stroke: #987284; stroke-width: 0.15px; }
.tile .urban_area { fill: #987284; stroke: #987284; stroke-width: 0.15px; }
.tile .park, .tile .nature_reserve, .tile .wood, .tile .protected_land { fill: #88D18A; stroke: #88D18A; stroke-width: 0.5px; }
.tile .pier { fill: #fff; stroke: #fff; stroke-width: 0.5px; }
.tile .rail { stroke: #503D3F; stroke-width: 0.5px; }

/*
polyline {
    fill: none;
    stroke: #333;
    stroke-width: 1px;
}
polygon {
    fill: rgba(0,0,0,0.2);
    stroke: rgba(0,0,0,0.2);
    stroke-width: 1px;
}
circle {
    fill: rgba(255,0,0,0.2);
    stroke: rgba(255,0,0,0.2);
    stroke-width: 1px;
}
.meadow polygon,
.grass polygon,
.scrub polygon,
.farmland polygon {
    fill: green;
    stroke: green;
    stroke-width: 1px;
}
.earth polygon {
    fill: brown;
    stroke: brown;
    stroke-width: 1px;
}
.river *,
.water *,
.canal *,
.basin *,
.stream *,
.ocean * {
    stroke: blue;
}
.train polyline,
.tram polyline,
.subway polyline {
    stroke: black;
    stroke-dasharray: 5;
}
.county polyline,
.locality polyline {
    stroke: red;
}
.major_road polyline,
.highway polyline {
    stroke: orange;
}
*/
    """


tileLayer : (Tile -> ( Tile, List Feature )) -> Transform -> Svg msg
tileLayer tileToGeoJsonTile transform =
    LowLevel.tileLayer tileToGeoJsonTile (tile transform) transform


tile : Transform -> ( Tile, List Feature ) -> Svg msg
tile transform ( { z, x, y }, featureList ) =
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
        Svg.g []
            (featureList
                --|> List.filterMap isInteresting
                |> List.filter
                    (\{ properties } ->
                        case properties of
                            Nothing ->
                                False

                            Just props ->
                                not props.labelPlacement
                                    && (props.minZoom < transform.zoom)
                    )
                |> List.sortBy
                    (\{ properties } ->
                        case properties of
                            Nothing ->
                                0

                            Just props ->
                                props.sortRank
                    )
                |> List.concatMap (renderFeature project)
            )


renderFeature : (GeoJson.Position -> Point) -> Feature -> List (Svg msg)
renderFeature project { properties, geometry } =
    let
        attributes =
            Maybe.map
                (\p ->
                    [ Svg.Attributes.class (p.layerName ++ "-layer " ++ p.kind) ]
                )
                properties
                |> Maybe.withDefault []

        children =
            case geometry of
                GeoJson.Point position ->
                    SimpleGeoJson.renderGeoJsonPoint project attributes position

                GeoJson.MultiPoint positionList ->
                    List.concatMap (SimpleGeoJson.renderGeoJsonPoint project attributes) positionList

                GeoJson.LineString positionList ->
                    SimpleGeoJson.renderGeoJsonLineString project attributes positionList

                GeoJson.MultiLineString positionListList ->
                    List.concatMap (SimpleGeoJson.renderGeoJsonLineString project attributes) positionListList

                GeoJson.Polygon positionListList ->
                    SimpleGeoJson.renderGeoJsonPolygon project attributes positionListList

                GeoJson.MultiPolygon positionListListList ->
                    List.concatMap (SimpleGeoJson.renderGeoJsonPolygon project attributes) positionListListList

                GeoJson.GeometryCollection geometryList ->
                    List.concatMap (SimpleGeoJson.renderGeoJsonGeometry project attributes) geometryList
    in
        children


isInteresting : ( String, GeoJson ) -> Maybe GeoJson
isInteresting ( groupName, geojson ) =
    if groupName == "water" then
        Just geojson
    else
        Nothing


toFeatures : List ( String, GeoJson ) -> List Feature
toFeatures =
    List.concatMap (uncurry namedGeoJsonToFeatures)


namedGeoJsonToFeatures : String -> GeoJson -> List Feature
namedGeoJsonToFeatures layerName ( geoJsonObject, _ ) =
    namedGeoJsonObjectToFeatures layerName geoJsonObject


namedGeoJsonObjectToFeatures : String -> GeoJson.GeoJsonObject -> List Feature
namedGeoJsonObjectToFeatures layerName geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            [ { properties = Nothing, geometry = geometry } ]

        GeoJson.Feature featureObject ->
            [ namedGeoJsonFeatureObjectToFeature layerName featureObject ]

        GeoJson.FeatureCollection featureCollection ->
            List.map (namedGeoJsonFeatureObjectToFeature layerName) featureCollection


namedGeoJsonFeatureObjectToFeature : String -> GeoJson.FeatureObject -> Feature
namedGeoJsonFeatureObjectToFeature layerName { properties, geometry } =
    { properties = decodeProperties layerName properties
    , geometry =
        geometry
            |> Maybe.withDefault (GeoJson.GeometryCollection [])
    }


decodeProperties : String -> Decode.Value -> Maybe FeatureProperties
decodeProperties layerName properties =
    Decode.decodeValue (propertiesDecoder layerName) properties
        |> Result.toMaybe


propertiesDecoder : String -> Decoder FeatureProperties
propertiesDecoder layerName =
    Decode.succeed (FeatureProperties layerName)
        & Decode.maybe (Decode.field "name" Decode.string)
        & Decode.field "kind" Decode.string
        & Decode.field "min_zoom" Decode.float
        & Decode.field "sort_rank" Decode.int
        & (Decode.maybe (Decode.field "label_placement" Decode.bool)
            |> Decode.map
                (\placement ->
                    case placement of
                        Just bool ->
                            bool

                        Nothing ->
                            False
                )
          )


(&) : Decode.Decoder (a -> b) -> Decode.Decoder a -> Decode.Decoder b
(&) =
    Decode.map2 (<|)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GeoJsonTileResponse key data ->
            { model
                | tiles =
                    Dict.insert key
                        (RemoteData.map toFeatures data)
                        model.tiles
            }
                ! []

        ZoomIn ->
            let
                transform =
                    model.transform

                newTransform =
                    { transform | zoom = transform.zoom + 1 }

                newModel =
                    { model | transform = newTransform }

                tilesToLoad =
                    newGeoJsonTilesToLoad newModel
            in
                newModel ! (List.map getGeoJsonTile tilesToLoad)

        ZoomOut ->
            let
                transform =
                    model.transform

                newTransform =
                    { transform | zoom = transform.zoom - 1 }

                newModel =
                    { model | transform = newTransform }

                tilesToLoad =
                    newGeoJsonTilesToLoad newModel
            in
                newModel ! (List.map getGeoJsonTile tilesToLoad)

        ZoomInAround point ->
            let
                transform =
                    model.transform

                newTransform =
                    Transform.zoomToAround transform (transform.zoom + 1) point

                newModel =
                    { model | transform = newTransform }

                tilesToLoad =
                    newGeoJsonTilesToLoad newModel
            in
                newModel ! (List.map getGeoJsonTile tilesToLoad)

        ZoomByAround delta point ->
            let
                transform =
                    model.transform

                newTransform =
                    Transform.zoomToAround transform (transform.zoom + delta) point

                newModel =
                    { model | transform = newTransform }

                tilesToLoad =
                    newGeoJsonTilesToLoad newModel
            in
                newModel ! (List.map getGeoJsonTile tilesToLoad)

        DragMsg dragMsg ->
            let
                draggedModel =
                    updateDrag dragMsg model

                newModel =
                    { draggedModel
                        | transform = getTransform draggedModel
                    }

                tilesToLoad =
                    case dragMsg of
                        DragEnd _ ->
                            newGeoJsonTilesToLoad newModel

                        _ ->
                            []
            in
                newModel ! (List.map getGeoJsonTile tilesToLoad)


updateDrag : DragMsg -> Model -> Model
updateDrag dragMsg ({ drag } as model) =
    case dragMsg of
        DragStart xy ->
            { model | drag = Just (Drag xy xy) }

        DragAt xy ->
            { model
                | drag =
                    Maybe.map
                        (\{ current } -> Drag current xy)
                        drag
            }

        DragEnd _ ->
            { model | drag = Nothing }


getTransform : Model -> Transform
getTransform { transform, drag } =
    case drag of
        Nothing ->
            transform

        Just { last, current } ->
            Transform.moveTo transform
                { x = transform.width / 2 + toFloat (last.x - current.x)
                , y = transform.height / 2 + toFloat (last.y - current.y)
                }


newGeoJsonTilesToLoad : Model -> List Tile
newGeoJsonTilesToLoad model =
    let
        ( _, _, cover, _ ) =
            LowLevel.toTransformScaleCoverCenter model.transform

        tilesToLoad =
            Dict.diff
                (List.map (\tile -> ( Tile.toComparable tile, NotAsked )) cover
                    |> Dict.fromList
                )
                model.tiles
                |> Dict.keys
                |> List.map Tile.fromComparable
    in
        tilesToLoad


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.drag of
        Nothing ->
            Sub.none

        Just _ ->
            Sub.batch
                [ Mouse.moves (DragMsg << DragAt)
                , Mouse.ups (DragMsg << DragEnd)
                ]


main : Program Never Model Msg
main =
    Html.program
        { init = init Shared.transform
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


getGeoJsonTile : Tile -> Cmd Msg
getGeoJsonTile ({ z, x, y } as tile) =
    let
        comparable =
            Tile.toComparable tile

        url =
            ("https://tile.mapzen.com/mapzen/vector/v1/all/"
                ++ toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
                ++ ".json"
                ++ "?api_key=mapzen-A4166oq"
            )
    in
        Http.get url vectorTileDecoder
            |> RemoteData.sendRequest
            |> Cmd.map (GeoJsonTileResponse comparable)


vectorTileDecoder : Decoder (List ( String, GeoJson ))
vectorTileDecoder =
    Decode.keyValuePairs GeoJson.decoder


tileToGeoJson : Model -> Tile -> ( Tile, List Feature )
tileToGeoJson model tile =
    let
        comparable =
            Tile.toComparable tile

        tileGeoJson =
            Dict.get comparable model.tiles
                |> Maybe.withDefault RemoteData.NotAsked
                |> RemoteData.toMaybe
                |> Maybe.withDefault
                    []
    in
        ( tile, tileGeoJson )


clientPosition : Decoder Point
clientPosition =
    Decode.map2 Point
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
