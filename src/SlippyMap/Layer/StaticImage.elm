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
    = Config ConfigInternal


type alias ConfigInternal =
    { toUrl : Tile -> String
    , attribution : Maybe String
    }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
config : String -> List String -> TileLayer.Config Config
config urlTemplate subDomains =
    let
        toUrl : Tile -> String
        toUrl { z, x, y } =
            urlTemplate
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
        TileLayer.config
            (Config
                { toUrl = toUrl
                , attribution = Nothing
                }
            )


{-| -}
withAttribution : String -> TileLayer.Config Config -> TileLayer.Config Config
withAttribution =
    TileLayer.withAttribution



-- LAYER


{-|
-}
layer : TileLayer.Config Config -> Layer msg
layer tileLayerConfig =
    TileLayer.layer identity
        (tile <| TileLayer.getLayerConfig tileLayerConfig)
        tileLayerConfig


tile : Config -> Layer.RenderState -> Tile -> Svg msg
tile (Config config) { transform } ({ z, x, y } as tile) =
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
