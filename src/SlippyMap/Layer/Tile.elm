module SlippyMap.Layer.Tile
    exposing
        ( Config
        , config
        , layer
        , withAttribution
        )

{-| Prototype for tile layers.

@docs Config, config, withAttribution, layer

-}

import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)
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
        { layerConfig = Layer.base
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
layer : (Tile -> a) -> (Transform -> a -> Svg msg) -> Config -> Layer msg
layer fromTile renderTile (Config configInternal) =
    Layer.withRender configInternal.layerConfig (render fromTile renderTile)


render : (Tile -> a) -> (Transform -> a -> Svg msg) -> Transform -> Svg msg
render fromTile renderTile transform =
    let
        scale =
            transform.crs.scale
                (transform.zoom - toFloat (round transform.zoom))

        centerPoint =
            Transform.locationToPoint transform
                transform.center

        tiles =
            -- renderState.tileCover
            []

        tilesRendered =
            List.map
                (tile (fromTile >> renderTile transform) transform)
                tiles
    in
    Svg.Keyed.node "g"
        []
        tilesRendered


tile : (Tile -> Svg msg) -> Transform -> Tile -> ( String, Svg msg )
tile render transform ({ z, x, y } as tile) =
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

        scale =
            transform.crs.scale transform.zoom

        origin =
            Transform.origin transform

        point =
            { x = toFloat x
            , y = toFloat y
            }
                |> Point.multiplyBy scale
                |> Point.subtract origin
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
