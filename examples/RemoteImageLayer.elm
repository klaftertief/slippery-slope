module RemoteImageLayer exposing (..)

import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Http
import RemoteData exposing (WebData)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.RemoteImage as RemoteImage
import SlippyMap.Layer.LowLevel as Layer
import SlippyMap.Map.LowLevel as Map
import SlippyMap.Map.Static as StaticMap


type alias Model =
    { mapState : Map.State
    , tiles : TileCache
    }


type alias TileCache =
    Dict Tile.Comparable (WebData Tile)


type Msg
    = MapMsg Map.Msg
    | TileResponse Tile.Comparable (WebData Tile)


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            Model
                (StaticMap.center { lon = 7, lat = 51 } 8)
                Dict.empty

        tilesToLoad =
            newTilesToLoad initialModel
    in
        initialModel
            ! (List.map (getTile <| layerConfig initialModel.tiles) tilesToLoad)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            let
                newModel =
                    { model | mapState = Map.update mapMsg model.mapState }

                tilesToLoad =
                    newTilesToLoad newModel
            in
                newModel
                    ! (List.map (getTile <| layerConfig model.tiles) tilesToLoad)

        TileResponse key data ->
            { model
                | tiles =
                    Dict.insert key data model.tiles
            }
                ! []


newTilesToLoad : Model -> List Tile
newTilesToLoad model =
    let
        tiles =
            Transform.tileBounds (Map.getTransform model.mapState)
                |> Tile.cover

        tilesToLoad =
            Dict.diff
                (List.map (\tile -> ( Tile.toComparable tile, RemoteData.NotAsked )) tiles
                    |> Dict.fromList
                )
                model.tiles
                |> Dict.keys
                |> List.map Tile.fromComparable
    in
        tilesToLoad


getTile : RemoteImage.Config -> Tile -> Cmd Msg
getTile config ({ z, x, y } as tile) =
    let
        comparable =
            Tile.toComparable tile

        url =
            RemoteImage.toUrl config tile
    in
        Http.request
            { method = "GET"
            , headers = []
            , url = url
            , body = Http.emptyBody
            , expect = Http.expectStringResponse (\_ -> Ok tile)
            , timeout = Nothing
            , withCredentials = False
            }
            |> RemoteData.sendRequest
            |> Cmd.map (TileResponse comparable)


mapConfig : Map.Config Msg
mapConfig =
    Map.dynamicConfig MapMsg


layerConfig : TileCache -> RemoteImage.Config
layerConfig tileCache =
    RemoteImage.withUrl "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        [ "a", "b", "c" ]
        |> RemoteImage.withTile
            (\tile ->
                Dict.get (Tile.toComparable tile) tileCache
                    |> Maybe.withDefault RemoteData.NotAsked
            )


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "padding", "50px" ) ] ]
        [ StaticMap.view mapConfig
            model.mapState
            [ RemoteImage.layer (layerConfig model.tiles)
                (Layer.withAttribution "© OpenStreetMap contributors")
            ]
        , Html.div []
            [ Html.text (toString model.mapState) ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Map.subscriptions mapConfig model.mapState


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
