module SlippyMap.Layer.JsonTile
    exposing
        ( Config
        , config
        , layer
        , toUrl
        , withRender
        , withTile
        )

{-| A layer to display generic JSON tiles.

@docs Config, layer, toUrl, withTile, withRender, config

-}

import Json.Decode as Json
import RemoteData exposing (WebData)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


-- CONFIG


{-| Configuration for the layer.
-}
type Config msg
    = Config (ConfigInternal msg)


type alias ConfigInternal msg =
    { toUrl : Tile -> String
    , fromTile : Tile -> ( Tile, WebData Json.Value )
    , render : ( Tile, Json.Value ) -> Transform -> Svg msg
    }


{-| -}
config : String -> List String -> Config msg
config urlTemplate subDomains =
    Config
        { toUrl = TileLayer.toUrl urlTemplate subDomains
        , fromTile = \tile -> ( tile, RemoteData.NotAsked )
        , render = \_ _ -> Svg.text ""
        }


{-| -}
withTile : (Tile -> ( Tile, WebData Json.Value )) -> Config msg -> Config msg
withTile fromTile (Config configInternal) =
    Config
        { configInternal | fromTile = fromTile }


{-| -}
withRender : (( Tile, Json.Value ) -> Transform -> Svg msg) -> Config msg -> Config msg
withRender render (Config configInternal) =
    Config
        { configInternal | render = render }


{-| -}
toUrl : Config msg -> Tile -> String
toUrl (Config { toUrl }) =
    toUrl



-- LAYER


{-| -}
layer : Config msg -> Layer msg
layer ((Config configInternal) as config) =
    TileLayer.config configInternal.fromTile
        (tile config)
        |> TileLayer.layer


tile : Config msg -> Transform -> ( Tile, WebData Json.Value ) -> Svg msg
tile (Config configInternal) transform ( tile, tileResponse ) =
    case tileResponse of
        RemoteData.NotAsked ->
            Svg.text_ [] [ Svg.text "Not Asked" ]

        RemoteData.Loading ->
            Svg.text_ [] [ Svg.text "Loading" ]

        RemoteData.Failure e ->
            Svg.text_ [] [ Svg.text ("Error: " ++ toString e) ]

        RemoteData.Success value ->
            configInternal.render ( tile, value ) transform
