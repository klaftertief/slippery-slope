module Remote exposing (..)

import Dict exposing (Dict)
import GeoJson exposing (GeoJson)
import Html
import Http
import Json.Decode as Decode exposing (Decoder)
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
    }


type Msg
    = GeoJsonTileResponse Tile.Comparable (WebData GeoJson)
    | ZoomIn
    | ZoomOut
    | ZoomInAround Point
    | ZoomByAround Float Point


init : Transform -> ( Model, Cmd Msg )
init transform =
    let
        ( _, _, tilesToLoad, _ ) =
            LowLevel.toTransformScaleCoverCenter transform
    in
        { transform = transform
        , tiles = Dict.empty
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
            , Svg.Events.on "dblclick"
                (Decode.map ZoomInAround clientPosition)
            , Svg.Events.on "wheel"
                (Decode.map2 ZoomByAround
                    (Decode.field "deltaY" Decode.float
                        |> Decode.map (\y -> -y / 100)
                    )
                    clientPosition
                )
            ]
            []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    withNewTilesToLoad <|
        case msg of
            GeoJsonTileResponse key data ->
                { model | tiles = Dict.insert key data model.tiles }

            ZoomIn ->
                let
                    transform =
                        model.transform

                    newTransform =
                        { transform | zoom = transform.zoom + 1 }
                in
                    { model | transform = newTransform }

            ZoomOut ->
                let
                    transform =
                        model.transform

                    newTransform =
                        { transform | zoom = transform.zoom - 1 }
                in
                    { model | transform = newTransform }

            ZoomInAround point ->
                let
                    transform =
                        model.transform

                    newTransform =
                        LowLevel.zoomToAround transform (transform.zoom + 1) point
                in
                    { model | transform = newTransform }

            ZoomByAround delta point ->
                let
                    transform =
                        model.transform

                    newTransform =
                        LowLevel.zoomToAround transform (transform.zoom + delta) point
                in
                    { model | transform = newTransform }


withNewTilesToLoad : Model -> ( Model, Cmd Msg )
withNewTilesToLoad model =
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
        model ! (List.map getGeoJsonTile tilesToLoad)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


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
