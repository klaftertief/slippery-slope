module SlippyMap.Layer
    exposing
        ( Config
        , Layer
        , Pane(..)
        , base
        , getAttribution
        , getPane
        , isBaseLayer
        , isMarkerLayer
        , isOverlayLayer
        , marker
        , overlay
        , panes
        , popup
        , render
        , withAttribution
        , withRender
        )

{-| LowLevel Layer

@docs Config, Pane, marker, popup, overlay, base, withAttribution, Layer, RenderState, transformToRenderState, withRender, getAttribution, getPane, panes, isBaseLayer, isOverlayLayer, isMarkerLayer, render

-}

import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


{-| Base configuration for all layers.
-}
type Config
    = Config ConfigInternal


type alias ConfigInternal =
    { attribution : Maybe String
    , pane : Pane
    }


{-| -}
type Pane
    = BasePane
    | OverlayPane
    | MarkerPane
    | PopupPane
    | ControlPane


{-| -}
panes : List Pane
panes =
    [ BasePane
    , OverlayPane
    , MarkerPane
    , PopupPane
    , ControlPane
    ]


{-| -}
base : Config
base =
    Config
        { attribution = Nothing
        , pane = BasePane
        }


{-| -}
overlay : Config
overlay =
    Config
        { attribution = Nothing
        , pane = OverlayPane
        }


{-| -}
marker : Config
marker =
    Config
        { attribution = Nothing
        , pane = MarkerPane
        }


{-| -}
popup : Config
popup =
    Config
        { attribution = Nothing
        , pane = PopupPane
        }


{-| -}
withAttribution : String -> Config -> Config
withAttribution attribution (Config configInternal) =
    Config
        { configInternal
            | attribution = Just attribution
        }


{-| NOTE: It is important that the Layer depends only on `msg` so that different layers can be grouped together.
-}
type Layer msg
    = Layer (LayerInternal msg)


type alias LayerInternal msg =
    { config : ConfigInternal
    , render : Render msg
    }


{-| -}
withRender : Config -> Render msg -> Layer msg
withRender (Config configInternal) render =
    Layer
        { config = configInternal
        , render = render
        }


{-| -}
type alias Render msg =
    Transform -> Svg msg


{-| -}
getAttribution : Layer msg -> Maybe String
getAttribution (Layer { config }) =
    config.attribution


{-| -}
getPane : Layer msg -> Pane
getPane (Layer { config }) =
    config.pane


{-| -}
isBaseLayer : Layer msg -> Bool
isBaseLayer (Layer { config }) =
    config.pane == BasePane


{-| -}
isOverlayLayer : Layer msg -> Bool
isOverlayLayer (Layer { config }) =
    config.pane == OverlayPane


{-| -}
isMarkerLayer : Layer msg -> Bool
isMarkerLayer (Layer { config }) =
    config.pane == MarkerPane


{-| TODO: Layers should have general attributes like class name. Inject here.
-}
render : Layer msg -> Render msg
render (Layer { render }) =
    render
