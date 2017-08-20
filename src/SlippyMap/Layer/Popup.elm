module SlippyMap.Layer.Popup
    exposing
        ( Config
        , config
        , layer
        )

{-| A layer to display popups.

@docs Config, config, layer

-}

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)


-- CONFIG


{-| Configuration for the layer.
-}
type Config popup msg
    = Config { renderPopup : popup -> Html msg }


{-| -}
config : Config String msg
config =
    Config
        { renderPopup = simplePopup
        }


simplePopup : String -> Html msg
simplePopup content =
    Html.div
        [ Html.Attributes.class "popup--simple"
        , Html.Attributes.style
            [ ( "filter"
              , "drop-shadow(rgba(0,0,0,0.2) 0px 2px 4px)"
              )
            , ( "transform", "translate(6px, -50%)" )
            , ( "display", "flex" )
            , ( "align-items", "center" )
            ]
        ]
        [ Html.div
            [ Html.Attributes.style
                [ ( "position", "relative" )
                , ( "left", "6px" )
                , ( "background", "#fff" )
                , ( "border-radius", "0 0 0 2px" )
                , ( "width", "12px" )
                , ( "height", "12px" )
                , ( "transform", "rotate(45deg)" )
                ]
            ]
            []
        , Html.div
            [ Html.Attributes.style
                [ ( "position", "relative" )
                , ( "background", "#fff" )
                , ( "border-radius", "4px" )
                , ( "padding", "0.5em 1em" )
                , ( "min-width", "180px" )
                , ( "max-width", "240px" )
                ]
            ]
            [ Html.text content ]
        ]



-- LAYER


{-| -}
layer : Config popup msg -> List ( Location, popup ) -> Layer msg
layer config locatedPopups =
    Layer.custom (render config locatedPopups) Layer.popup


render : Config popup msg -> List ( Location, popup ) -> Transform -> Html msg
render config locatedPopups transform =
    Html.div [ Html.Attributes.class "layer--popup" ]
        (List.map (renderPopup config transform) locatedPopups)


renderPopup : Config popup msg -> Transform -> ( Location, popup ) -> Html msg
renderPopup (Config config) transform ( location, popup ) =
    let
        popupPoint =
            Transform.locationToScreenPoint transform location
    in
    Html.div
        [ Html.Attributes.class "popup__positioner"
        , Html.Attributes.style
            [ ( "position", "relative" )
            , ( "pointer-events", "none" )
            , ( "transform"
              , "translate("
                    ++ toString popupPoint.x
                    ++ "px, "
                    ++ toString popupPoint.y
                    ++ "px)"
              )
            ]
        ]
        [ config.renderPopup popup ]
