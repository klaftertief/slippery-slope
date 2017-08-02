module SlippyMap.Layer.Marker.Circle
    exposing
        ( config
        , layer
        )

{-| A layer to display circle markers.

@docs config, layer

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Marker as Marker exposing (Config)
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
config : Config marker msg
config =
    Marker.config (always marker)


marker : Svg msg
marker =
    Svg.circle
        [ Svg.Attributes.r "8"
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
