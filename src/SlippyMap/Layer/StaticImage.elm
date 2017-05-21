module SlippyMap.Layer.StaticImage
    exposing
        ( Config
        , config
        , withAttribution
        , layer
        )

{-| A layer to display static image tiles.

@docs Config, config, withAttribution, layer
-}

import Regex
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config
    = Config TileLayer.Config ConfigInternal


type alias ConfigInternal =
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
                        |> (flip List.drop) subDomains
                        |> List.head
                        |> Maybe.withDefault ""
                    )
    in
        Config
            TileLayer.config
            { toUrl = toUrl }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config tileLayerConfig configInternal) =
    Config
        (TileLayer.withAttribution attribution tileLayerConfig)
        configInternal



-- LAYER


{-|
-}
layer : Config -> Layer msg
layer ((Config tileLayerConfig _) as config) =
    TileLayer.layer identity
        (tile config)
        tileLayerConfig


tile : Config -> Layer.RenderState -> Tile -> Svg msg
tile (Config _ configInternal) renderState ({ z, x, y } as tile) =
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
