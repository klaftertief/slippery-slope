module Remote exposing (..)

import Html
import Map.Tile as Tile exposing (Tile)
import SlippyMap
import Svg exposing (Svg)
import Svg.Attributes


main : Program Never SlippyMap.Model SlippyMap.Msg
main =
    Html.program
        { init = SlippyMap.init
        , view = SlippyMap.view
        , update = SlippyMap.update
        , subscriptions = always Sub.none
        }
