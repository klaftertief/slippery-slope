module Layer.Debug exposing (layer)

{-| A debug layer.

Used to test layer "plugins".

@docs layer
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Tile as TileLayer
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import Svg exposing (Svg)
import Svg.Attributes


-- LAYER


{-| -}
layer : Layer msg
layer =
    TileLayer.layer identity tile TileLayer.config


{-| TODO: think about how to make it not always depend on Transform.
-}
tile : Layer.RenderState -> Tile -> Svg msg
tile renderState ({ z, x, y } as tile) =
    let
        size =
            toFloat renderState.transform.tileSize * renderState.tileScale
    in
        Svg.g
            []
            [ Svg.rect
                [ Svg.Attributes.fill "none"
                , Svg.Attributes.strokeWidth "1"
                , Svg.Attributes.stroke "#ff0000"
                , Svg.Attributes.x "0"
                , Svg.Attributes.y "0"
                , Svg.Attributes.width (toString size)
                , Svg.Attributes.height (toString size)
                ]
                []
            , Svg.text_
                [ Svg.Attributes.textAnchor "middle"
                , Svg.Attributes.x (toString <| size / 2)
                , Svg.Attributes.y (toString <| size / 2)
                ]
                [ Svg.text (toString tile) ]
            ]
