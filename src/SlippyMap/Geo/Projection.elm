module SlippyMap.Geo.Projection exposing (Projection)

{-| Projecting geographical coordinates of the world onto a flat surface (and back). See [Map projection](http://en.wikipedia.org/wiki/Map_projection).

@docs Projection

-}

import SlippyMap.Geo.Location exposing (Location)
import SlippyMap.Geo.Point exposing (Point)


{-| -}
type alias Projection =
    { project : Location -> Point
    , unproject : Point -> Location
    }
