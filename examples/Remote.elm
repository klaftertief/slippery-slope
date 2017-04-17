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


type alias Model =
    { transform : Transform
    , tiles : Dict Tile.Comparable (WebData (List ( String, GeoJson )))
    , drag : Maybe Drag
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
                        "grabbing"

                    Nothing ->
                        "grab"
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
polyline {
    fill: none;
    stroke: rgba(0,0,0,0.5);
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


tileLayer : (Tile -> ( Tile, List ( String, GeoJson ) )) -> Transform -> Svg msg
tileLayer tileToGeoJsonTile transform =
    LowLevel.tileLayer tileToGeoJsonTile (tile transform) transform


tile : Transform -> ( Tile, List ( String, GeoJson ) ) -> Svg msg
tile transform ( { z, x, y }, geojsonGroups ) =
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
            (geojsonGroups
                |> List.filterMap isInteresting
                |> List.map (SimpleGeoJson.renderGeoJson project)
            )


isInteresting : ( String, GeoJson ) -> Maybe GeoJson
isInteresting ( groupName, geojson ) =
    if groupName == "water" then
        Just geojson
    else
        Nothing


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GeoJsonTileResponse key data ->
            { model | tiles = Dict.insert key data model.tiles } ! []

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
                    LowLevel.zoomToAround transform (transform.zoom + 1) point

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
                    LowLevel.zoomToAround transform (transform.zoom + delta) point

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
            LowLevel.moveTo transform
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


tileToGeoJson : Model -> Tile -> ( Tile, List ( String, GeoJson ) )
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
