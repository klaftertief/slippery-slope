module SlippyMap.Geo.Location exposing (..)

{-| Geographical coordinates

@docs Location, Bounds, center, wrap, isInsideBounds, boundsAreOverlapping

-}


{-| -}
type alias Location =
    { lon : Float
    , lat : Float
    }


{-| -}
type alias Bounds =
    { southWest : Location
    , northEast : Location
    }


{-| -}
center : Bounds -> Location
center { southWest, northEast } =
    { lon = (southWest.lon + northEast.lon) / 2
    , lat = (southWest.lat + northEast.lat) / 2
    }


{-| -}
wrap : Location -> Location
wrap ({ lon } as location) =
    { location | lon = clamp -180 180 lon }


{-| -}
isInsideBounds : Bounds -> Location -> Bool
isInsideBounds { southWest, northEast } { lon, lat } =
    (lon > southWest.lon)
        && (lon < northEast.lon)
        && (lat > southWest.lat)
        && (lat < northEast.lat)


{-| -}
boundsAreOverlapping : Bounds -> Bounds -> Bool
boundsAreOverlapping b1 b2 =
    let
        southWest1 =
            b1.southWest

        northEast1 =
            b1.northEast

        southWest2 =
            b2.southWest

        northEast2 =
            b2.northEast

        lonOverlaps =
            (northEast2.lon > southWest1.lon) && (southWest2.lon < northEast1.lon)

        latOverlaps =
            (northEast2.lat > southWest1.lat) && (southWest2.lat < northEast1.lat)
    in
    latOverlaps && lonOverlaps
