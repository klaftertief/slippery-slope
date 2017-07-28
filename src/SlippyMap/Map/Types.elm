module SlippyMap.Map.Types
    exposing
        ( Drag
        , Focus(..)
        , Interaction(..)
        , Pinch
        , Scene
        , Transition(..)
        )

{-|

@docs State

-}

import Mouse exposing (Position)
import SlippyMap.Geo.Location as Location exposing (Location)
import Time exposing (Time)


type alias Scene =
    { center : Location
    , zoom : Float
    }


type Transition
    = NoTransition
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
