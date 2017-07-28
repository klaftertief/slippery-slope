module SlippyMap.Map.Transform
    exposing
        ( Transform
        , locationToPoint
        , locationToScreenPoint
        , pointToLocation
        , screenPointToLocation
        , transform
        )

{-| TODO: Maybe rename module to `ViewState`?

@docs Transform, locationToPoint, locationToScreenPoint, pointToLocation, transform, screenPointToLocation

-}

import SlippyMap.Geo.CRS as CRS exposing (CRS)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Map.Config as Config exposing (Config)
import SlippyMap.Map.Types as Types exposing (Scene)


{-| -}
type alias Transform =
    { size : Point
    , crs : CRS
    , center : Location
    , zoom : Float
    }


{-| -}
transform : Config msg -> Scene -> Transform
transform (Config.Config { crs, size }) { center, zoom } =
    { size = size
    , crs = crs
    , center = center
    , zoom = zoom
    }


{-| -}
origin : Transform -> Point
origin transform =
    Point.subtract
        (Point.divideBy 2 transform.size)
        (locationToPoint transform transform.center)


{-| -}
locationToPoint : Transform -> Location -> Point
locationToPoint transform location =
    transform.crs.locationToPoint transform.zoom location


{-| -}
locationToPointRelativeTo : Transform -> Point -> Location -> Point
locationToPointRelativeTo transform originPoint location =
    Point.subtract
        originPoint
        (locationToPoint transform location)


{-| -}
locationToScreenPoint : Transform -> Location -> Point
locationToScreenPoint transform location =
    locationToPointRelativeTo transform
        (origin transform)
        location


{-| -}
pointToLocation : Transform -> Point -> Location
pointToLocation transform point =
    transform.crs.pointToLocation transform.zoom point


{-| -}
screenPointToLocation : Transform -> Point -> Location
screenPointToLocation transform point =
    transform.crs.pointToLocation transform.zoom
        (Point.add (origin transform) point)
