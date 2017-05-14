module SlippyMap.Layer.LowLevel
    exposing
        ( Config
        , Pane(..)
        , withAttribution
        , withoutAttribution
        , Layer
        , withRender
        , getAttribution
        , getPane
        , panes
        , isTileLayer
        , isOverlayLayer
        , isMarkerLayer
        , render
        )

{-| LowLevel Layer

@docs Config, Pane, withAttribution, withoutAttribution, Layer, withRender, getAttribution, getPane, panes, isTileLayer, isOverlayLayer, isMarkerLayer, render
-}

import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


{-| Base configuration for all layers.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config
    = Config ConfigInternal


type alias ConfigInternal =
    { attribution : Maybe String
    , pane : Pane
    }


{-| -}
type Pane
    = TilePane
    | OverlayPane
    | MarkerPane


{-| -}
withAttribution : String -> Config
withAttribution attribution =
    Config
        { attribution = Just attribution
        , pane = OverlayPane
        }


{-| -}
withoutAttribution : Config
withoutAttribution =
    Config
        { attribution = Nothing
        , pane = OverlayPane
        }


{-|
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


{-|
TODO: Should this be Tansform -> Svg or Map.State -> Svg?
    The idea is to precalculate often needed accessors like bound, tileCover...
-}
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
panes : List Pane
panes =
    [ TilePane
    , OverlayPane
    , MarkerPane
    ]


{-| -}
isTileLayer : Layer msg -> Bool
isTileLayer (Layer { config }) =
    config.pane == TilePane


{-| -}
isOverlayLayer : Layer msg -> Bool
isOverlayLayer (Layer { config }) =
    config.pane == OverlayPane


{-| -}
isMarkerLayer : Layer msg -> Bool
isMarkerLayer (Layer { config }) =
    config.pane == MarkerPane


{-| -}
render : Layer msg -> Render msg
render (Layer { render }) =
    render
