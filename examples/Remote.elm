module Remote exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Dict exposing (Dict)
import GeoJson exposing (GeoJson)
import Html
import Http
import RemoteData exposing (WebData, RemoteData(..))
import Shared
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.LowLevel as LowLevel
import SlippyMap.SimpleGeoJson as SimpleGeoJson
import Svg exposing (Svg)


type alias Model =
    { transform : Transform
    , tiles : Dict Tile.Comparable (WebData GeoJson)
    }


type Msg
    = GeoJsonTileResponse Tile.Comparable (WebData GeoJson)


init : ( Model, Cmd Msg )
init =
    let
        transform =
            Shared.transform

        -- Change transform zoom to an integer as tile data is not available for float values in general.
        tileTransform =
            { transform | zoom = toFloat (round transform.zoom) }

        -- As the zoom in the transform is changed the tiles need to be scaled to match the actual zoom value.
        scale =
            Transform.zoomScale
                (transform.zoom - tileTransform.zoom)

        centerPoint =
            Transform.locationToPoint tileTransform tileTransform.center

        -- Scale the bounds points to take the zoom differences into account
        ( topLeftCoordinate, bottomRightCoordinate ) =
            ( Transform.pointToCoordinate tileTransform
                { x = centerPoint.x - tileTransform.width / 2 / scale
                , y = centerPoint.y - tileTransform.height / 2 / scale
                }
            , Transform.pointToCoordinate tileTransform
                { x = centerPoint.x + tileTransform.width / 2 / scale
                , y = centerPoint.y + tileTransform.height / 2 / scale
                }
            )

        bounds =
            { topLeft = topLeftCoordinate
            , topRight =
                { topLeftCoordinate | column = bottomRightCoordinate.column }
            , bottomRight = bottomRightCoordinate
            , bottomLeft =
                { topLeftCoordinate | row = bottomRightCoordinate.row }
            }

        -- TODO: pull out tiles calculation in a SlippyMap helper
        tilesToLoad =
            Tile.cover bounds
    in
        { transform = tileTransform
        , tiles = Dict.empty
        }
            ! (List.map getGeoJsonTile tilesToLoad)


view : Model -> Svg Msg
view model =
    LowLevel.container model.transform
        [ SimpleGeoJson.tileLayer (tileToGeoJson model) model.transform
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GeoJsonTileResponse key data ->
            { model | tiles = Dict.insert key data model.tiles } ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Html.program
        { init = init
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
