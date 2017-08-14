module SlippyMap.Layer.Marker.Square
    exposing
        ( config
        , layer
        )

{-| A layer to display square markers.

@docs config, layer

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Marker as Marker exposing (Config)
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
config : Config marker msg
config =
    Marker.config (always icon)


icon : Svg msg
icon =
    Svg.rect
        [ Svg.Attributes.x "-8"
        , Svg.Attributes.y "-8"
        , Svg.Attributes.width "16"
        , Svg.Attributes.height "16"
        , Svg.Attributes.fill "#3388ff"
        , Svg.Attributes.stroke "white"
        , Svg.Attributes.strokeWidth "3"
        ]
        []


{-| -}
layer : List Location -> Layer msg
layer locations =
    let
        locatedMarkers =
            List.map (\location -> ( location, () )) locations
    in
    Layer.withRender Layer.marker (Marker.render config locatedMarkers)
