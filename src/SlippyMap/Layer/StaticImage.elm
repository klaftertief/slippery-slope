module SlippyMap.Layer.StaticImage
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to display static image tiles.

@docs Config, config, layer

-}

import SlippyMap.Geo.Tile exposing (Tile)
import SlippyMap.Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Map as Map exposing (Map)
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



-- LAYER


{-| -}
layer : Config -> Layer msg
layer config =
    TileLayer.config identity (tile config)
        |> TileLayer.layer


tile : Config -> Map msg -> Tile -> Svg msg
tile (Config config) map ({ z } as tile) =
    let
        scale =
            Map.scaleZ map (toFloat z)
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
