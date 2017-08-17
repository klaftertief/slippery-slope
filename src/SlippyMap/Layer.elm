module SlippyMap.Layer
    exposing
        ( Layer
        , base
        , flatten
        , getAttributions
        , group
        , layer
        , marker
        , overlay
        , popup
        , render
        , withAttribution
        , withCustomRenderer
        , withRenderer
        )

{-| A `Layer` usually renders geolocated contents on top of a map.

@docs marker, popup, overlay, base, withAttribution, Layer, layer, group, flatten, withRenderer, withCustomRenderer, getAttributions, render

-}

import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


{-| Configuration for a layer..
-}
type Config msg
    = Config
        { attribution : Maybe String
        , level : Int
        , renderer : Renderer msg
        }


{-| -}
type Renderer msg
    = NoRenderer
    | CustomRenderer (Transform -> Svg msg)



-- | GeneralRenderer ({generalConfig} -> Svg msg)
-- | TileRenderer ({generalConfig} -> {tileConfig} -> Svg msg)
-- | StaticRenderer (Svg msg)


{-| Create the `Config` for a `Layer` randered on the base `Pane`.
-}
base : Config msg
base =
    Config
        { attribution = Nothing
        , level = 0
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` randered on the overlay `Pane`.
-}
overlay : Config msg
overlay =
    Config
        { attribution = Nothing
        , level = 10
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` randered on the marker `Pane`.
-}
marker : Config msg
marker =
    Config
        { attribution = Nothing
        , level = 20
        , renderer = NoRenderer
        }


{-| Create the `Config` for a `Layer` randered on the popup `Pane`.
-}
popup : Config msg
popup =
    Config
        { attribution = Nothing
        , level = 30
        , renderer = NoRenderer
        }


{-| Adds an attribution to the layer config.

The attributions for each layer are rendered in the attribution control.

-}
withAttribution : String -> Config msg -> Config msg
withAttribution attribution (Config config) =
    Config
        { config
            | attribution = Just attribution
        }


{-| -}
withCustomRenderer : (Transform -> Svg msg) -> Config msg -> Config msg
withCustomRenderer render (Config config) =
    Config { config | renderer = CustomRenderer render }


{-| NOTE: It is important that the Layer depends only on `msg` so that different layers can be grouped together.
-}
type Layer msg
    = Layer (Config msg)
    | LayerGroup (List (Layer msg))


{-| -}
withRenderer : Config msg -> (Transform -> Svg msg) -> Layer msg
withRenderer (Config config) render =
    Layer <|
        Config { config | renderer = CustomRenderer render }


{-| -}
group : List (Layer msg) -> Layer msg
group layers =
    LayerGroup layers


{-| -}
layer : Config msg -> Layer msg
layer config =
    Layer config


layerWithAttribution : String -> Layer msg -> Layer msg
layerWithAttribution attribution layer =
    case layer of
        Layer config ->
            Layer <|
                withAttribution attribution config

        LayerGroup layers ->
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
        Layer layer ->
            [ Layer layer ]

        LayerGroup layers ->
            List.concatMap flattenHelp layers


level : Layer msg -> Int
level layer =
    case layer of
        Layer (Config { level }) ->
            level

        LayerGroup _ ->
            0


{-| TODO: Layers should have general attributes like class name. Add here.
-}
render : Transform -> Layer msg -> Svg msg
render transform layer =
    case layer of
        Layer (Config { renderer }) ->
            case renderer of
                NoRenderer ->
                    Svg.text ""

                CustomRenderer render ->
                    render transform

        LayerGroup _ ->
            Svg.text ""
