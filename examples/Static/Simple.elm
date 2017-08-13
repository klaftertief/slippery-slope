module Static.Simple exposing (viewAround, viewAt)

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Static as Map


viewAt : Html msg
viewAt =
    Map.at { width = 600, height = 400 }
        { center = Location 0 0
        , zoom = 2
        }
        [ Map.tileLayer ]


viewAround : Html msg
viewAround =
    Map.around { width = 600, height = 400 }
        { southWest = Location 6 35
        , northEast = Location 19 48
        }
        [ Map.tileLayer ]
