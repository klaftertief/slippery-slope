module Remote exposing (..)

import Dict exposing (Dict)
import GeoJson exposing (GeoJson)
import Html
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
import Svg.Events


type alias Model =
    { transform : Transform
    , tiles : Dict Tile.Comparable (WebData GeoJson)
    , drag : Maybe Drag
    }


type alias Drag =
    { last : Position
    , current : Position
    }


type Msg
    = GeoJsonTileResponse Tile.Comparable (WebData GeoJson)
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
    LowLevel.container model.transform
        [ SimpleGeoJson.tileLayer (tileToGeoJson model) model.transform
        , Svg.rect
            [ Svg.Attributes.visibility "hidden"
            , Svg.Attributes.pointerEvents "all"
            , Svg.Attributes.width (toString model.transform.width)
            , Svg.Attributes.height (toString model.transform.height)
            , Svg.Attributes.style
                (case model.drag of
                    Just _ ->
                        "cursor:-webkit-grabbing;cursor:grabbing;"

                    Nothing ->
                        "cursor:-webkit-grab;cursor:grab;"
                )
            , Svg.Events.on "dblclick"
                (Decode.map ZoomInAround clientPosition)
            , Svg.Events.on "wheel"
                (Decode.map2 ZoomByAround
                    (Decode.field "deltaY" Decode.float
                        |> Decode.map (\y -> -y / 100)
                    )
                    clientPosition
                )
            , Svg.Events.on "mousedown"
                (Decode.map (DragMsg << DragStart) Mouse.position)
            ]
            []
        ]


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
                    newGeoJsonTilesToLoad newModel
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
            ("https://tile.mapzen.com/mapzen/vector/v1/earth/"
                ++ toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
                ++ ".json"
                ++ "?api_key=mapzen-A4166oq"
            )
    in
        Http.get url GeoJson.decoder
            |> RemoteData.sendRequest
            |> Cmd.map (GeoJsonTileResponse comparable)


vectorTileDecoder : Decoder (List ( String, GeoJson ))
vectorTileDecoder =
    Decode.keyValuePairs GeoJson.decoder


tileToGeoJson : Model -> Tile -> ( Tile, GeoJson )
tileToGeoJson model tile =
    let
        comparable =
            Tile.toComparable tile

        tileGeoJson =
            Dict.get comparable model.tiles
                |> Maybe.withDefault RemoteData.NotAsked
                |> RemoteData.toMaybe
                |> Maybe.withDefault
                    ( GeoJson.FeatureCollection [], Nothing )
    in
        ( tile, tileGeoJson )


clientPosition : Decoder Point
clientPosition =
    Decode.map2 Point
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
