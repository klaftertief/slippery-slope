module SlippyMap.Geo.Tile exposing (Comparable, Tile, children, cover, fromComparable, toComparable)

{-|

@docs Tile, Comparable, toComparable, fromComparable, cover, children

-}

import Set exposing (Set)
import SlippyMap.Geo.Coordinate as Coordinate exposing (Coordinate)


{-| -}
type alias Tile =
    { z : Int
    , x : Int
    , y : Int
    }


{-| -}
type alias Comparable =
    ( Int, Int, Int )


{-| -}
toComparable : Tile -> Comparable
toComparable { z, x, y } =
    ( z, x, y )


{-| -}
fromComparable : Comparable -> Tile
fromComparable ( z, x, y ) =
    { z = z, x = x, y = y }


coordinateToTile : Coordinate -> Tile
coordinateToTile { column, row, zoom } =
    { z = floor zoom
    , x = floor column
    , y = floor row
    }


normalize : Tile -> Tile
normalize { z, x, y } =
    { z = z
    , x = x % (2 ^ z)
    , y = y % (2 ^ z)
    }


{-| -}
children : Tile -> List Tile
children { z, x, y } =
    let
        newZ =
            z + 1

        newX =
            x * 2

        newY =
            y * 2
    in
    [ { z = newZ, x = newX, y = newY }
    , { z = newZ, x = newX + 1, y = newY }
    , { z = newZ, x = newX, y = newY + 1 }
    , { z = newZ, x = newX + 1, y = newY + 1 }
    ]


{-| -}
cover : Coordinate.Bounds -> List Tile
cover { topLeft, topRight, bottomRight, bottomLeft } =
    (triangleCover ( topLeft, topRight, bottomRight )
        ++ triangleCover ( topLeft, bottomLeft, bottomRight )
    )
        |> uniqueBy (\{ z, x, y } -> ( z, x, y ))


triangleCover : ( Coordinate, Coordinate, Coordinate ) -> List Tile
triangleCover ( c1, c2, c3 ) =
    let
        ( c1Tile, c2Tile, c3Tile ) =
            ( coordinateToTile c1
            , coordinateToTile c2
            , coordinateToTile c3
            )

        ( c1c2Center, c2c3Center, c3c1Center ) =
            ( Coordinate.center ( c1, c2 )
            , Coordinate.center ( c2, c3 )
            , Coordinate.center ( c3, c1 )
            )
    in
    if
        (c1Tile.x - c2Tile.x |> abs |> (>=) 1)
            && (c1Tile.y - c2Tile.y |> abs |> (>=) 1)
            && (c2Tile.x - c3Tile.x |> abs |> (>=) 1)
            && (c2Tile.y - c3Tile.y |> abs |> (>=) 1)
            && (c3Tile.x - c1Tile.x |> abs |> (>=) 1)
            && (c3Tile.y - c1Tile.y |> abs |> (>=) 1)
    then
        [ c1Tile, c2Tile, c3Tile ]
    else
        triangleCover ( c1c2Center, c2c3Center, c3c1Center )
            ++ triangleCover ( c1, c1c2Center, c3c1Center )
            ++ triangleCover ( c2, c2c3Center, c1c2Center )
            ++ triangleCover ( c3, c3c1Center, c2c3Center )


uniqueBy : (a -> comparable) -> List a -> List a
uniqueBy f list =
    uniqueHelp f Set.empty list


uniqueHelp : (a -> comparable) -> Set comparable -> List a -> List a
uniqueHelp f existing remaining =
    case remaining of
        [] ->
            []

        first :: rest ->
            let
                computedFirst =
                    f first
            in
            if Set.member computedFirst existing then
                uniqueHelp f existing rest
            else
                first :: uniqueHelp f (Set.insert computedFirst existing) rest
