module SlippyMap.Layer
    exposing
        ( Config
        , Layer
        , attributions
        , base
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

TODO: Should setting the attribution wor on the config or on the layer? On the layer makes it so that all layers can just use it, on the config makes it so that one can not set an attribution to a group (wich does not make any sense.)

@docs Config, marker, popup, overlay, base, withAttribution, Layer, group, custom, flatten, attributions, render

-}

import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


{-| Configuration for a layer.

TODO: should the attribution be a proper type?

-}
type Config msg
    = Config
        { pane : Pane
        , renderer : Renderer msg
        }


{-| -}
type Renderer msg
    = NoRenderer
    | CustomRenderer (Transform -> Svg msg)


{-| Each `Layer` is placed on a `Pane` that defines the order of layers on top of the map.
-}
type Pane
    = BasePane
    | OverlayPane
    | MarkerPane
    | PopupPane
    | ControlPane
    | CustomPane Int


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

        CustomPane level ->
            level



-- | GeneralRenderer ({generalConfig} -> Svg msg)
-- | TileRenderer ({generalConfig} -> {tileConfig} -> Svg msg)
-- | StaticRenderer (Svg msg)


{-| Create the `Config` for a `Layer` randered on the base `Pane`.
-}
base : Config msg
base =
    Config
        { pane = BasePane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` randered on the overlay `Pane`.
-}
overlay : Config msg
overlay =
    Config
        { pane = OverlayPane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` randered on the marker `Pane`.
-}
marker : Config msg
marker =
    Config
        { pane = MarkerPane
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` randered on the popup `Pane`.
-}
popup : Config msg
popup =
    Config
        { pane = PopupPane
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


type alias Attribution =
    Maybe String


{-| NOTE: It is important that the Layer depends only on `msg` so that different layers can be grouped together.
-}
type Layer msg
    = Layer Attribution (Config msg)
    | LayerGroup Attribution (List (Layer msg))


{-| -}
custom : (Transform -> Svg msg) -> Config msg -> Layer msg
custom render (Config config) =
    Layer Nothing <|
        Config
            { config
                | renderer = CustomRenderer render
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
render : Transform -> Layer msg -> Svg msg
render transform layer =
    case layer of
        Layer _ (Config { renderer }) ->
            case renderer of
                NoRenderer ->
                    Svg.text ""

                CustomRenderer render ->
                    render transform

        LayerGroup _ _ ->
            Svg.text ""
