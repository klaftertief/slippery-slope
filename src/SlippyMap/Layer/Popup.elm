module SlippyMap.Layer.Popup
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to display popups.

@docs Config, config, layer

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
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
    Svg.g
        [ Svg.Attributes.transform "translate(-60 -45)" ]
        [ Svg.rect
            [ Svg.Attributes.width "120"
            , Svg.Attributes.height "30"
            , Svg.Attributes.rx "5"
            , Svg.Attributes.ry "5"
            , Svg.Attributes.fill "#fff"
            ]
            []
        , Svg.text_
            [ Svg.Attributes.x "60"
            , Svg.Attributes.y "20"
            , Svg.Attributes.textAnchor "middle"
            ]
            [ Svg.text content ]
        ]



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
