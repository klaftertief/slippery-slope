module Layer.Debug exposing (layer)

{-| A debug layer.

Used to test layer "plugins".

@docs layer
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


-- LAYER


{-| -}
layer : Layer msg
layer =
    TileLayer.layer identity tile Layer.withoutAttribution


{-| TODO: think about how to make it not always depend on Transform.
-}
tile : Transform -> Tile -> Svg msg
tile _ ({ z, x, y } as tile) =
    Svg.text_ []
        [ Svg.text (toString tile) ]
