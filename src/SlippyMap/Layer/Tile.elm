module SlippyMap.Layer.Tile
    exposing
        ( Config
        , config
        , getLayerConfig
        , withAttribution
        , layer
        )

{-| Prototype for tile layers.

@docs Config, config, getLayerConfig, withAttribution, layer
-}

import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


{-| -}
type Config config
    = Config (ConfigInternal config)


type alias ConfigInternal config =
    -- TODO: hm, maybe swap field names
    { layerConfig : Layer.Config
    , config : config
    }


{-| -}
config : config -> Config config
config config =
    Config
        { layerConfig = Layer.tile
        , config = config
        }


{-| -}
getLayerConfig : Config config -> config
getLayerConfig (Config { config }) =
    config


{-| -}
withAttribution : String -> Config config -> Config config
withAttribution attribution (Config configInternal) =
    Config
        { configInternal
            | layerConfig =
                Layer.withAttribution attribution configInternal.layerConfig
        }


{-| TODO: should the function params live in a/the config?
-}
layer : (Tile -> a) -> (Layer.RenderState -> a -> Svg msg) -> Config config -> Layer msg
layer fromTile renderTile (Config configInternal) =
    Layer.withRender configInternal.layerConfig (render fromTile renderTile)


render : (Tile -> a) -> (Layer.RenderState -> a -> Svg msg) -> Layer.RenderState -> Svg msg
render fromTile renderTile renderState =
    let
        tileTransform =
            renderState.tileTransform

        scale =
            renderState.tileScale

        centerPoint =
            renderState.tileTransformCenterPoint

        tiles =
            renderState.tileCover
    in
        Svg.Keyed.node "g"
            [ Svg.Attributes.transform
                (""
                    ++ "translate("
                    ++ toString (round centerPoint.x)
                    ++ " "
                    ++ toString (round centerPoint.y)
                    ++ ")"
                    ++ " "
                    ++ "scale("
                    ++ toString scale
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString (round -centerPoint.x)
                    ++ " "
                    ++ toString (round -centerPoint.y)
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString (round ((tileTransform.width / 2 - centerPoint.x) / scale))
                    ++ " "
                    ++ toString (round ((tileTransform.height / 2 - centerPoint.y) / scale))
                    ++ ")"
                )
            ]
            (List.map
                (tile (fromTile >> renderTile renderState) renderState)
                tiles
            )


tile : (Tile -> Svg msg) -> Layer.RenderState -> Tile -> ( String, Svg msg )
tile render renderState ({ z, x, y } as tile) =
    let
        key =
            toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        point =
            Transform.coordinateToPoint renderState.tileTransform tileCoordinate
    in
        ( key
        , Svg.g
            [ Svg.Attributes.class "tile"
            , Svg.Attributes.transform
                ("translate("
                    ++ toString point.x
                    ++ " "
                    ++ toString point.y
                    ++ ")"
                )
            ]
            [ render tile ]
        )
