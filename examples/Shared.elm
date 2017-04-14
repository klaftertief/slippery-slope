module Shared exposing (..)

import SlippyMap.Geo.Transform as Transform exposing (Transform)


transform : Transform
transform =
    { tileSize = 256
    , minZoom = 0
    , maxZoom = 20
    , width = 600
    , height = 400
    , center = { lon = 7, lat = 51 }
    , zoom = 6
    , bearing = 0
    }
