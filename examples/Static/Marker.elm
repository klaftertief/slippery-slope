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
            (Circle.icon
                |> Circle.withRadius 12
                |> Circle.withFill "#ff6633"
            )
            [ Location 12 44 ]
        , Circle.individualMarker
            Tuple.second
            (Tuple.first >> flip Circle.withFill Circle.icon)
            [ ( "#115599", Location 11 47 )
            , ( "#559911", Location 8 37 )
            , ( "#991155", Location 15 38 )
            ]
        ]


size : Size
size =
    { width = 600, height = 400 }


bounds : Location.Bounds
bounds =
    { southWest = Location 6 35
    , northEast = Location 19 48
    }
