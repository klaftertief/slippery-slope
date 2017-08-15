module SlippyMap.Layer.Marker.Circle
    exposing
        ( Config
        , circle
        , customMarker
        , marker
        , withFill
        , withRadius
        , withStroke
        , withStrokeWidth
        )

{-| A layer to display circle markers.

@docs marker, customMarker, Config, circle, withRadius, withFill, withStroke, withStrokeWidth

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Marker as Marker
import Svg exposing (Svg)
import Svg.Attributes


{-| Describes visual properties of a circle marker.
-}
type Config
    = Config
        { radius : Float
        , fill : String
        , stroke : String
        , strokeWidth : Float
        }


defaultConfig : Config
defaultConfig =
    Config
        { radius = 8
        , fill = "#3388ff"
        , stroke = "#ffffff"
        , strokeWidth = 3
        }


{-| Creates a default circle.
-}
circle : Config
circle =
    defaultConfig


{-| Sets the radius of a cirle.
-}
withRadius : Float -> Config -> Config
withRadius radius (Config config) =
    Config { config | radius = radius }


{-| Sets the fill color of a cirle.
-}
withFill : String -> Config -> Config
withFill fill (Config config) =
    Config { config | fill = fill }


{-| Sets the stroke color of a cirle.
-}
withStroke : String -> Config -> Config
withStroke stroke (Config config) =
    Config { config | stroke = stroke }


{-| Sets the stroke width of a cirle.
-}
withStrokeWidth : Float -> Config -> Config
withStrokeWidth strokeWidth (Config config) =
    Config { config | strokeWidth = strokeWidth }


icon : Config -> Svg msg
icon (Config { radius, fill, stroke, strokeWidth }) =
    Svg.circle
        [ Svg.Attributes.r (toString radius)
        , Svg.Attributes.fill fill
        , Svg.Attributes.stroke stroke
        , Svg.Attributes.strokeWidth (toString strokeWidth)
        ]
        []


markerConfig : Svg msg -> Marker.Config () msg
markerConfig icon =
    Marker.config (always icon)


{-| Renders a list of locations as default circle markers.
-}
marker : List Location -> Layer msg
marker =
    customMarker defaultConfig


{-| Renders a list of locations as default circle markers.
-}
customMarker : Config -> List Location -> Layer msg
customMarker config locations =
    let
        locatedMarkers =
            List.map (\location -> ( location, () )) locations
    in
    Layer.withRender Layer.marker
        (Marker.render (markerConfig (icon config)) locatedMarkers)
