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


{-| -}
config : String -> List String -> Config
config urlTemplate subDomains =
    Config
        { toUrl = TileLayer.toUrl urlTemplate subDomains }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config config) =
    Config
        config



-- LAYER


{-| -}
layer : Config -> Layer msg
layer config =
    TileLayer.config identity (tile config)
        |> TileLayer.layer


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
