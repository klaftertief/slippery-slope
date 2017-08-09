module SlippyMap.Map.State
    exposing
        ( State(..)
        , center
        , defaultState
        , moveBy
        , moveTo
        , setCenter
        , setFocus
        , setInteraction
        , setScene
        , setZoom
        , tickTransition
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
import Time exposing (Time)


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


setTransition : Transition -> State -> State
setTransition newTransition (State state) =
    State
        { state | transition = newTransition }


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
            withPinch config pinch state

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


withPinch : Config msg -> Pinch -> State -> State
withPinch ((Config.Config { crs, size }) as config) { last, current } ((State { scene }) as state) =
    let
        toPoint position =
            { x = toFloat position.x
            , y = toFloat position.y
            }

        centerPoint ( pos1, pos2 ) =
            Point.center
                (toPoint pos1)
                (toPoint pos2)

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
            size
                |> Point.divideBy 2
                |> Point.add lastCenter
                |> Point.subtract currentCenter

        zoomDelta =
            crs.zoom (crs.scale 0 * currentDistance / lastDistance)
    in
    state
        |> moveTo config newCenterPoint
        -- |> zoomByAround config zoomDelta currentCenter
        |> setZoom config (scene.zoom + zoomDelta)


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


moveBy : Config msg -> Point -> State -> State
moveBy ((Config.Config { size }) as config) offset state =
    let
        newCenterPoint =
            size
                |> Point.divideBy 2
                |> Point.add offset
    in
    moveTo config newCenterPoint state


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
        -- setScene
        --     { scene | zoom = clamp minZoom maxZoom newZoom }
        --     state
        setTransition
            (MoveTo
                { scene =
                    { scene
                        | zoom =
                            clamp minZoom maxZoom newZoom
                    }
                , duration = 500
                , elapsed = 0
                }
            )
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


tickTransition : Time -> State -> State
tickTransition diff ((State { transition, scene }) as state) =
    case transition of
        MoveTo target ->
            let
                targetScene =
                    target.scene

                newElapsed =
                    target.elapsed + diff

                progress =
                    clamp 0 1 (newElapsed / target.duration)

                newScene =
                    { scene
                        | zoom =
                            scene.zoom
                                + (targetScene.zoom - scene.zoom)
                                * progress
                    }

                newTransition =
                    if progress >= 1 then
                        NoTransition
                    else
                        MoveTo
                            { target
                                | elapsed = newElapsed
                            }
            in
            state
                |> setScene newScene
                |> setTransition newTransition

        NoTransition ->
            state
