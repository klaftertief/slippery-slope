module SlippyMap.Layer.LowLevel
    exposing
        ( Config
        , Pane(..)
        , marker
        , overlay
        , tile
        , withAttribution
        , Layer
        , RenderState
        , transformToRenderState
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

@docs Config, Pane, marker, overlay, tile, withAttribution, Layer, RenderState, transformToRenderState, withRender, getAttribution, getPane, panes, isTileLayer, isOverlayLayer, isMarkerLayer, render
-}

import SlippyMap.Geo.Coordinate as Coordinate exposing (Coordinate)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
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
    | ControlPane


{-| -}
panes : List Pane
panes =
    [ TilePane
    , OverlayPane
    , MarkerPane
    , ControlPane
    ]


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


{-| Derived map state for unified layer implementations.

- `center`: Geographical center of the map view
- `zoom`: Zoom level of the map view
- `bounds`: Geographical bounds visible in the current map view
- `size`: Size of the map container (in pixels)

TODO: add `project...` fields for projections between different coordinate systems
-}
type alias RenderState =
    { center : Location
    , zoom : Float
    , bounds : Location.Bounds
    , size : Point
    , halfSize : Point
    , pixelBounds : Point.Bounds

    --
    , locationToContainerPoint : Location -> Point
    , containerPointToLocation : Point -> Location
    , coordinateToContainerPoint : Coordinate -> Point

    --
    , transform : Transform
    , tileTransform : Transform
    , centerPoint : Point
    , tileTransformCenterPoint : Point
    , tileScale : Float
    , locationBounds : Location.Bounds
    , coordinateBounds : Coordinate.Bounds
    , coordinateTileBounds : Coordinate.Bounds
    , tileCover : List Tile
    }


{-| -}
transformToRenderState : Transform -> RenderState
transformToRenderState transform =
    let
        tileTransform =
            Transform.tileTransform transform

        size =
            { x = transform.width, y = transform.height }

        halfSize =
            Point.divideBy 2 size

        centerPoint =
            Transform.centerPoint transform

        topLeftPoint =
            Point.subtract halfSize centerPoint
    in
        { center = transform.center
        , zoom = transform.zoom
        , bounds = Transform.locationBounds transform
        , size = size
        , halfSize = halfSize
        , pixelBounds = Transform.pixelBounds transform

        --
        , locationToContainerPoint =
            Transform.locationToPoint transform
                >> Point.subtract topLeftPoint
        , containerPointToLocation =
            Point.subtract topLeftPoint
                >> Transform.pointToLocation transform
        , coordinateToContainerPoint =
            Transform.coordinateToPoint transform
                >> Point.subtract topLeftPoint

        --
        , transform = transform
        , tileTransform = tileTransform
        , centerPoint = centerPoint
        , tileTransformCenterPoint = Transform.centerPoint tileTransform
        , tileScale = Transform.tileScale transform
        , locationBounds = Transform.locationBounds transform
        , coordinateBounds = Transform.bounds transform
        , coordinateTileBounds = Transform.tileBounds transform
        , tileCover = Transform.tileBounds transform |> Tile.cover
        }


{-| -}
type alias Render msg =
    RenderState -> Svg msg


{-| -}
getAttribution : Layer msg -> Maybe String
getAttribution (Layer { config }) =
    config.attribution


{-| -}
getPane : Layer msg -> Pane
getPane (Layer { config }) =
    config.pane


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


{-| TODO: Layers should have general attributes like class name. Inject here.
-}
render : Layer msg -> Render msg
render (Layer { render }) =
    render
