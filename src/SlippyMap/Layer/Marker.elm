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
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config marker msg
    = Config { renderMarker : marker -> Svg msg }


{-| -}
config : (marker -> Svg msg) -> Config marker msg
config renderMarker =
    Config
        { renderMarker = renderMarker
        }


{-| -}
layer : Config marker msg -> List ( Location, marker ) -> Layer msg
layer config locatedMarkers =
    Layer.withRender Layer.marker (render config locatedMarkers)


{-| -}
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
