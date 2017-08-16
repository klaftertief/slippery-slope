module SlippyMap.Layer.Tile
    exposing
        ( Config
        , config
        , layer
        )

{-| Base tile layer.

@docs Config, config, layer

-}

import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


{-| Configuration for the layer.
-}
type Config data msg
    = Config
        { toData : Tile -> data
        , renderData : Transform -> data -> Svg msg
        , attribution : Maybe String
        }


{-| -}
config : (Tile -> data) -> (Transform -> data -> Svg msg) -> Config data msg
config toData renderData =
    Config
        { toData = toData
        , renderData = renderData
        , attribution = Nothing
        }


{-| Adds an attribution to the config.
-}
withAttribution : String -> Config data msg -> Config data msg
withAttribution attribution (Config config) =
    Config
        { config
            | attribution = Just attribution
        }


{-| -}
layer : Config data msg -> Layer msg
layer ((Config { attribution }) as config) =
    let
        layerConfig =
            case attribution of
                Just a ->
                    Layer.withAttribution a Layer.base

                Nothing ->
                    Layer.base
    in
    Layer.withRender layerConfig
        (render config)


render : Config data msg -> Transform -> Svg msg
render (Config { toData, renderData }) transform =
    let
        tiles =
            Transform.tileCover transform

        tilesRendered =
            List.map
                (tile (toData >> renderData transform) transform)
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

        scale =
            transform.crs.scale
                (transform.zoom - toFloat z)

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
