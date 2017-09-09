module SlippyMap.Layer
    exposing
        ( Config
        , Layer
        , RenderParameters
        , attributions
        , base
        , control
        , custom
        , flatten
        , group
        , marker
        , overlay
        , popup
        , render
        , withAttribution
        )

{-| A `Layer` usually renders geolocated contents on top of a map.

@docs Config, marker, popup, overlay, base, control, Layer, RenderParameters, custom, group, withAttribution, attributions, flatten, render

-}

import Html exposing (Html)
import SlippyMap.Map.Config as Map
import SlippyMap.Map.State as Map
import SlippyMap.Map.Transform as Transform exposing (Transform)


{-| Configuration for a layer.
-}
type Config msg
    = Config
        { pane : Pane
        , renderer : Renderer msg
        }


{-| -}
type Renderer msg
    = NoRenderer
    | Renderer (RenderParameters msg -> Html msg)


{-| -}
type alias RenderParameters msg =
    { mapConfig : Map.Config msg
    , mapState : Map.State
    , transform : Transform
    }


{-| Each `Layer` is placed on a `Pane` that defines the order of layers on top of the map.
-}
type Pane
    = BasePane
    | OverlayPane
    | MarkerPane
    | PopupPane
    | ControlPane
    | CustomLevel Int


paneToLevel : Pane -> Int
paneToLevel pane =
    case pane of
        BasePane ->
            0

        OverlayPane ->
            10

        MarkerPane ->
            20

        PopupPane ->
            30

        ControlPane ->
            40

        CustomLevel level ->
            level


{-| Create the `Config` for a `Layer` rendered on the base `Pane`.
-}
base : Config msg
base =
    Config
        { pane = BasePane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` rendered on the overlay `Pane`.
-}
overlay : Config msg
overlay =
    Config
        { pane = OverlayPane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` rendered on the marker `Pane`.
-}
marker : Config msg
marker =
    Config
        { pane = MarkerPane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` rendered on the popup `Pane`.
-}
popup : Config msg
popup =
    Config
        { pane = PopupPane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` rendered on the control `Pane`.
-}
control : Config msg
control =
    Config
        { pane = ControlPane
        , renderer = NoRenderer
        }


{-| Adds an attribution to the layer config.

The attributions for each layer are rendered in the attribution control.

-}
withAttribution : String -> Layer msg -> Layer msg
withAttribution attribution layer =
    case layer of
        Layer _ config ->
            Layer (Just attribution) config

        LayerGroup _ layers ->
            LayerGroup (Just attribution) layers


{-| TODO: should the attribution be a proper type?
-}
type alias Attribution =
    Maybe String


{-| NOTE: It is important that the Layer depends only on `msg` so that different layers can be grouped together.
-}
type Layer msg
    = Layer Attribution (Config msg)
    | LayerGroup Attribution (List (Layer msg))


{-| -}
custom : (RenderParameters msg -> Html msg) -> Config msg -> Layer msg
custom render (Config config) =
    Layer Nothing <|
        Config
            { config
                | renderer = Renderer render
            }


{-| -}
group : List (Layer msg) -> Layer msg
group layers =
    LayerGroup Nothing layers


{-| -}
attributions : Layer msg -> List String
attributions layer =
    case layer of
        Layer attribution _ ->
            attributionToList attribution

        LayerGroup attribution layers ->
            List.append
                (attributionToList attribution)
                (List.concatMap attributions layers)


attributionToList : Attribution -> List String
attributionToList attribution =
    attribution
        |> Maybe.map List.singleton
        |> Maybe.withDefault []


{-| Flat list of possibly nested layers, sorted by Pane
-}
flatten : List (Layer msg) -> List (Layer msg)
flatten layers =
    layers
        |> List.concatMap flattenHelp
        |> List.sortBy level


flattenHelp : Layer msg -> List (Layer msg)
flattenHelp layer =
    case layer of
        Layer attribution config ->
            [ Layer attribution config ]

        LayerGroup _ layers ->
            List.concatMap flattenHelp layers


level : Layer msg -> Int
level layer =
    case layer of
        Layer _ (Config { pane }) ->
            paneToLevel pane

        LayerGroup _ _ ->
            0


{-| TODO: Layers should have general attributes like class name. Add here.
-}
render : RenderParameters msg -> Layer msg -> Html msg
render renderParams layer =
    case layer of
        Layer _ (Config { renderer }) ->
            case renderer of
                NoRenderer ->
                    Html.text ""

                Renderer render ->
                    render renderParams

        LayerGroup _ _ ->
            Html.text ""
