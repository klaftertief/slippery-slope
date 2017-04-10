module Geo.Coordinate exposing (..)

{-| -}


type alias Coordinate =
    { column : Float
    , row : Float
    , zoom : Float
    }


type alias Bounds =
    { topLeft : Coordinate
    , topRight : Coordinate
    , bottomRight : Coordinate
    , bottomLeft : Coordinate
    }


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
