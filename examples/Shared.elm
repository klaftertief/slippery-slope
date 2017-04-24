module Shared exposing (..)

import SlippyMap.Geo.Transform as Transform exposing (Transform)


transform : Transform
transform =
    { tileSize = 256
    , width = 600
    , height = 400
    , center = { lon = 6.9, lat = 50.9 }
    , zoom = 10
    }
