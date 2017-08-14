module SlippyMap.Layer.Marker.Ngon
    exposing
        ( config
        , layer
        )

{-| A layer to display n-gon markers.

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
    ngon 3 0.25 12


ngon : Int -> Float -> Float -> Svg msg
ngon n o r =
    let
        m =
            toFloat n

        t =
            2 * pi / m

        offset =
            2 * pi * o

        f i =
            toString (r * cos (t * toFloat i + offset))
                ++ ","
                ++ toString (r * sin (t * toFloat i + offset))
    in
    Svg.polygon
        [ Svg.Attributes.points
            (String.join " " <| List.map f (List.range 1 n))
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
