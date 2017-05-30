module SlippyMap.Map.State
    exposing
        ( State(..)
        , Drag
        , Pinch
        , Focus(..)
        , defaultState
        , center
        , getTransform
        , withDragTransform
        , withPinchTransform
        , getCoordinateBounds
        , getTileCover
        , setTransform
        , setDrag
        , setPinch
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
        , drag : Maybe Drag
        , pinch : Maybe Pinch
        , focus : Focus
        }


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
        , drag = Nothing
        , pinch = Nothing
        , focus = HasNoFocus
        }


setTransform : Transform -> State -> State
setTransform newTransform (State state) =
    State
        { state | transform = newTransform }


setDrag : Maybe Drag -> State -> State
setDrag newDrag (State state) =
    State
        { state | drag = newDrag }


setPinch : Maybe Pinch -> State -> State
setPinch newPinch (State state) =
    State
        { state | pinch = newPinch }


setFocus : Focus -> State -> State
setFocus newFocus (State state) =
    State
        { state | focus = newFocus }


defaultTransform : Transform
defaultTransform =
    { tileSize = 256
    , width = 600
    , height = 400
    , center = { lon = 0, lat = 0 }
    , zoom = 0
    }


withDragTransform : State -> State
withDragTransform ((State { transform, drag }) as state) =
    case drag of
        Nothing ->
            state

        Just { last, current } ->
            setTransform
                (Transform.moveTo transform
                    { x = transform.width / 2 + toFloat (last.x - current.x)
                    , y = transform.height / 2 + toFloat (last.y - current.y)
                    }
                )
                state


withPinchTransform : State -> State
withPinchTransform ((State { transform, pinch }) as state) =
    case pinch of
        Nothing ->
            state

        Just { last, current } ->
            let
                toPoint position =
                    { x = toFloat position.x
                    , y = toFloat position.y
                    }

                centerPoint ( pos1, pos2 ) =
                    Point.add
                        (toPoint pos1)
                        (toPoint pos1)
                        |> Point.divideBy 2

                distance ( pos1, pos2 ) =
                    Point.distance
                        (toPoint pos1)
                        (toPoint pos1)

                lastCenter =
                    centerPoint last

                lastDistance =
                    distance last

                currentCenter =
                    centerPoint current

                currentDistance =
                    distance current

                newCenter =
                    { x =
                        (transform.width / 2)
                            + lastCenter.x
                            - currentCenter.x
                    , y =
                        (transform.height / 2)
                            + lastCenter.y
                            - currentCenter.y
                    }

                newZoom =
                    Transform.scaleZoom
                        (currentDistance - lastDistance)
                        + transform.zoom
                        |> Debug.log "newZoom"
            in
                state
                    |> setTransform
                        (Transform.moveTo transform
                            newCenter
                        )
                    |> setZoom newZoom


setCenter : Location -> State -> State
setCenter newCenter ((State { transform }) as state) =
    setTransform { transform | center = newCenter } state


setZoom : Float -> State -> State
setZoom newZoom ((State { transform }) as state) =
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
    setTransform
        (Transform.zoomToAround transform
            (transform.zoom + delta)
            point
        )
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
