module SlippyMap.Map.State
    exposing
        ( State(..)
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

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Map.Config as Config exposing (Config)
import SlippyMap.Map.Transform as Transform exposing (Transform)
import SlippyMap.Map.Types as Types exposing (..)


{-| -}
type State
    = State
        { scene : Scene
        , transition : Transition
        , interaction : Interaction
        , focus : Focus
        }


defaultState : State
defaultState =
    State
        { scene = defaultScene
        , transition = NoTransition
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


withInteraction : Config msg -> State -> State
withInteraction config ((State { interaction }) as state) =
    case interaction of
        Dragging drag ->
            withDrag config drag state

        Pinching pinch ->
            state

        NoInteraction ->
            state


withDrag : Config msg -> Drag -> State -> State
withDrag ((Config.Config { size }) as config) { last, current } state =
    let
        newCenterPoint =
            size
                |> Point.divideBy 2
                |> Point.add
                    { x = toFloat (last.x - current.x)
                    , y = toFloat (last.y - current.y)
                    }
    in
    moveTo config newCenterPoint state


moveTo : Config msg -> Point -> State -> State
moveTo config newCenterPoint ((State { scene }) as state) =
    let
        transform =
            Transform.transform config scene

        newCenter =
            Transform.screenPointToLocation transform
                newCenterPoint
    in
    setCenter config newCenter state


setCenter : Config msg -> Location -> State -> State
setCenter config newCenter ((State { scene }) as state) =
    setScene
        { scene | center = newCenter }
        state


setZoom : Config msg -> Float -> State -> State
setZoom (Config.Config { minZoom, maxZoom }) newZoom ((State { scene }) as state) =
    if isNaN newZoom || isInfinite newZoom then
        state
    else
        setScene
            { scene | zoom = clamp minZoom maxZoom newZoom }
            state


zoomIn : Config msg -> State -> State
zoomIn config ((State { scene }) as state) =
    setZoom config (scene.zoom + 1) state


zoomOut : Config msg -> State -> State
zoomOut config ((State { scene }) as state) =
    setZoom config (scene.zoom - 1) state


zoomInAround : Config msg -> Point -> State -> State
zoomInAround config =
    zoomByAround config 1


zoomByAround : Config msg -> Float -> Point -> State -> State
zoomByAround ((Config.Config { size, minZoom, maxZoom }) as config) delta around ((State { scene }) as state) =
    let
        newZoom =
            if isNaN delta || isInfinite delta then
                scene.zoom
            else
                clamp minZoom maxZoom (scene.zoom + delta)

        transform =
            Transform.transform config scene

        transformZoomed =
            Transform.transform config { scene | zoom = newZoom }

        currentCenterPoint =
            Transform.locationToPoint transform scene.center

        aroundPoint =
            around
                |> Point.add currentCenterPoint
                |> Point.subtract (Point.divideBy 2 size)

        aroundLocation =
            Transform.pointToLocation transform aroundPoint

        aroundPointZoomed =
            Transform.locationToPoint transformZoomed aroundLocation

        aroundPointDiff =
            Point.subtract aroundPoint aroundPointZoomed

        newCenter =
            Transform.pointToLocation transformZoomed
                (Point.add currentCenterPoint aroundPointDiff)
    in
    setScene { center = newCenter, zoom = newZoom } state


{-| -}
center : Config msg -> Location -> Float -> State
center config initialCenter initialZoom =
    defaultState
        |> setCenter config initialCenter
        |> setZoom config initialZoom


{-| -}
getScene : State -> Scene
getScene (State { scene }) =
    scene
