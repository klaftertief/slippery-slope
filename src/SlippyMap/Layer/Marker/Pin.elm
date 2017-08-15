module SlippyMap.Layer.Marker.Pin
    exposing
        ( config
        , layer
        )

{-| A layer to display circle markers.

@docs config, layer

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Marker as Marker exposing (Config)
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
config : Config Location msg
config =
    Marker.config identity (always icon)


icon : Svg msg
icon =
    Svg.path
        [ Svg.Attributes.fill "#3388ff"
        , Svg.Attributes.stroke "white"
        , Svg.Attributes.strokeWidth "3"
        , Svg.Attributes.d "M-16,-31.2c0,12.6 16,31.2 16,31.2c0,0 16,-18.6 16,-31.2c0,-9.288 -7.154,-16.8 -16,-16.8c-8.846,0 -16,7.512 -16,16.8Z"
        ]
        []


{-| -}
layer : List Location -> Layer msg
layer locations =
    Layer.withRender Layer.marker <|
        Marker.render config locations
