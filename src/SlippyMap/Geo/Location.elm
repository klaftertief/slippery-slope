module SlippyMap.Geo.Location exposing (Bounds, Location, bounds, boundsAreOverlapping, center, isInsideBounds, maybeBounds, wrap)

{-| Geographical coordinates

@docs Location, Bounds, center, wrap, bounds, maybeBounds, isInsideBounds, boundsAreOverlapping

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


singletonBounds : Location -> Bounds
singletonBounds location =
    Bounds location location


{-| -}
maybeBounds : List Location -> Maybe Bounds
maybeBounds locations =
    case locations of
        [] ->
            Nothing

        first :: rest ->
            Just <| bounds first rest


{-| -}
bounds : Location -> List Location -> Bounds
bounds first rest =
    List.foldr extend (singletonBounds first) rest


{-| -}
extend : Location -> Bounds -> Bounds
extend { lon, lat } { southWest, northEast } =
    { southWest =
        { lon = min southWest.lon lon
        , lat = min southWest.lat lat
        }
    , northEast =
        { lon = max northEast.lon lon
        , lat = max northEast.lat lat
        }
    }


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
