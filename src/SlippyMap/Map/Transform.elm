module SlippyMap.Map.Transform
    exposing
        ( Transform
        , Transformer
        , locationToPoint
        , locationToScreenPoint
        , origin
        , pointToLocation
        , scaleT
        , scaleZ
        , screenPointToLocation
        , tileCover
        , transform
        , transformer
        , zoom
        )

{-|

@docs Transform, Transformer, locationToPoint, locationToScreenPoint, pointToLocation, transform, transformer, screenPointToLocation, origin, tileCover, scaleT, scaleZ, zoom

-}

import SlippyMap.Geo.CRS exposing (CRS)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Map.Types exposing (Scene)


{-| -}
type Transform
    = Transform
        { size : Point
        , crs : CRS
        , center : Location
        , zoom : Float
        }


{-| -}
transform : CRS -> Point -> Scene -> Transform
transform crs size { center, zoom } =
    Transform
        { size = size
        , crs = crs
        , center = center
        , zoom = zoom
        }


{-| -}
type alias Transformer =
    { origin : Point
    , bounds : ( Point, Point )
    , scaleT : Float -> Float
    , scaleZ : Float -> Float
    , locationToPoint : Location -> Point
    , locationToPointRelativeTo : Point -> Location -> Point
    , locationToScreenPoint : Location -> Point
    , pointToLocation : Point -> Location
    , screenPointToLocation : Point -> Location
    , tileCover : List Tile
    }


{-| -}
transformer : CRS -> Point -> Scene -> Transformer
transformer crs size scene =
    let
        t =
            transform crs size scene
    in
    { origin = origin t
    , bounds = bounds t
    , scaleT = scaleT t
    , scaleZ = scaleZ t
    , locationToPoint = locationToPoint t
    , locationToPointRelativeTo = locationToPointRelativeTo t
    , locationToScreenPoint = locationToScreenPoint t
    , pointToLocation = pointToLocation t
    , screenPointToLocation = screenPointToLocation t
    , tileCover = tileCover t
    }


size : Transform -> Point
size (Transform transform) =
    transform.size


crs : Transform -> CRS
crs (Transform transform) =
    transform.crs


center : Transform -> Location
center (Transform transform) =
    transform.center


{-| -}
zoom : Transform -> Float
zoom (Transform transform) =
    transform.zoom


{-| -}
origin : Transform -> Point
origin transform =
    Point.subtract
        (Point.divideBy 2 <| size transform)
        (locationToPoint transform <| center transform)


{-| -}
bounds : Transform -> ( Point, Point )
bounds transform =
    let
        topLeft =
            origin transform
    in
    ( topLeft, Point.add (size transform) topLeft )


{-| -}
scaleT : Transform -> Float -> Float
scaleT transform z =
    .scale (crs transform)
        (zoom transform - z)


{-| -}
scaleZ : Transform -> Float -> Float
scaleZ transform z =
    .scale (crs transform) (zoom transform)
        / .scale (crs transform) z


{-| -}
locationToPoint : Transform -> Location -> Point
locationToPoint (Transform transform) location =
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
pointToLocation (Transform transform) point =
    transform.crs.pointToLocation transform.zoom point


{-| -}
screenPointToLocation : Transform -> Point -> Location
screenPointToLocation transform point =
    .pointToLocation (crs transform)
        (zoom transform)
        (Point.add (origin transform) point)


{-| -}
tileCover : Transform -> List Tile
tileCover transform =
    let
        rootTile =
            { z = 0, x = 0, y = 0 }
    in
    (rootTile :: tileCoverHelp transform rootTile)
        -- |> List.sortBy .z
        |> List.filter
            (\{ z } ->
                (z == 0)
                    || (z == floor (zoom transform))
                    || (z == floor (zoom transform - 1))
            )


tileCoverHelp : Transform -> Tile -> List Tile
tileCoverHelp transform parentTile =
    if zoom transform <= toFloat parentTile.z then
        []
    else
        let
            visibleChildren =
                Tile.children parentTile
                    |> List.filterMap
                        (\tile ->
                            if isVisible transform tile then
                                Just tile
                            else
                                Nothing
                        )
        in
        visibleChildren
            ++ List.concatMap (tileCoverHelp transform)
                visibleChildren


isVisible : Transform -> Tile -> Bool
isVisible transform tile =
    let
        scale =
            .scale (crs transform)
                (zoom transform - toFloat tile.z)

        originPoint =
            origin transform

        locationBounds =
            bounds transform
                |> (\( topLeft, bottomRight ) ->
                        { southWest =
                            screenPointToLocation transform
                                { x = topLeft.x
                                , y = bottomRight.y
                                }
                        , northEast =
                            screenPointToLocation transform
                                { x = bottomRight.x
                                , y = topLeft.y
                                }
                        }
                   )

        toLocation ( x, y ) =
            { x = toFloat x
            , y = toFloat y
            }
                |> Point.multiplyBy scale
                -- |> Point.subtract originPoint
                |> screenPointToLocation transform

        tileLocationBounds =
            { southWest =
                toLocation ( tile.x, tile.y + 1 )
            , northEast =
                toLocation ( tile.x + 1, tile.y )
            }
    in
    Location.boundsAreOverlapping locationBounds
        tileLocationBounds
