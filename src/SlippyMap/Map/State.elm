module SlippyMap.Map.State
    exposing
        ( Drag
        , Focus(..)
        , Interaction(..)
        , Pinch
        , Scene
        , State(..)
        , Target(..)
        , center
        , defaultState
        , setCenter
        , setFocus
        , setInteraction
        , setScene
        , setZoom
        , withInteraction
        , zoomByAround
        , zoomIn
        , zoomInAround
        , zoomOut
        )

{-|

@docs State, center, getTransform, getCoordinateBounds, getTileCover

-}

import Mouse exposing (Position)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import Time exposing (Time)


{-| -}
type State
    = State
        { scene : Scene
        , target : Target
        , interaction : Interaction
        , focus : Focus
        }


type alias Scene =
    { center : Location
    , zoom : Float
    }


type Target
    = NoTarget
    | MoveTo
        { scene : Scene
        , duration : Time
        }


type Interaction
    = NoInteraction
    | Dragging Drag
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
        { scene = defaultScene
        , target = NoTarget
        , interaction = NoInteraction
        , focus = HasNoFocus
        }


setScene : Scene -> State -> State
setScene newScene (State state) =
    State
        { state | scene = newScene }


setInteraction : Interaction -> State -> State
setInteraction newInteraction (State state) =
    State
        { state | interaction = newInteraction }


setFocus : Focus -> State -> State
setFocus newFocus (State state) =
    State
        { state | focus = newFocus }


defaultScene : Scene
defaultScene =
    { center = Location 0 0
    , zoom = 0
    }


withInteraction : State -> State
withInteraction ((State { interaction }) as state) =
    case interaction of
        Dragging drag ->
            state

        Pinching pinch ->
            state

        NoInteraction ->
            state


moveTo : Point -> State -> State
moveTo newCenterPoint ((State { scene }) as state) =
    state


setCenter : Location -> State -> State
setCenter newCenter ((State { scene }) as state) =
    setScene { scene | center = newCenter } state


setZoom : Float -> State -> State
setZoom newZoom ((State { scene }) as state) =
    if isNaN newZoom || isInfinite newZoom then
        state
    else
        setScene { scene | zoom = newZoom } state


zoomIn : State -> State
zoomIn ((State { scene }) as state) =
    setZoom (scene.zoom + 1) state


zoomOut : State -> State
zoomOut ((State { scene }) as state) =
    setZoom (scene.zoom - 1) state


zoomInAround : Point -> State -> State
zoomInAround =
    zoomByAround 1


zoomByAround : Float -> Point -> State -> State
zoomByAround delta point ((State { scene }) as state) =
    let
        newZoom =
            if isNaN delta || isInfinite delta then
                scene.zoom
            else
                scene.zoom + delta
    in
    state


{-| -}
center : Location -> Float -> State
center initialCenter initialZoom =
    defaultState
        |> setCenter initialCenter
        |> setZoom initialZoom


{-| -}
getScene : State -> Scene
getScene (State { scene }) =
    scene
