module SlippyMap.Geo.Mercator exposing (..)

{-| Mercator
@docs degreesToRadians, latToY, lonToX, project, radiansToDegrees, unproject, xToLon, yToLat
-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)


{-| Converts given location in WGS84 Datum to a XY Point in radians from Spherical Mercator EPSG:900913.

    project { lon = 6.96, lat = 50.94 }
    --> { x = 0.12147491593880534, y = 1.0364605326049743 }

-}
project : Location -> Point
project { lon, lat } =
    { x = lonToX lon
    , y = latToY lat
    }


{-| Converts given point in radians from Spherical Mercator EPSG:900913WGS84 Datum to a location in in WGS84 Datum.

    unproject { x = 0.12147491593880534, y = 1.0364605326049743 }
    --> { lon = 6.96, lat = 50.93999999999998 }

-}
unproject : Point -> Location
unproject { x, y } =
    { lon = xToLon x
    , lat = yToLat y
    }


{-| Converts given longitude in WGS84 Datum to radians from Spherical Mercator EPSG:900913.

    lonToX 0 --> 0

    lonToX 180 --> pi

    lonToX -180 --> -pi

-}
lonToX : Float -> Float
lonToX =
    degreesToRadians


{-| Converts given latitude in WGS84 Datum to radians from Spherical Mercator EPSG:900913.
-}
latToY : Float -> Float
latToY lat =
    tan (pi / 4 + degreesToRadians lat / 2)
        |> logBase e


{-| Converts radians from Spherical Mercator EPSG:900913 to longitude in WGS84 Datum.

    xToLon 0 --> 0

    xToLon pi --> 180

-}
xToLon : Float -> Float
xToLon =
    radiansToDegrees


{-| Converts radians from Spherical Mercator EPSG:900913 to latitude in WGS84 Datum.

    yToLat pi --> 85.05112877980659

-}
yToLat : Float -> Float
yToLat y =
    radiansToDegrees (2 * atan (e ^ y) - pi / 2)


{-| Converts angles in degrees to radians.

    degreesToRadians 0 --> 0

    degreesToRadians 180 --> pi

-}
degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * pi / 180


{-| Converts angles in degrees to radians.

    radiansToDegrees 0 --> 0

    radiansToDegrees pi --> 180

-}
radiansToDegrees : Float -> Float
radiansToDegrees rad =
    rad * 180 / pi
