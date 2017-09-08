module SlippyMap.Layer.Overlay
    exposing
        ( Config
        , customConfig
        , defaultConfig
        , iframeConfig
        , layer
        )

{-| A layer to show something at specific bounds.

@docs Config, defaultConfig, iframeConfig, customConfig, layer

-}

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Transform as Transform exposing (Transform)


-- CONFIG


{-| Configuration for the layer.
-}
type Config overlay msg
    = Config
        { renderOverlay :
            ( Float, Float ) -> overlay -> Html msg
        }


{-| -}
defaultConfig : Config String msg
defaultConfig =
    Config
        { renderOverlay = imageOverlay
        }


{-| -}
iframeConfig : Config String msg
iframeConfig =
    Config
        { renderOverlay = iframeOverlay
        }


{-| -}
customConfig : Config (Html msg) msg
customConfig =
    Config
        { renderOverlay = customOverlay
        }


imageOverlay : ( Float, Float ) -> String -> Html msg
imageOverlay ( width, height ) url =
    Html.img
        [ Html.Attributes.width (round width)
        , Html.Attributes.height (round height)
        , Html.Attributes.src url

        -- , Html.Attributes.style [ ( "pointer-events", "none" ) ]
        ]
        []


iframeOverlay : ( Float, Float ) -> String -> Html msg
iframeOverlay ( width, height ) url =
    let
        scale =
            width / 1024
    in
    Html.iframe
        [ Html.Attributes.src url
        , Html.Attributes.attribute "frameBorder" "0"
        , Html.Attributes.width 1024
        , Html.Attributes.height 576
        , Html.Attributes.style
            [ ( "transform", "scale(" ++ toString scale ++ ")" )
            , ( "transform-origin", "0 0" )
            ]
        ]
        []


customOverlay : ( Float, Float ) -> Html msg -> Html msg
customOverlay ( width, height ) content =
    let
        scale =
            width / 1024
    in
    Html.div
        [ Html.Attributes.style
            [ ( "width", "1024px" )
            , ( "height", "576px" )
            , ( "transform", "scale(" ++ toString scale ++ ")" )
            , ( "transform-origin", "0 0" )
            ]
        ]
        [ content ]



-- LAYER


{-| -}
layer : Config overlay msg -> List ( Location.Bounds, overlay ) -> Layer msg
layer config boundedOverlays =
    Layer.custom (render config boundedOverlays) Layer.overlay


render : Config overlay msg -> List ( Location.Bounds, overlay ) -> Layer.RenderParameters msg -> Html msg
render config boundedOverlays { transform } =
    Html.div []
        (List.map (renderOverlay config transform) boundedOverlays)


renderOverlay : Config overlay msg -> Transform -> ( Location.Bounds, overlay ) -> Html msg
renderOverlay (Config config) transform ( bounds, overlay ) =
    let
        origin =
            Transform.origin transform

        southWestPoint =
            Transform.locationToPoint transform
                bounds.southWest

        northEastPoint =
            Transform.locationToPoint transform
                bounds.northEast

        overlaySize =
            ( northEastPoint.x - southWestPoint.x
            , southWestPoint.y - northEastPoint.y
            )

        translate =
            Point.subtract origin southWestPoint
    in
    Html.div
        [ Html.Attributes.style
            [ ( "transform"
              , "translate("
                    ++ toString translate.x
                    ++ "px, "
                    ++ toString (translate.y - southWestPoint.y + northEastPoint.y)
                    ++ "px)"
              )
            ]
        ]
        [ config.renderOverlay overlaySize overlay ]
