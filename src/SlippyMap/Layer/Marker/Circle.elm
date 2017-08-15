module SlippyMap.Layer.Marker.Circle
    exposing
        ( Config
        , customMarker
        , icon
        , individualMarker
        , marker
        , withFill
        , withRadius
        , withStroke
        , withStrokeWidth
        )

{-| A layer to display circle markers.

@docs marker


## Custom circles

@docs customMarker, individualMarker, icon, withRadius, withFill, withStroke, withStrokeWidth, Config

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
icon : Config
icon =
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


renderIcon : Config -> Svg msg
renderIcon (Config { radius, fill, stroke, strokeWidth }) =
    Svg.circle
        [ Svg.Attributes.r (toString radius)
        , Svg.Attributes.fill fill
        , Svg.Attributes.stroke stroke
        , Svg.Attributes.strokeWidth (toString strokeWidth)
        ]
        []


markerConfig : (marker -> Location) -> (marker -> Config) -> Marker.Config marker msg
markerConfig toLocation toConfig =
    Marker.config toLocation (toConfig >> renderIcon)


{-| Renders a list of locations with default circle markers.
-}
marker : List Location -> Layer msg
marker =
    customMarker defaultConfig


{-| Renders a list of locations with with customised circle markers.
-}
customMarker : Config -> List Location -> Layer msg
customMarker config locations =
    Marker.layer
        (markerConfig identity (always config))
        locations


{-| Renders a list of markers with indivual circles.
-}
individualMarker : (marker -> Location) -> (marker -> Config) -> List marker -> Layer msg
individualMarker toLocation toConfig markers =
    Marker.layer
        (markerConfig toLocation toConfig)
        markers
