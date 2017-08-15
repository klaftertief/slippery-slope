module SlippyMap.Layer.Marker.Circle
    exposing
        ( Config
        , customMarker
        , icon
        , individualMarker
        , marker
        , withFill
        , withFillOpacity
        , withRadius
        , withStroke
        , withStrokeOpacity
        , withStrokeWidth
        )

{-| A layer to display circle markers.

@docs marker


## Custom circles

@docs customMarker, individualMarker, icon, withRadius, withFill, withFillOpacity, withStroke, withStrokeWidth, withStrokeOpacity, Config

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
        , fillOpacity : Float
        , stroke : String
        , strokeWidth : Float
        , strokeOpacity : Float
        }


defaultConfig : Config
defaultConfig =
    Config
        { radius = 8
        , fill = "#3388ff"
        , fillOpacity = 1
        , stroke = "#ffffff"
        , strokeWidth = 3
        , strokeOpacity = 1
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


{-| Sets the stroke opacity of a cirle.
-}
withFillOpacity : Float -> Config -> Config
withFillOpacity fillOpacity (Config config) =
    Config { config | fillOpacity = clamp 0 1 fillOpacity }


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


{-| Sets the stroke opacity of a cirle.
-}
withStrokeOpacity : Float -> Config -> Config
withStrokeOpacity strokeOpacity (Config config) =
    Config { config | strokeOpacity = clamp 0 1 strokeOpacity }


renderIcon : Config -> Svg msg
renderIcon (Config config) =
    Svg.circle
        [ Svg.Attributes.r
            (toString config.radius)
        , Svg.Attributes.fill
            config.fill
        , Svg.Attributes.fillOpacity
            (toString config.fillOpacity)
        , Svg.Attributes.stroke
            config.stroke
        , Svg.Attributes.strokeWidth
            (toString config.strokeWidth)
        , Svg.Attributes.strokeOpacity
            (toString config.strokeOpacity)
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
