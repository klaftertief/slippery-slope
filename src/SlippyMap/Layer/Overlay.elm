module SlippyMap.Layer.Overlay
    exposing
        ( Config
        , defaultConfig
        , layer
        )

{-| A layer to show something at specific bounds.
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config overlay msg
    = Config { renderOverlay : ( Float, Float ) -> overlay -> Svg msg }


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


layer : Config overlay msg -> List ( Location.Bounds, overlay ) -> Layer msg
layer config boundedOverlays =
    Layer.withRender (Layer.withoutAttribution) (render config boundedOverlays)


render : Config overlay msg -> List ( Location.Bounds, overlay ) -> Transform -> Svg msg
render config boundedOverlays transform =
    let
        centerPoint =
            Transform.centerPoint transform
    in
        Svg.g
            [ Svg.Attributes.transform
                (""
                    ++ "translate("
                    ++ toString (round (transform.width / 2 - centerPoint.x))
                    ++ " "
                    ++ toString (round (transform.height / 2 - centerPoint.y))
                    ++ ")"
                )
            ]
            (List.map (renderOverlay config transform) boundedOverlays)


renderOverlay : Config overlay msg -> Transform -> ( Location.Bounds, overlay ) -> Svg msg
renderOverlay (Config config) transform ( bounds, overlay ) =
    let
        southWestPoint =
            Transform.locationToPoint transform
                bounds.southWest

        northEastPoint =
            Transform.locationToPoint transform
                bounds.northEast
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
                ( northEastPoint.x - southWestPoint.x
                , southWestPoint.y - northEastPoint.y
                )
                overlay
            ]
