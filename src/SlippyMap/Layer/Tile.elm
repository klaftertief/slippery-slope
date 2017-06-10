module SlippyMap.Layer.Tile
    exposing
        ( Config
        , config
        , withAttribution
        , layer
        )

{-| Prototype for tile layers.

@docs Config, config, withAttribution, layer
-}

import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


{-| -}
type Config
    = Config ConfigInternal


type alias ConfigInternal =
    { layerConfig : Layer.Config
    }


{-| -}
config : Config
config =
    Config
        { layerConfig = Layer.tile
        }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config configInternal) =
    Config
        { configInternal
            | layerConfig =
                Layer.withAttribution
                    attribution
                    configInternal.layerConfig
        }


{-| TODO: should the function params live in a/the config?
-}
layer : (Tile -> a) -> (Layer.RenderState -> a -> Svg msg) -> Config -> Layer msg
layer fromTile renderTile (Config configInternal) =
    Layer.withRender configInternal.layerConfig (render fromTile renderTile)


render : (Tile -> a) -> (Layer.RenderState -> a -> Svg msg) -> Layer.RenderState -> Svg msg
render fromTile renderTile renderState =
    let
        scale =
            renderState.tileScale

        centerPoint =
            renderState.halfSize

        tiles =
            renderState.tileCover

        transform =
            renderState.transform

        renderState1 =
            Layer.transformToRenderState { transform | zoom = transform.zoom - 1, tileSize = transform.tileSize * 2 }

        tilesZoomActual =
            List.map
                (tile (fromTile >> renderTile renderState) renderState)
                tiles

        tilesZoomMinusOne =
            List.map
                (tile (fromTile >> renderTile renderState1) renderState1)
                renderState1.tileCover
    in
        Svg.Keyed.node "g"
            []
            --(tilesZoomMinusOne ++ tilesZoomActual)
            tilesZoomActual


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
            renderState.coordinateToContainerPoint tileCoordinate
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
