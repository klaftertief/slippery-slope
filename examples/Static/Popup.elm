module Static.Popup exposing (main)

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Types exposing (Size)
import SlippyMap.Bundle.Static as Map


main : Html msg
main =
    Map.around size
        bounds
        [ Map.tileLayer ""
        , Map.markerLayer [ Location 14 42 ]
        , Map.popupLayer [ ( Location 14 42, "I popped up, merry poppin!" ) ]
        ]


size : Size
size =
    { width = 600, height = 400 }


bounds : Location.Bounds
bounds =
    { southWest = Location 6 35
    , northEast = Location 19 48
    }
