module SlippyMap.Map.State
    exposing
        ( State(..)
        , around
        , at
        , defaultState
        , fitBounds
        , moveBy
        , moveByAnimated
        , moveTo
        , setCenter
        , setFocus
        , setInteraction
        , setScene
        , setTransition
        , setZoom
        , tickTransition
        , withInteraction
        , zoomByAround
        , zoomIn
        , zoomInAround
        , zoomOut
        )

{-|

@docs State, at, around, defaultState, fitBounds, moveBy, moveTo, setCenter, setFocus, setInteraction, setTransition, setScene, setZoom, tickTransition, withInteraction, zoomByAround, zoomIn, zoomInAround, zoomOut, moveByAnimated

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


{-| -}
defaultState : State
defaultState =
    State
        { scene = defaultScene
        , transition = NoTransition
        , interaction = NoInteraction
        , focus = HasNoFocus
        }



-- CONSTRUCTORS


{-| -}
at : Config msg -> Scene -> State
at config initialScene =
    setScene initialScene defaultState


{-| -}
around : Config msg -> Location.Bounds -> State
around config initialBounds =
    fitBounds config initialBounds defaultState


{-| -}
setScene : Scene -> State -> State
setScene newScene (State state) =
    State
        { state | scene = newScene }


{-| -}
setTransition : Transition -> State -> State
setTransition newTransition (State state) =
    State
        { state | transition = newTransition }


{-| -}
setInteraction : Interaction -> State -> State
setInteraction newInteraction (State state) =
    State
        { state | interaction = newInteraction }


{-| -}
setFocus : Focus -> State -> State
setFocus newFocus (State state) =
    State
        { state | focus = newFocus }


defaultScene : Scene
defaultScene =
    { center = Location 0 0
    , zoom = 0
    }


{-| -}
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


{-| -}
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


{-| -}
moveBy : Config msg -> Point -> State -> State
moveBy ((Config.Config { size }) as config) offset state =
    let
        newCenterPoint =
            size
                |> Point.divideBy 2
                |> Point.add offset
    in
    moveTo config newCenterPoint state


{-| -}
moveByAnimated : Config msg -> Point -> State -> State
moveByAnimated ((Config.Config { size }) as config) offset ((State { scene }) as state) =
    let
        newCenterPoint =
            size
                |> Point.divideBy 2
                |> Point.add offset

        transform =
            Transform.transform config scene

        newCenter =
            Transform.screenPointToLocation transform
                newCenterPoint
    in
    setTransition
        (MoveTo
            { fromScene = scene
            , toScene =
                { scene | center = newCenter }
            , duration = 400
            , elapsed = 0
            }
        )
        state


{-| -}
setCenter : Config msg -> Location -> State -> State
setCenter config newCenter ((State { scene }) as state) =
    -- setTransition
    --     (MoveTo
    --         { fromScene = scene
    --         , toScene =
    --             { scene | center = newCenter }
    --         , duration = 200
    --         , elapsed = 0
    --         }
    --     )
    --     state
    setScene
        { scene | center = newCenter }
        state


{-| -}
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
                { fromScene = scene
                , toScene =
                    { scene
                        | zoom =
                            clamp minZoom maxZoom newZoom
                    }
                , duration = 200
                , elapsed = 0
                }
            )
            state


{-| -}
zoomIn : Config msg -> State -> State
zoomIn ((Config.Config { zoomDelta }) as config) ((State { scene }) as state) =
    setZoom config (scene.zoom + zoomDelta) state


{-| -}
zoomOut : Config msg -> State -> State
zoomOut ((Config.Config { zoomDelta }) as config) ((State { scene }) as state) =
    setZoom config (scene.zoom - zoomDelta) state


{-| -}
zoomInAround : Config msg -> Point -> State -> State
zoomInAround ((Config.Config { zoomDelta }) as config) =
    zoomByAround config zoomDelta


{-| -}
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
    setScene
        { center = newCenter
        , zoom = newZoom
        }
        state


{-| -}
fitBounds : Config msg -> Location.Bounds -> State -> State
fitBounds ((Config.Config { crs, size, zoomSnap, minZoom, maxZoom }) as config) { southWest, northEast } (State { scene }) =
    let
        transform =
            Transform.transform config
                -- scene
                { center = Location 0 0
                , zoom = 0
                }

        southWestPoint =
            Transform.locationToPoint transform southWest

        northEastPoint =
            Transform.locationToPoint transform northEast

        boundsSize =
            Point.subtract
                { x = southWestPoint.x, y = northEastPoint.y }
                { x = northEastPoint.x, y = southWestPoint.y }

        scale =
            min
                (size.x / boundsSize.x)
                (size.y / boundsSize.y)

        zoom =
            crs.zoom (crs.scale 0 * scale)

        zoomSnapped =
            clamp minZoom maxZoom <|
                if zoomSnap == 0 then
                    zoom
                else
                    toFloat (floor (zoom / zoomSnap)) * zoomSnap

        center =
            Point.center
                southWestPoint
                northEastPoint
                |> Transform.pointToLocation transform
    in
    setScene
        { center = center
        , zoom = zoomSnapped
        }
        defaultState


{-| -}
getScene : State -> Scene
getScene (State { scene }) =
    scene


{-| -}
tickTransition : Time -> State -> State
tickTransition diff ((State { transition, scene }) as state) =
    case transition of
        MoveTo target ->
            let
                fromScene =
                    target.fromScene

                toScene =
                    target.toScene

                newElapsed =
                    target.elapsed + diff

                progress =
                    clamp 0 1 (newElapsed / target.duration)
                        |> (\time ->
                                1 - (1 - time) ^ 4
                           )

                newScene =
                    { scene
                        | zoom =
                            fromScene.zoom
                                + (toScene.zoom - fromScene.zoom)
                                * progress
                        , center =
                            { lon =
                                fromScene.center.lon
                                    + (toScene.center.lon - fromScene.center.lon)
                                    * progress
                            , lat =
                                fromScene.center.lat
                                    + (toScene.center.lat - fromScene.center.lat)
                                    * progress
                            }
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
