module SlippyMap.Layer.JsonTile exposing (Config, config, layer, toUrl, withAttribution, withRender, withTile)

{-| A layer to display generic JSON tiles.

@docs Config, layer, toUrl, withTile, withRender, withAttribution, config

-}

import Json.Decode as Json
import Regex
import RemoteData exposing (WebData)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import Svg exposing (Svg)


-- CONFIG


{-| Configuration for the layer.
-}
type Config msg
    = Config TileLayer.Config (ConfigInternal msg)


type alias ConfigInternal msg =
    { toUrl : Tile -> String
    , fromTile : Tile -> ( Tile, WebData Json.Value )
    , render : ( Tile, Json.Value ) -> Layer.RenderState -> Svg msg
    }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
config : String -> List String -> Config msg
config template subDomains =
    let
        toUrl : Tile -> String
        toUrl { z, x, y } =
            template
                |> replace "{z}" (toString z)
                |> replace "{x}" (toString (x % (2 ^ z)))
                |> replace "{y}" (toString (y % (2 ^ z)))
                |> replace "{s}"
                    ((abs (x + y) % (max 1 <| List.length subDomains))
                        |> flip List.drop subDomains
                        |> List.head
                        |> Maybe.withDefault ""
                    )
    in
    Config
        TileLayer.config
        { toUrl = toUrl
        , fromTile = \tile -> ( tile, RemoteData.NotAsked )
        , render = \_ _ -> Svg.text ""
        }


{-| -}
withTile : (Tile -> ( Tile, WebData Json.Value )) -> Config msg -> Config msg
withTile fromTile (Config tileLayerConfig configInternal) =
    Config
        tileLayerConfig
        { configInternal | fromTile = fromTile }


{-| -}
withRender : (( Tile, Json.Value ) -> Layer.RenderState -> Svg msg) -> Config msg -> Config msg
withRender render (Config tileLayerConfig configInternal) =
    Config
        tileLayerConfig
        { configInternal | render = render }


{-| -}
withAttribution : String -> Config msg -> Config msg
withAttribution attribution (Config tileLayerConfig configInternal) =
    Config
        (TileLayer.withAttribution attribution tileLayerConfig)
        configInternal


{-| -}
toUrl : Config msg -> Tile -> String
toUrl (Config _ { toUrl }) =
    toUrl



-- LAYER


{-| -}
layer : Config msg -> Layer msg
layer ((Config tileLayerConfig configInternal) as config) =
    TileLayer.layer configInternal.fromTile
        (tile config)
        tileLayerConfig


tile : Config msg -> Layer.RenderState -> ( Tile, WebData Json.Value ) -> Svg msg
tile (Config _ configInternal) renderState ( tile, tileResponse ) =
    case tileResponse of
        RemoteData.NotAsked ->
            Svg.text_ [] [ Svg.text "Not Asked" ]

        RemoteData.Loading ->
            Svg.text_ [] [ Svg.text "Loading" ]

        RemoteData.Failure e ->
            Svg.text_ [] [ Svg.text ("Error: " ++ toString e) ]

        RemoteData.Success value ->
            configInternal.render ( tile, value ) renderState



-- HELPERS


replace : String -> String -> String -> String
replace search substitution string =
    string
        |> Regex.replace Regex.All
            (Regex.regex (Regex.escape search))
            (\_ -> substitution)
