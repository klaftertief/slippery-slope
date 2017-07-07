module SlippyMap.Layer.Overlay
    exposing
        ( Config
        , defaultConfig
        , layer
        )

{-| A layer to show something at specific bounds.

@docs Config, defaultConfig, layer

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config overlay msg
    = Config { renderOverlay : ( Float, Float ) -> overlay -> Svg msg }


{-| -}
defaultConfig : Config String msg
defaultConfig =
    Config
        { renderOverlay = imageOverlay
        }


imageOverlay : ( Float, Float ) -> String -> Svg msg
imageOverlay ( width, height ) url =
    Svg.image
        [ Svg.Attributes.width (toString width)
        , Svg.Attributes.height (toString height)
        , Svg.Attributes.xlinkHref url
        ]
        []



-- LAYER


{-| -}
layer : Config overlay msg -> List ( Location.Bounds, overlay ) -> Layer msg
layer config boundedOverlays =
    Layer.withRender Layer.overlay (render config boundedOverlays)


render : Config overlay msg -> List ( Location.Bounds, overlay ) -> Layer.RenderState -> Svg msg
render config boundedOverlays renderState =
    Svg.g []
        (List.map (renderOverlay config renderState) boundedOverlays)


renderOverlay : Config overlay msg -> Layer.RenderState -> ( Location.Bounds, overlay ) -> Svg msg
renderOverlay (Config config) { locationToContainerPoint } ( bounds, overlay ) =
    let
        southWestPoint =
            locationToContainerPoint bounds.southWest

        northEastPoint =
            locationToContainerPoint bounds.northEast

        overlaySize =
            ( northEastPoint.x - southWestPoint.x
            , southWestPoint.y - northEastPoint.y
            )
    in
    Svg.g
        [ Svg.Attributes.transform
            ("translate("
                ++ toString southWestPoint.x
                ++ " "
                ++ toString northEastPoint.y
                ++ ")"
            )
        ]
        [ config.renderOverlay
            overlaySize
            overlay
        ]
