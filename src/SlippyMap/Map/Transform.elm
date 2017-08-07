module SlippyMap.Map.Transform
    exposing
        ( Transform
        , locationToPoint
        , locationToScreenPoint
        , origin
        , pointToLocation
        , screenPointToLocation
        , tileCover
        , transform
        )

{-| TODO: Maybe rename module to `ViewState`?

@docs Transform, locationToPoint, locationToScreenPoint, pointToLocation, transform, screenPointToLocation, origin, tileCover

-}

import SlippyMap.Geo.CRS as CRS exposing (CRS)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
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
bounds : Transform -> ( Point, Point )
bounds transform =
    let
        topLeft =
            origin transform
    in
    ( topLeft, Point.add transform.size topLeft )


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
                    || (z == floor transform.zoom)
                    || (z == floor (transform.zoom + 1))
            )


tileCoverHelp : Transform -> Tile -> List Tile
tileCoverHelp transform parentTile =
    if transform.zoom <= toFloat parentTile.z then
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
            transform.crs.scale
                (transform.zoom - toFloat tile.z)

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



-- |> Debug.log ("overlapping" ++ toString tile)
