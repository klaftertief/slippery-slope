module SlippyMap.Layer.Overlay
    exposing
        ( Config
        , config
        , defaultConfig
        , layer
        )

{-| A layer to show something at specific bounds.

@docs Config, config, defaultConfig, layer

-}

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Geo.Location as Location
import SlippyMap.Geo.Point as Point
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map as Map exposing (Map)


-- CONFIG


{-| Configuration for the layer.
-}
type Config overlay msg
    = Config
        { renderOverlay :
            ( Float, Float ) -> overlay -> Html msg
        }


{-| -}
config : (( Float, Float ) -> overlay -> Html msg) -> Config overlay msg
config render =
    Config
        { renderOverlay = render }


{-| -}
defaultConfig : Config String msg
defaultConfig =
    Config
        { renderOverlay = imageOverlay
        }


imageOverlay : ( Float, Float ) -> String -> Html msg
imageOverlay ( width, height ) url =
    Html.img
        [ Html.Attributes.width (round width)
        , Html.Attributes.height (round height)
        , Html.Attributes.src url
        ]
        []



-- LAYER


{-| -}
layer : Config overlay msg -> List ( Location.Bounds, overlay ) -> Layer msg
layer config boundedOverlays =
    Layer.custom (render config boundedOverlays) Layer.overlay


render : Config overlay msg -> List ( Location.Bounds, overlay ) -> Map msg -> Html msg
render config boundedOverlays map =
    Html.div []
        (List.map (renderOverlay config map) boundedOverlays)


renderOverlay : Config overlay msg -> Map msg -> ( Location.Bounds, overlay ) -> Html msg
renderOverlay (Config config) map ( bounds, overlay ) =
    let
        origin =
            Map.origin map

        southWestPoint =
            Map.locationToPoint map
                bounds.southWest

        northEastPoint =
            Map.locationToPoint map
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
