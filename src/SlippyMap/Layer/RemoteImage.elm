module SlippyMap.Layer.RemoteImage
    exposing
        ( Config
        , config
        , withTile
        , withAttribution
        , toUrl
        , layer
        )

{-| A layer to display remote image tiles.

@docs Config, layer, toUrl, withTile, withAttribution, config
-}

import Regex
import RemoteData exposing (WebData)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.

TODO: add type alias for internal config
-}
type Config
    = Config TileLayer.Config ConfigInternal


type alias ConfigInternal =
    { toUrl : Tile -> String
    , fromTile : Tile -> WebData Tile
    }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
config : String -> List String -> Config
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
                        |> (flip List.drop) subDomains
                        |> List.head
                        |> Maybe.withDefault ""
                    )
    in
        Config
            TileLayer.config
            { toUrl = toUrl
            , fromTile = always RemoteData.NotAsked
            }


{-| -}
withTile : (Tile -> WebData Tile) -> Config -> Config
withTile fromTile (Config tileLayerConfig configInternal) =
    Config
        tileLayerConfig
        { configInternal | fromTile = fromTile }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config tileLayerConfig configInternal) =
    Config
        (TileLayer.withAttribution attribution tileLayerConfig)
        configInternal


{-| -}
toUrl : Config -> Tile -> String
toUrl (Config _ { toUrl }) =
    toUrl



-- LAYER


{-| -}
layer : Config -> Layer msg
layer ((Config tileLayerConfig configInternal) as config) =
    TileLayer.layer configInternal.fromTile
        (tile config)
        tileLayerConfig


tile : Config -> Layer.RenderState -> WebData Tile -> Svg msg
tile (Config _ configInternal) renderState tileResponse =
    case tileResponse of
        RemoteData.NotAsked ->
            Svg.text_ [] [ Svg.text "Not Asked" ]

        RemoteData.Loading ->
            Svg.text_ [] [ Svg.text "Loading" ]

        RemoteData.Failure e ->
            Svg.text_ [] [ Svg.text ("Error: " ++ toString e) ]

        RemoteData.Success tile ->
            Svg.image
                [ Svg.Attributes.width (toString renderState.transform.tileSize)
                , Svg.Attributes.height (toString renderState.transform.tileSize)
                , Svg.Attributes.xlinkHref (configInternal.toUrl tile)
                , Svg.Attributes.transform
                    ("scale("
                        ++ toString renderState.tileScale
                        ++ ")"
                    )
                ]
                []



-- HELPERS


replace : String -> String -> String -> String
replace search substitution string =
    string
        |> Regex.replace Regex.All
            (Regex.regex (Regex.escape search))
            (\_ -> substitution)
