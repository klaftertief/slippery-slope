module Static exposing (..)

import Map.Tile as Tile exposing (Tile)
import RemoteData exposing (WebData, RemoteData(..))
import SlippyMap
import Svg exposing (Svg)
import Svg.Attributes


main : Svg msg
main =
    SlippyMap.staticMap
        [ SlippyMap.size ( 360, 360 )
        , SlippyMap.center ( 7, 51 )
        , SlippyMap.zoom 4
        ]
        --[ SlippyMap.staticTiles renderStaticTile
        [ SlippyMap.remoteTiles
            { load = always NotAsked
            , render = renderRemoteTile
            }
        ]


renderStaticTile : Tile -> Svg msg
renderStaticTile { z, x, y } =
    Svg.image
        [ Svg.Attributes.xlinkHref
            ("//a.tile.openstreetmap.org/"
                ++ toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
                ++ ".png"
            )
        ]
        []


renderRemoteTile : WebData String -> Svg msg
renderRemoteTile webdata =
    Svg.text_
        [ Svg.Attributes.x "10"
        , Svg.Attributes.y "20"
        ]
        [ case webdata of
            NotAsked ->
                Svg.text "Initialising..."

            Loading ->
                Svg.text "Loading..."

            Failure err ->
                Svg.text ("Error: " ++ toString err)

            Success url ->
                --renderStaticTile tile
                Svg.text ("Loaded: " ++ url)
        ]
