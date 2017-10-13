module SlippyMap.Geo.Coordinate
    exposing
        ( Bounds
        , Coordinate
        , center
        , fromPoint
        , toPoint
        , zoomTo
        )

{-|

@docs Coordinate, Bounds, zoomTo, center, fromPoint, toPoint

-}

import SlippyMap.Geo.Point exposing (Point)


{-| -}
type alias Coordinate =
    { column : Float
    , row : Float
    , zoom : Float
    }


{-| -}
type alias Bounds =
    { topLeft : Coordinate
    , topRight : Coordinate
    , bottomRight : Coordinate
    , bottomLeft : Coordinate
    }


{-| -}
zoomTo : Float -> Coordinate -> Coordinate
zoomTo zoom coordinate =
    let
        scale =
            2 ^ (zoom - coordinate.zoom)
    in
    { column = coordinate.column * scale
    , row = coordinate.row * scale
    , zoom = zoom
    }


{-| -}
center : ( Coordinate, Coordinate ) -> Coordinate
center ( start, end ) =
    let
        endZoomed =
            zoomTo start.zoom end
    in
    { column = (start.column + endZoomed.column) / 2
    , row = (start.row + endZoomed.row) / 2
    , zoom = start.zoom
    }


{-| -}
fromPoint : Int -> Float -> Point -> Coordinate
fromPoint tileSize atZoom { x, y } =
    let
        scale =
            toFloat tileSize
    in
    { column = x / scale
    , row = y / scale
    , zoom = atZoom
    }


{-| -}
toPoint : Int -> Float -> Coordinate -> Point
toPoint tileSize atZoom coordinate =
    let
        { column, row } =
            zoomTo atZoom coordinate

        scale =
            toFloat tileSize
    in
    { x = column * scale
    , y = row * scale
    }
