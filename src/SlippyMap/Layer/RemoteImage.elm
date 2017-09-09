module SlippyMap.Layer.RemoteImage
    exposing
        ( Config
        , config
        , layer
        , toUrl
        , withTile
        )

{-| A layer to display remote image tiles.

@docs Config, layer, toUrl, withTile, config

-}

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


{-| -}
config : String -> List String -> Config
config urlTemplate subDomains =
    Config
        { toUrl = TileLayer.toUrl urlTemplate subDomains
        , fromTile = always RemoteData.NotAsked
        }


{-| -}
withTile : (Tile -> WebData Tile) -> Config -> Config
withTile fromTile (Config configInternal) =
    Config
        { configInternal | fromTile = fromTile }


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
        -- TODO: unify scale usage, do not calculate by rounding
        scale =
            Transform.scaleZ transform (toFloat (round <| Transform.zoom transform))
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
