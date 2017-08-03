module SlippyMap.Layer
    exposing
        ( Config
        , Layer
        , Pane(..)
        , base
        , flatten
        , getAttributions
        , getPane
        , group
        , marker
        , overlay
        , panes
        , popup
        , render
        , withAttribution
        , withRender
        )

{-| LowLevel Layer

@docs Config, Pane, marker, popup, overlay, base, withAttribution, Layer, group, flatten, withRender, getAttributions, getPane, panes, render

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
    | LayerGroup (List (Layer msg))


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
group : List (Layer msg) -> Layer msg
group layers =
    LayerGroup layers


{-| -}
type alias Render msg =
    Transform -> Svg msg


{-| -}
getAttributions : Layer msg -> List String
getAttributions layer =
    case layer of
        Layer { config } ->
            config.attribution
                |> Maybe.map List.singleton
                |> Maybe.withDefault []

        LayerGroup layers ->
            List.concatMap getAttributions layers


{-| -}
flatten : List (Layer msg) -> List (Layer msg)
flatten layers =
    List.concatMap flattenHelp layers


flattenHelp : Layer msg -> List (Layer msg)
flattenHelp layer =
    case layer of
        Layer layer ->
            [ Layer layer ]

        LayerGroup layers ->
            List.concatMap flattenHelp layers


{-| -}
getPane : Layer msg -> Maybe Pane
getPane layer =
    case layer of
        Layer { config } ->
            Just config.pane

        LayerGroup _ ->
            Nothing


{-| TODO: Layers should have general attributes like class name. Inject here.
-}
render : Layer msg -> Render msg
render layer =
    case layer of
        Layer { render } ->
            render

        LayerGroup _ ->
            always (Svg.text "")
