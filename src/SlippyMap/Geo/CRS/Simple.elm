module SlippyMap.Geo.CRS.Simple exposing (..)

{-| A simple CRS that maps longitude and latitude into `x` and `y` directly. May be used for maps of flat surfaces (e.g. game maps). Note that the `y` axis should still be inverted (going from bottom to top). `distance()` returns simple euclidean distance.
-}

import SlippyMap.Geo.CRS exposing (CRS)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Projection.PlateCarree as Projection
import SlippyMap.Geometry.Transformation as Transformation exposing (Transformation)


crs : CRS
crs =
    { locationToPoint = locationToPoint
    , pointToLocation = pointToLocation
    , project = project
    , unproject = unproject
    , scale = scale
    , zoom = zoom
    , distance = distance
    , code = code
    }


transformation : Transformation
transformation =
    Transformation 1 0 -1 0


locationToPoint : Float -> Location -> Point
locationToPoint zoom location =
    location
        |> project
        |> Transformation.transform transformation


pointToLocation : Float -> Point -> Location
pointToLocation zoom point =
    point
        |> Transformation.untransform transformation
        |> unproject


project : Location -> Point
project =
    Projection.project


unproject : Point -> Location
unproject =
    Projection.unproject


scale : Float -> Float
scale zoom =
    2 ^ zoom


zoom : Float -> Float
zoom scale =
    logBase e scale / logBase e 2


distance : Location -> Location -> Float
distance from to =
    let
        deltaLon =
            to.lon - from.lon

        deltaLat =
            to.lat - from.lat
    in
    sqrt (deltaLon ^ 2 + deltaLat ^ 2)


code : String
code =
    "NONE"
