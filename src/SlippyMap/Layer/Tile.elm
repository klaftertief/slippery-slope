module SlippyMap.Layer.Tile
    exposing
        ( config
        , layer
        )

{-| Prototype for tile layers.

@docs config, layer
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
layer : (Tile -> a) -> (Transform -> a -> Svg msg) -> Config config -> Layer msg
layer fromTile renderTile (Config configInternal) =
    Layer.withRender configInternal.layerConfig (render fromTile renderTile)


render : (Tile -> a) -> (Transform -> a -> Svg msg) -> Transform -> Svg msg
render fromTile renderTile transform =
    let
        tileTransform =
            Transform.tileTransform transform

        scale =
            Transform.tileScale transform

        centerPoint =
            Transform.centerPoint tileTransform

        tiles =
            Transform.tileBounds transform
                |> Tile.cover
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
                (tile (fromTile >> renderTile tileTransform) tileTransform)
                tiles
            )


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

        point =
            Transform.coordinateToPoint transform tileCoordinate
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
