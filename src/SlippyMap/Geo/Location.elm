module SlippyMap.Geo.Location
    exposing
        ( Bounds
        , Location
        , betweenAt
        , bounds
        , boundsAreOverlapping
        , center
        , isInsideBounds
        , maybeBounds
        , wrap
        )

{-| Geographical coordinates

@docs Location, Bounds, center, wrap, bounds, maybeBounds, isInsideBounds, boundsAreOverlapping, betweenAt

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


{-| -}
betweenAt : Location -> Location -> Float -> Location
betweenAt from to fraction =
    let
        delta =
            distance from to

        a =
            sin ((1 - fraction) * delta) / sin delta

        b =
            sin (fraction * delta) / sin delta

        phi1 =
            degreesToRadians from.lat

        phi2 =
            degreesToRadians to.lat

        lambda1 =
            degreesToRadians from.lon

        lamda2 =
            degreesToRadians to.lon

        x =
            a * cos phi1 * cos lambda1 + b * cos phi2 * cos lamda2

        y =
            a * cos phi1 * sin lambda1 + b * cos phi2 * sin lamda2

        z =
            a * sin phi1 + b * sin phi2

        lati =
            atan2 z (sqrt (x ^ 2 + y ^ 2))

        loni =
            atan2 y x
    in
    { lon =
        -- floatMod (radiansToDegrees lamda3 + 540) 360 - 180
        radiansToDegrees loni
    , lat = radiansToDegrees lati
    }


distance : Location -> Location -> Float
distance from to =
    let
        phi1 =
            degreesToRadians from.lat

        phi2 =
            degreesToRadians to.lat

        lambda1 =
            degreesToRadians from.lon

        lamda2 =
            degreesToRadians to.lon

        deltaLat =
            phi2 - phi1

        deltaLon =
            lamda2 - lambda1

        a =
            sin (deltaLat / 2)
                * sin (deltaLat / 2)
                + cos phi1
                * cos phi2
                * sin (deltaLon / 2)
                * sin (deltaLon / 2)
    in
    2 * atan2 (sqrt a) (sqrt (1 - a))


degreesToRadians : Float -> Float
degreesToRadians deg =
    deg * pi / 180


radiansToDegrees : Float -> Float
radiansToDegrees rad =
    rad * 180 / pi


floatMod : Float -> Float -> Float
floatMod a b =
    a - (b * (toFloat << floor) (a / b))
