module SlippyMap.Layer.StaticImage
    exposing
        ( Config
        , config
        , layer
        , withAttribution
        )

{-| A layer to display static image tiles.

@docs Config, config, withAttribution, layer

-}

import Regex
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config
    = Config
        { toUrl : Tile -> String
        }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
config : String -> List String -> Config
config urlTemplate subDomains =
    let
        toUrl : Tile -> String
        toUrl { z, x, y } =
            urlTemplate
                |> replace "{z}" (toString (max 0 z))
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
        { toUrl = toUrl }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config config) =
    Config
        config



-- LAYER


{-| -}
layer : Config -> Layer msg
layer config =
    TileLayer.layer identity
        (tile config)


tile : Config -> Transform -> Tile -> Svg msg
tile (Config config) transform ({ z, x, y } as tile) =
    let
        scale =
            transform.crs.scale transform.zoom / transform.crs.scale (toFloat z)
    in
    Svg.image
        [ Svg.Attributes.width
            -- (toString renderState.transform.tileSize)
            "256"
        , Svg.Attributes.height
            -- (toString renderState.transform.tileSize)
            "256"
        , Svg.Attributes.xlinkHref (config.toUrl tile)
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
