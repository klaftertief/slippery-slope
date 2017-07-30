module SlippyMap.Geo.CRS exposing (CRS)

{-| Coordinate Reference System

@docs CRS

-}

import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)


{-| -}
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
