module SlippyMap.Geo.Projection.PlateCarree exposing (project, projection, unproject)

{-| Equirectangular, or Plate Carree projection — the most simple projection, mostly used by GIS enthusiasts. Directly maps `x` as longitude, and `y` as latitude. Also suitable for flat worlds, e.g. game maps. Used by the `EPSG:4326` and `Simple` CRS.

@docs project, projection, unproject

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

-}
project : Location -> Point
project { lon, lat } =
    { x = lon
    , y = lat
    }


{-| Unproject

    unproject { x = 0, y = 0 }
    --> { lon = 0, lat = 0 }

-}
unproject : Point -> Location
unproject { x, y } =
    { lon = x
    , lat = y
    }
