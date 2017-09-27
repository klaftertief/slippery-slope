module SlippyMap.Geo.Projection.Stereographic exposing (project, projection, radius, unproject)

{-| Stereographic

@docs project, projection, radius, unproject

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Projection as Projection exposing (Projection)


{-| -}
projection : Projection
projection =
    { project = project
    , unproject = unproject
    }


{-| Project

    project { lon = 0, lat = 0 }
    --> { x = 0, y = 0 }

    project { lon = 180, lat = 85.0511287798 }
    --> { x = 20037508, y = 20037508 }

-}
project : Location -> Point
project { lon, lat } =
    { x =
        cos (degreesToRadians lat) * sin (degreesToRadians lon) / (1 + cos (degreesToRadians lon) * cos (degreesToRadians lat)) |> (*) radius
    , y =
        sin (degreesToRadians lat)
            / (1 + cos (degreesToRadians lon) * cos (degreesToRadians lat))
            |> (*) radius
    }


{-| Unproject

    unproject { x = 0, y = 0 }
    --> { lon = 0, lat = 0 }

    unproject { x = 20037508, y = 20037508 }
    --> { lon = 180, lat = 85.0511287798 }

-}
unproject : Point -> Location
unproject { x, y } =
    let
        z =
            sqrt ((x / radius) ^ 2 + (y / radius) ^ 2)

        c =
            2 * atan z

        sinC =
            sin c

        cosC =
            cos c
    in
    { lon =
        radiansToDegrees (atan2 ((x / radius) * sinC) (z * cosC))
    , lat =
        if z == 0 then
            0
        else
            radiansToDegrees (asin ((y / radius) * sinC / z))
    }


{-| -}
radius : Float
radius =
    6378137


degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * pi / 180


radiansToDegrees : Float -> Float
radiansToDegrees rad =
    rad * 180 / pi
