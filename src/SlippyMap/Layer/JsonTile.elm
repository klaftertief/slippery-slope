module SlippyMap.Layer.JsonTile exposing (Config, config, layer, toUrl, withAttribution, withRender, withTile)

{-| A layer to display generic JSON tiles.

@docs Config, layer, toUrl, withTile, withRender, withAttribution, config

-}

import Json.Decode as Json
import Regex
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
        { toUrl = toUrl
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
withAttribution : String -> Config msg -> Config msg
withAttribution attribution (Config configInternal) =
    Config
        configInternal


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



-- HELPERS


replace : String -> String -> String -> String
replace search substitution string =
    string
        |> Regex.replace Regex.All
            (Regex.regex (Regex.escape search))
            (\_ -> substitution)
