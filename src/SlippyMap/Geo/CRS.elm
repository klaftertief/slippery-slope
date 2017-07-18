module SlippyMap.Geo.CRS exposing (CRS)

{-| Coordinate Reference System
-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Projection as Projection exposing (Projection)
import SlippyMap.Geometry.Transformation as Transformation exposing (Transformation)


type alias CRS =
    { locationToPoint : Float -> Location -> Point
    , pointToLocation : Float -> Point -> Location
    , project : Location -> Point
    , unproject : Point -> Location
    , scale : Float -> Float
    , zoom : Float -> Float
    , distance : Location -> Location -> Float
    , code : String
    }



--crs : Transformation -> Projection -> CRS
--crs transformation projection =
--    {}
