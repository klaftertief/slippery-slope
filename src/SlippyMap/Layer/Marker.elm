module SlippyMap.Layer.Marker
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to display markers.

@docs Config, config, layer

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config marker msg
    = Config
        { location : marker -> Location
        , icon : marker -> Svg msg
        }


{-| -}
config : (marker -> Location) -> (marker -> Svg msg) -> Config marker msg
config toLocation toIcon =
    Config
        { location = toLocation
        , icon = toIcon
        }


{-| -}
layer : Config marker msg -> List marker -> Layer msg
layer config markers =
    Layer.withRender Layer.marker (render config markers)


{-| -}
render : Config marker msg -> List marker -> Transform -> Svg msg
render ((Config { location }) as config) markers transform =
    let
        locatedMarkers =
            List.map
                (\marker -> ( location marker, marker ))
                markers

        -- centerPoint =
        --     renderState.centerPoint
        -- bounds =
        --     renderState.locationBounds
        locatedMarkersFiltered =
            -- List.filter
            --     (\( location, _ ) ->
            --         Location.isInsideBounds bounds location
            --     )
            locatedMarkers
    in
    Svg.g []
        (List.map (marker config transform) locatedMarkersFiltered)


marker : Config marker msg -> Transform -> ( Location, marker ) -> Svg msg
marker (Config config) transform ( location, marker ) =
    let
        markerPoint =
            Transform.locationToScreenPoint transform location
    in
    Svg.g
        [ Svg.Attributes.transform
            ("translate("
                ++ toString markerPoint.x
                ++ " "
                ++ toString markerPoint.y
                ++ ")"
            )
        ]
        [ config.icon marker ]
