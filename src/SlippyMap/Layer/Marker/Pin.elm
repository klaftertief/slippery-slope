module SlippyMap.Layer.Marker.Pin
    exposing
        ( Config
        , customMarker
        , icon
        , individualMarker
        , marker
        , onClick
        )

{-| A layer to display circle markers.

@docs Config, customMarker, icon, individualMarker, marker, onClick

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Layer.Marker as Marker exposing (Config)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events


{-| -}
type Config msg
    = Config
        { fill : String
        , fillOpacity : Float
        , stroke : String
        , strokeWidth : Float
        , strokeOpacity : Float
        , onClick : Maybe msg
        }


defaultConfig : Config msg
defaultConfig =
    Config
        { fill = "#3388ff"
        , fillOpacity = 1
        , stroke = "#ffffff"
        , strokeWidth = 3
        , strokeOpacity = 1
        , onClick = Nothing
        }


{-| Creates a default pin.
-}
icon : Config msg
icon =
    defaultConfig


{-| -}
onClick : msg -> Config msg -> Config msg
onClick msg (Config config) =
    Config { config | onClick = Just msg }


renderIcon : Config msg -> Svg msg
renderIcon (Config config) =
    let
        clickAttributes =
            case config.onClick of
                Just msg ->
                    [ Svg.Events.onClick msg
                    , Svg.Attributes.pointerEvents "auto"
                    ]

                Nothing ->
                    []
    in
    Svg.path
        ([ Svg.Attributes.fill
            config.fill
         , Svg.Attributes.fillOpacity
            (toString config.fillOpacity)
         , Svg.Attributes.stroke
            config.stroke
         , Svg.Attributes.strokeWidth
            (toString config.strokeWidth)
         , Svg.Attributes.strokeOpacity
            (toString config.strokeOpacity)
         , Svg.Attributes.d "M-16,-31.2c0,12.6 16,31.2 16,31.2c0,0 16,-18.6 16,-31.2c0,-9.288 -7.154,-16.8 -16,-16.8c-8.846,0 -16,7.512 -16,16.8Z"
         ]
            ++ clickAttributes
        )
        []


markerConfig : (marker -> Location) -> (marker -> Config msg) -> Marker.Config marker msg
markerConfig toLocation toConfig =
    Marker.config toLocation (toConfig >> renderIcon) []


{-| Renders a list of locations with default circle markers.
-}
marker : List Location -> Layer msg
marker =
    customMarker defaultConfig


{-| Renders a list of locations with with customised circle markers.
-}
customMarker : Config msg -> List Location -> Layer msg
customMarker config locations =
    Marker.layer
        (markerConfig identity (always config))
        locations


{-| Renders a list of markers with indivual circles.
-}
individualMarker : (marker -> Location) -> (marker -> Config msg) -> List marker -> Layer msg
individualMarker toLocation toConfig markers =
    Marker.layer
        (markerConfig toLocation toConfig)
        markers
