module SlippyMap.Geometry.Transformation exposing (Transformation, transform, untransform)

{-| Affine transformations.

@docs Transformation, transform, untransform

-}

import SlippyMap.Geo.Point as Point exposing (Point)


{-| -}
type alias Transformation =
    { a : Float
    , b : Float
    , c : Float
    , d : Float
    }


{-| -}
transform : Transformation -> Point -> Point
transform { a, b, c, d } { x, y } =
    { x = a * x + b
    , y = c * y + d
    }


{-| -}
untransform : Transformation -> Point -> Point
untransform { a, b, c, d } { x, y } =
    { x = (x - b) / a
    , y = (y - d) / c
    }
