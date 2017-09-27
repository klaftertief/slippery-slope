module SlippyMap.Geo.Projection exposing (Projection)

{-| Projecting geographical coordinates of the world onto a flat surface (and back). See [Map projection](http://en.wikipedia.org/wiki/Map_projection).

@docs Projection

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)


{-| -}
type alias Projection =
    { project : Location -> Point
    , unproject : Point -> Location
    }
