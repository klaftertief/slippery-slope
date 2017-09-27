module SlippyMap.Geo.Projection.SphericalMercator exposing (project, projection, radius, unproject)

{-| Spherical Mercator projection — the most common projection for online maps, used by almost all free and commercial tile providers. Assumes that Earth is a sphere. Used by the `EPSG:3857` CRS.

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
        degreesToRadians lon * radius
    , y =
        tan (pi / 4 + degreesToRadians (clamp -maxLatitude maxLatitude lat) / 2)
            |> logBase e
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
    { lon =
        radiansToDegrees x / radius
    , lat =
        radiansToDegrees (2 * atan (e ^ (y / radius)) - pi / 2)
    }


{-| -}
radius : Float
radius =
    6378137


maxLatitude : Float
maxLatitude =
    85.0511287798


degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * pi / 180


radiansToDegrees : Float -> Float
radiansToDegrees rad =
    rad * 180 / pi
