module Geo.Transform exposing (..)

import Geo.Coordinate as Coordinate exposing (Coordinate)
import Geo.Location as Location exposing (Location)
import Geo.PixelPoint as PixelPoint exposing (PixelPoint)
import Geo.Point as Point exposing (Point)
import Geo.Mercator as Mercator


type alias State =
    { tileSize : Int
    , minZoom : Float
    , maxZoom : Float
    , width : Float
    , height : Float
    , center : Location
    , zoom : Float
    , bearing : Float
    }


locationToPixelPoint : State -> Location -> PixelPoint
locationToPixelPoint state location =
    locationToCoordinate state location
        |> coordinateToPixelPoint state


pixelPointToLocation : State -> PixelPoint -> Location
pixelPointToLocation state point =
    pixelPointToCoordinate state point
        |> coordinateToLocation state


{-| Converts given location in WGS84 Datum to a Coordinate.

    >>> locationToCoordinate testState { lon = 6.96, lat = 50.94 }
    { column = 8508.757333333333
    , row = 5489.3311249
    , zoom = 14
    }
-}
locationToCoordinate : State -> Location -> Coordinate
locationToCoordinate state location =
    Mercator.project location
        |> mercatorPointToCoordinate state


coordinateToLocation : State -> Coordinate -> Location
coordinateToLocation state coordinate =
    coordinateToMercatorPoint state coordinate
        |> Mercator.unproject


pixelPointToCoordinate : State -> PixelPoint -> Coordinate
pixelPointToCoordinate state { x, y } =
    let
        scale =
            toFloat state.tileSize
    in
        { column = toFloat x / scale
        , row = toFloat y / scale
        , zoom = state.zoom
        }


coordinateToPixelPoint : State -> Coordinate -> PixelPoint
coordinateToPixelPoint state coordinate =
    let
        { column, row, zoom } =
            Coordinate.zoomTo state.zoom coordinate

        scale =
            toFloat state.tileSize
    in
        { x = column * scale |> floor
        , y = row * scale |> floor
        }


{-| Converts a EPSG:900913 point in radians to pyramid pixel coordinates for a given transform state.
-}
mercatorPointToCoordinate : State -> Point -> Coordinate
mercatorPointToCoordinate state =
    mercatorPointToRelativePoint >> relativePointToCoordinate state


{-| Converts pyramid pixel coordinates with given zoom level to EPSG:900913 in normalized radians.
-}
coordinateToMercatorPoint : State -> Coordinate -> Point
coordinateToMercatorPoint state =
    coordinateToRelativePoint state >> relativePointToMercatorPoint


coordinateToRelativePoint : State -> Coordinate -> Point
coordinateToRelativePoint state coordinate =
    let
        { column, row, zoom } =
            Coordinate.zoomTo state.zoom coordinate

        scale =
            zoomScale zoom
    in
        { x = column / scale
        , y = row / scale
        }


relativePointToCoordinate : State -> Point -> Coordinate
relativePointToCoordinate { zoom } { x, y } =
    let
        scale =
            zoomScale zoom
    in
        { column = x * scale
        , row = y * scale
        , zoom = zoom
        }


mercatorPointToRelativePoint : Point -> Point
mercatorPointToRelativePoint { x, y } =
    { x = (1 + x / pi) / 2
    , y = (1 - y / pi) / 2
    }


relativePointToMercatorPoint : Point -> Point
relativePointToMercatorPoint { x, y } =
    { x = (x * 2 - 1) * pi
    , y = -(y * 2 - 1) * pi
    }


tileZoom : State -> Float
tileZoom =
    .zoom >> floor >> toFloat


zoomScale : Float -> Float
zoomScale zoom =
    2 ^ zoom


testState : State
testState =
    { tileSize = 256
    , minZoom = 0
    , maxZoom = 20
    , width = 600
    , height = 400
    , center = { lon = 0, lat = 0 }
    , zoom = 14
    , bearing = 0
    }
