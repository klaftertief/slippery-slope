module SlippyMap.Layer.LowLevel
    exposing
        ( Config
        , Pane(..)
        , marker
        , overlay
        , tile
        , withAttribution
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

@docs Config, Pane, marker, overlay, tile, withAttribution, Layer, withRender, getAttribution, getPane, panes, isTileLayer, isOverlayLayer, isMarkerLayer, render
-}

import SlippyMap.Geo.Transform as Transform exposing (Transform)
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
    = TilePane
    | OverlayPane
    | MarkerPane


{-| -}
tile : Config
tile =
    Config
        { attribution = Nothing
        , pane = TilePane
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
withAttribution : String -> Config -> Config
withAttribution attribution (Config configInternal) =
    Config
        { configInternal
            | attribution = Just attribution
        }


{-|
NOTE: It is important that the Layer depends only on `msg` so that different layers can be grouped together.
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
