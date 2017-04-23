module Shared exposing (..)

import SlippyMap.Geo.Transform as Transform exposing (Transform)


transform : Transform
transform =
    { tileSize = 256
    , minZoom = 0
    , maxZoom = 20
    , width = 600
    , height = 400
    , center = { lon = 6.9, lat = 50.9 }

    --, center = { lon = 175.475, lat = -37.87 }
    , zoom = 10
    , bearing = 0
    }
