module Static.Marker exposing (main)

import Html exposing (Html)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.Marker.Circle as Circle
import SlippyMap.Map.Types exposing (Size)
import SlippyMap.Static as Map


main : Html msg
main =
    Map.around size
        bounds
        [ Map.tileLayer
        , Circle.marker [ Location 14 42 ]
        , Circle.customMarker
            (Circle.circle
                |> Circle.withRadius 12
                |> Circle.withFill "#987123"
            )
            [ Location 12 44 ]
        ]


size : Size
size =
    { width = 600, height = 400 }


bounds : Location.Bounds
bounds =
    { southWest = Location 6 35
    , northEast = Location 19 48
    }
