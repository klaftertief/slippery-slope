module SlippyMap.Map.State
    exposing
        ( State(..)
        , Interaction(..)
        , Drag
        , Pinch
        , Focus(..)
        , defaultState
        , center
        , getTransform
        , withInteractionTransform
        , getCoordinateBounds
        , getTileCover
        , setTransform
        , setInteraction
        , setFocus
        , setCenter
        , setZoom
        , zoomIn
        , zoomOut
        , zoomByAround
        , zoomInAround
        )

{-|
@docs State, center, getTransform, getCoordinateBounds, getTileCover
-}

import Mouse exposing (Position)
import SlippyMap.Geo.Coordinate as Coordinate exposing (Coordinate)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)


{-|
TODO: Maybe just have the most basic state here, e.g. the Transform, and move Drag and Focus to the interactive module?
-}
type State
    = State
        { transform : Transform
        , interaction : Maybe Interaction
        , focus : Focus
        }


type Interaction
    = Dragging Drag
    | Pinching Pinch


type alias Drag =
    { last : Position
    , current : Position
    }


type alias Pinch =
    { last : ( Position, Position )
    , current : ( Position, Position )
    }


type Focus
    = HasFocus
    | HasNoFocus


defaultState : State
defaultState =
    State
        { transform = defaultTransform
        , interaction = Nothing
        , focus = HasNoFocus
        }


setTransform : Transform -> State -> State
setTransform newTransform (State state) =
    State
        { state | transform = newTransform }


setInteraction : Maybe Interaction -> State -> State
setInteraction newInteraction (State state) =
    State
        { state | interaction = newInteraction }


setFocus : Focus -> State -> State
setFocus newFocus (State state) =
    State
        { state | focus = newFocus }


defaultTransform : Transform
defaultTransform =
    { tileSize = 256
    , width = 800
    , height = 1400
    , center = { lon = 0, lat = 0 }
    , zoom = 0
    }


withInteractionTransform : State -> State
withInteractionTransform ((State { interaction }) as state) =
    case interaction of
        Just (Dragging drag) ->
            withDragTransform drag state

        Just (Pinching pinch) ->
            withPinchTransform pinch state

        Nothing ->
            state


withDragTransform : Drag -> State -> State
withDragTransform { last, current } ((State { transform }) as state) =
    setTransform
        (Transform.moveTo transform
            { x = transform.width / 2 + toFloat (last.x - current.x)
            , y = transform.height / 2 + toFloat (last.y - current.y)
            }
        )
        state


withPinchTransform : Pinch -> State -> State
withPinchTransform { last, current } ((State { transform }) as state) =
    let
        toPoint position =
            { x = toFloat position.x
            , y = toFloat position.y
            }

        centerPoint ( pos1, pos2 ) =
            Point.add
                (toPoint pos1)
                (toPoint pos2)
                |> Point.divideBy 2

        distance ( pos1, pos2 ) =
            Point.distance
                (toPoint pos1)
                (toPoint pos2)

        lastCenter =
            centerPoint last

        lastDistance =
            distance last

        currentCenter =
            centerPoint current

        currentDistance =
            distance current

        newCenterPoint =
            { x =
                (transform.width / 2)
                    + lastCenter.x
                    - currentCenter.x
            , y =
                (transform.height / 2)
                    + lastCenter.y
                    - currentCenter.y
            }

        zoomDelta =
            Transform.scaleZoom
                (currentDistance / lastDistance)
    in
        state
            |> moveTo newCenterPoint
            |> zoomByAround zoomDelta currentCenter


moveTo : Point -> State -> State
moveTo newCenterPoint ((State { transform }) as state) =
    setTransform
        (Transform.moveTo transform newCenterPoint)
        state


setCenter : Location -> State -> State
setCenter newCenter ((State { transform }) as state) =
    setTransform { transform | center = newCenter } state


setZoom : Float -> State -> State
setZoom newZoom ((State { transform }) as state) =
    if isNaN newZoom || isInfinite newZoom then
        state
    else
        setTransform { transform | zoom = newZoom } state


zoomIn : State -> State
zoomIn ((State { transform }) as state) =
    setZoom (transform.zoom + 1) state


zoomOut : State -> State
zoomOut ((State { transform }) as state) =
    setZoom (transform.zoom - 1) state


zoomInAround : Point -> State -> State
zoomInAround =
    zoomByAround 1


zoomByAround : Float -> Point -> State -> State
zoomByAround delta point ((State { transform }) as state) =
    let
        newZoom =
            if isNaN delta || isInfinite delta then
                transform.zoom
            else
                transform.zoom + delta
    in
        setTransform
            (Transform.zoomToAround transform newZoom point)
            state


{-| -}
center : Location -> Float -> State
center initialCenter initialZoom =
    defaultState
        |> setCenter initialCenter
        |> setZoom initialZoom


{-| -}
getTransform : State -> Transform
getTransform (State { transform }) =
    transform


{-| -}
getLocationBounds : State -> Location.Bounds
getLocationBounds =
    getTransform >> Transform.locationBounds


{-| -}
getCoordinateBounds : State -> Coordinate.Bounds
getCoordinateBounds =
    getTransform >> Transform.tileBounds


{-| -}
getTileCover : State -> List Tile
getTileCover =
    getCoordinateBounds >> Tile.cover
