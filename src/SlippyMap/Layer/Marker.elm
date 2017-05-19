module SlippyMap.Layer.Marker
    exposing
        ( Config
        , defaultConfig
        , simpleLayer
        , layer
        )

{-| A layer to display markers.

@docs Config, defaultConfig, layer, simpleLayer
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config marker msg
    = Config { renderMarker : marker -> Svg msg }


{-| -}
defaultConfig : Config () msg
defaultConfig =
    Config
        { renderMarker = always circleMarker
        }


circleMarker : Svg msg
circleMarker =
    Svg.circle
        [ Svg.Attributes.r "8"
        , Svg.Attributes.fill "#3388ff"
        , Svg.Attributes.stroke "white"
        , Svg.Attributes.strokeWidth "3"
        ]
        []



-- LAYER


{-| -}
simpleLayer : Config () msg -> List Location -> Layer msg
simpleLayer config locations =
    let
        locatedMarkers =
            List.map (\location -> ( location, () )) locations
    in
        Layer.withRender Layer.marker (render config locatedMarkers)


{-| -}
layer : Config marker msg -> List ( Location, marker ) -> Layer msg
layer config locatedMarkers =
    Layer.withRender Layer.marker (render config locatedMarkers)


render : Config marker msg -> List ( Location, marker ) -> Layer.RenderState -> Svg msg
render config locatedMarkers ({ transform } as renderState) =
    let
        centerPoint =
            renderState.centerPoint

        bounds =
            renderState.locationBounds

        locatedMarkersFiltered =
            List.filter
                (\( location, _ ) ->
                    Location.isInsideBounds bounds location
                )
                locatedMarkers
    in
        Svg.g []
            (List.map (renderMarker config renderState) locatedMarkersFiltered)


renderMarker : Config marker msg -> Layer.RenderState -> ( Location, marker ) -> Svg msg
renderMarker (Config config) { locationToContainerPoint } ( location, marker ) =
    let
        markerPoint =
            locationToContainerPoint location
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
            [ config.renderMarker marker ]
