module SlippyMap.Types
    exposing
        ( Drag
        , Focus(..)
        , Interaction(..)
        , Pinch
        , Scene
        , Size
        , Transition(..)
        )

{-|

@docs Drag, Focus, Interaction, Pinch, Scene, Size, Transition

-}

import Mouse exposing (Position)
import SlippyMap.Geo.Location exposing (Location)
import Time exposing (Time)


{-| -}
type alias Size =
    { width : Int
    , height : Int
    }


{-| TODO: Rename to Detail, Sector, View, Clipping or something similar
-}
type alias Scene =
    { center : Location
    , zoom : Float
    }


{-| -}
type Transition
    = NoTransition
    | MoveTo
        { fromScene : Scene
        , toScene : Scene
        , duration : Time
        , elapsed : Time
        }
    | FlyTo
        { fromScene : Scene
        , toScene : Scene
        , duration : Time
        , elapsed : Time
        }


{-| Supported interactions
-}
type Interaction
    = NoInteraction
    | Dragging Drag
    | Pinching Pinch


{-| -}
type alias Drag =
    { last : Position
    , current : Position
    }


{-| -}
type alias Pinch =
    { last : ( Position, Position )
    , current : ( Position, Position )
    }


{-| -}
type Focus
    = HasFocus
    | HasNoFocus
