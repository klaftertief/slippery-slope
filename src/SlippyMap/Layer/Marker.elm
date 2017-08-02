module SlippyMap.Layer.Marker
    exposing
        ( Config
        , config
        , layer
        , render
        )

{-| A layer to display markers.

@docs Config, config, layer, render

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
    = Config { icon : marker -> Svg msg }


{-| -}
config : (marker -> Svg msg) -> Config marker msg
config icon =
    Config
        { icon = icon
        }


{-| -}
layer : Config marker msg -> List ( Location, marker ) -> Layer msg
layer config locatedMarkers =
    Layer.withRender Layer.marker (render config locatedMarkers)


{-| -}
render : Config marker msg -> List ( Location, marker ) -> Transform -> Svg msg
render config locatedMarkers transform =
    let
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
        (List.map (icon config transform) locatedMarkersFiltered)


icon : Config marker msg -> Transform -> ( Location, marker ) -> Svg msg
icon (Config config) transform ( location, marker ) =
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
