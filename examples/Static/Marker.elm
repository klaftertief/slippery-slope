module Static.Marker exposing (main)

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Map.Types exposing (Size)
import SlippyMap.Static as Map


main : Html msg
main =
    Map.around size
        bounds
        [ Map.tileLayer ""
        , Map.markerLayer [ Location 14 42 ]
        ]


size : Size
size =
    { width = 600, height = 400 }


bounds : Location.Bounds
bounds =
    { southWest = Location 6 35
    , northEast = Location 19 48
    }
