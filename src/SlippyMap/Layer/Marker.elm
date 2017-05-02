module SlippyMap.Layer.Marker
    exposing
        ( Config
        , defaultConfig
        , simpleLayer
        , layer
        )

{-| A layer to display markers.
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
type Config marker msg
    = Config { renderMarker : marker -> Svg msg }


defaultConfig : Config () msg
defaultConfig =
    Config
        { renderMarker = always circleMarker
        }


circleMarker : Svg msg
circleMarker =
    Svg.circle
        [ Svg.Attributes.r "8"
        , Svg.Attributes.fill "green"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.strokeWidth "2"
        ]
        []



-- LAYER


simpleLayer : Config () msg -> List Location -> Layer msg
simpleLayer config locations =
    let
        locatedMarkers =
            List.map (\location -> ( location, () )) locations
    in
        Layer.withRender (Layer.withoutAttribution) (render config locatedMarkers)


layer : Config marker msg -> List ( Location, marker ) -> Layer msg
layer config locatedMarkers =
    Layer.withRender (Layer.withoutAttribution) (render config locatedMarkers)


render : Config marker msg -> List ( Location, marker ) -> Transform -> Svg msg
render config locatedMarkers transform =
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
            (List.map (renderMarker config transform) locatedMarkers)


renderMarker : Config marker msg -> Transform -> ( Location, marker ) -> Svg msg
renderMarker (Config config) transform ( location, marker ) =
    let
        markerPoint =
            Transform.locationToPoint transform location
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
