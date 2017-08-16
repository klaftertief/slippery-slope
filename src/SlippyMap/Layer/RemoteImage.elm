module SlippyMap.Layer.RemoteImage
    exposing
        ( Config
        , config
        , layer
        , toUrl
        , withAttribution
        , withTile
        )

{-| A layer to display remote image tiles.

@docs Config, layer, toUrl, withTile, withAttribution, config

-}

import Regex
import RemoteData exposing (WebData)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.

TODO: add type alias for internal config

-}
type Config
    = Config
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
                        |> flip List.drop subDomains
                        |> List.head
                        |> Maybe.withDefault ""
                    )
    in
    Config
        { toUrl = toUrl
        , fromTile = always RemoteData.NotAsked
        }


{-| -}
withTile : (Tile -> WebData Tile) -> Config -> Config
withTile fromTile (Config configInternal) =
    Config
        { configInternal | fromTile = fromTile }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config configInternal) =
    Config
        configInternal


{-| -}
toUrl : Config -> Tile -> String
toUrl (Config { toUrl }) =
    toUrl



-- LAYER


{-| -}
layer : Config -> Layer msg
layer ((Config configInternal) as config) =
    TileLayer.config configInternal.fromTile
        (tile config)
        |> TileLayer.layer


tile : Config -> Transform -> WebData Tile -> Svg msg
tile (Config configInternal) transform tileResponse =
    let
        scale =
            transform.crs.scale
                (transform.zoom - toFloat (round transform.zoom))
    in
    case tileResponse of
        RemoteData.NotAsked ->
            Svg.text_ [] [ Svg.text "Not Asked" ]

        RemoteData.Loading ->
            Svg.text_ [] [ Svg.text "Loading" ]

        RemoteData.Failure e ->
            Svg.text_ [] [ Svg.text ("Error: " ++ toString e) ]

        RemoteData.Success tile ->
            Svg.image
                [ Svg.Attributes.width
                    -- (toString renderState.transform.tileSize)
                    "256"
                , Svg.Attributes.height
                    -- (toString renderState.transform.tileSize)
                    "256"
                , Svg.Attributes.xlinkHref (configInternal.toUrl tile)
                , Svg.Attributes.transform
                    ("scale("
                        ++ toString scale
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
