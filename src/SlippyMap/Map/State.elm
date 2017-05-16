module SlippyMap.Map.State
    exposing
        ( State(..)
        , Drag
        , Focus(..)
        , center
        , getTransform
        , withDragTransform
        , getCoordinateBounds
        , getTileCover
        , setTransform
        , setDrag
        , setFocus
        , zoomIn
        , zoomOut
        , zoomToAround
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
TODO: Do not have full Transfrom as the State?
Have a function `toTransform : Config msg -> State -> Transform`.
TODO: Add type alias for internal record
-}
type State
    = State
        { transform : Transform
        , drag : Maybe Drag
        , focus : Focus
        }


type alias Drag =
    { last : Position
    , current : Position
    }


type Focus
    = HasFocus
    | HasNoFocus


defaultState : State
defaultState =
    State
        { transform = defaultTransform
        , drag = Nothing
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
    zoomToAround 1


zoomToAround : Float -> Point -> State -> State
zoomToAround delta point ((State { transform }) as state) =
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
