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

{-| A `Layer` usually renders geolocated contents on top of a map.

@docs Config, Pane, marker, popup, overlay, base, withAttribution, Layer, group, flatten, withRender, getAttributions, getPane, panes, render

-}

import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


{-| Configuration for a layer..
-}
type Config msg
    = Config (ConfigInternal msg)


type alias ConfigInternal msg =
    { attribution : Maybe String
    , pane : Pane
    , render : Render msg
    }


{-| -}
type alias Render msg =
    Transform -> Svg msg


{-| Each `Layer` is placed on a `Pane` that defines the order of layers on top of the map.
-}
type Pane
    = BasePane
    | OverlayPane
    | MarkerPane
    | PopupPane
    | ControlPane


{-| List of all supported Panes.
-}
panes : List Pane
panes =
    [ BasePane
    , OverlayPane
    , MarkerPane
    , PopupPane
    , ControlPane
    ]


{-| Create the `Config` for a `Layer` randered on the base `Pane`.
-}
base : Config msg
base =
    Config
        { attribution = Nothing
        , pane = BasePane
        , render = always (Svg.text "")
        }


{-| Create the `Config` for a `Layer` randered on the overlay `Pane`.
-}
overlay : Config msg
overlay =
    Config
        { attribution = Nothing
        , pane = OverlayPane
        , render = always (Svg.text "")
        }


{-| Create the `Config` for a `Layer` randered on the marker `Pane`.
-}
marker : Config msg
marker =
    Config
        { attribution = Nothing
        , pane = MarkerPane
        , render = always (Svg.text "")
        }


{-| Create the `Config` for a `Layer` randered on the popup `Pane`.
-}
popup : Config msg
popup =
    Config
        { attribution = Nothing
        , pane = PopupPane
        , render = always (Svg.text "")
        }


{-| Adds an attribution to the layer config.

The attributions for each layer are rendered in the attribution control.

-}
withAttribution : String -> Config msg -> Config msg
withAttribution attribution (Config configInternal) =
    Config
        { configInternal
            | attribution = Just attribution
        }


{-| NOTE: It is important that the Layer depends only on `msg` so that different layers can be grouped together.
-}
type Layer msg
    = Layer (Config msg)
    | LayerGroup (List (Layer msg))


{-| -}
withRender : Config msg -> Render msg -> Layer msg
withRender (Config configInternal) render =
    Layer <|
        Config { configInternal | render = render }


{-| -}
group : List (Layer msg) -> Layer msg
group layers =
    LayerGroup layers


{-| -}
getAttributions : Layer msg -> List String
getAttributions layer =
    case layer of
        Layer (Config { attribution }) ->
            attribution
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
        Layer (Config { pane }) ->
            Just pane

        LayerGroup _ ->
            Nothing


{-| TODO: Layers should have general attributes like class name. Inject here.
-}
render : Layer msg -> Render msg
render layer =
    case layer of
        Layer (Config { render }) ->
            render

        LayerGroup _ ->
            always (Svg.text "")
