module SlippyMap.Layer.Tile exposing (layer)

{-| Base tile layer.

@docs layer

-}

import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


{-| TODO: should the function params live in a/the config?
-}
layer : (Tile -> a) -> (Transform -> a -> Svg msg) -> Layer msg
layer fromTile renderTile =
    Layer.withRender Layer.marker (render fromTile renderTile)


render : (Tile -> a) -> (Transform -> a -> Svg msg) -> Transform -> Svg msg
render fromTile renderTile transform =
    let
        tiles =
            Transform.tileCover transform

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
