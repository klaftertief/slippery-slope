module SlippyMap.Layer.Popup
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to display popups.

@docs Config, config, defaultConfig, layer, simpleLayer
-}

import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Location as Location exposing (Location)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.
-}
type Config popup msg
    = Config { renderPopup : popup -> Svg msg }


{-| -}
config : Config String msg
config =
    Config
        { renderPopup = simplePopup
        }


simplePopup : String -> Svg msg
simplePopup content =
    Svg.circle
        [ Svg.Attributes.r "8"
        , Svg.Attributes.fill "#3388ff"
        , Svg.Attributes.stroke "white"
        , Svg.Attributes.strokeWidth "3"
        ]
        []



-- LAYER


{-| -}
layer : Config popup msg -> List ( Location, popup ) -> Layer msg
layer config locatedPopups =
    Layer.withRender Layer.popup (render config locatedPopups)


render : Config popup msg -> List ( Location, popup ) -> Layer.RenderState -> Svg msg
render config locatedPopups ({ transform } as renderState) =
    Svg.g []
        (List.map (renderPopup config renderState) locatedPopups)


renderPopup : Config popup msg -> Layer.RenderState -> ( Location, popup ) -> Svg msg
renderPopup (Config config) { locationToContainerPoint } ( location, popup ) =
    let
        popupPoint =
            locationToContainerPoint location
    in
        Svg.g
            [ Svg.Attributes.transform
                ("translate("
                    ++ toString popupPoint.x
                    ++ " "
                    ++ toString popupPoint.y
                    ++ ")"
                )
            ]
            [ config.renderPopup popup ]
