module Static.Popup exposing (main)

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.Marker.Circle as Circle
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Map.Types exposing (Size)
import SlippyMap.Static as Map


main : Html msg
main =
    Map.around size
        bounds
        [ Map.tileLayer
        , Circle.marker [ Location 14 42 ]
        , Popup.layer Popup.config [ ( Location 14 42, "I popped up, merry poppin!" ) ]
        ]


size : Size
size =
    { width = 600, height = 400 }


bounds : Location.Bounds
bounds =
    { southWest = Location 6 35
    , northEast = Location 19 48
    }
