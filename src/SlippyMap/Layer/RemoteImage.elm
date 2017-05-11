module SlippyMap.Layer.RemoteImage
    exposing
        ( Config
        , withUrl
        , withTile
        , toUrl
        , layer
        )

{-| A layer to display remote image tiles.

@docs Config, layer, toUrl, withTile, withUrl
-}

import Regex
import RemoteData exposing (WebData)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config
    = Config
        { toUrl : Tile -> String
        , fromTile : Tile -> WebData Tile
        }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
withUrl : String -> List String -> Config
withUrl template subDomains =
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
            { toUrl = toUrl
            , fromTile = always RemoteData.NotAsked
            }


{-| -}
withTile : (Tile -> WebData Tile) -> Config -> Config
withTile fromTile (Config config) =
    Config
        { config | fromTile = fromTile }


{-| -}
toUrl : Config -> Tile -> String
toUrl (Config { toUrl }) =
    toUrl



-- LAYER


{-| -}
layer : Config -> Layer.Config -> Layer msg
layer ((Config { fromTile }) as config) layerConfig =
    TileLayer.layer fromTile (tile config) layerConfig


tile : Config -> Transform -> WebData Tile -> Svg msg
tile (Config config) transform tileResponse =
    case tileResponse of
        RemoteData.NotAsked ->
            Svg.text_ [] [ Svg.text "Not Asked" ]

        RemoteData.Loading ->
            Svg.text_ [] [ Svg.text "Loading" ]

        RemoteData.Failure e ->
            Svg.text_ [] [ Svg.text ("Error: " ++ toString e) ]

        RemoteData.Success tile ->
            Svg.image
                [ Svg.Attributes.width (toString transform.tileSize)
                , Svg.Attributes.height (toString transform.tileSize)
                , Svg.Attributes.xlinkHref (config.toUrl tile)
                ]
                []



-- HELPERS


replace : String -> String -> String -> String
replace search substitution string =
    string
        |> Regex.replace Regex.All
            (Regex.regex (Regex.escape search))
            (\_ -> substitution)
