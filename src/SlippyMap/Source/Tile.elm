module SlippyMap.Source.Tile exposing (..)

import SlippyMap.Geo.Tile as Geo


type Tile a
    = Tile Geo.Tile a
