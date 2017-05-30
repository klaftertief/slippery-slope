module RemoteImageLayer exposing (..)

import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes
import Http
import RemoteData exposing (WebData)
import SlippyMap.Interactive as Map
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer.RemoteImage as RemoteImage


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
                (Map.center { lon = 7, lat = 51 } 8)
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
                    { model | mapState = Map.update mapConfig mapMsg model.mapState }

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
            Map.renderState model.mapState
                |> .tileCover

        tilesToLoad =
            Dict.diff
                (List.map
                    (\tile ->
                        ( Tile.toComparable tile
                        , RemoteData.NotAsked
                        )
                    )
                    tiles
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
    Map.config MapMsg


layerConfig : TileCache -> RemoteImage.Config
layerConfig tileCache =
    RemoteImage.config
        "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        [ "a", "b", "c" ]
        |> RemoteImage.withTile
            (\tile ->
                Dict.get (Tile.toComparable tile) tileCache
                    |> Maybe.withDefault RemoteData.NotAsked
            )


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "padding", "50px" ) ] ]
        [ Map.view mapConfig
            model.mapState
            [ RemoteImage.layer (layerConfig model.tiles)
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
