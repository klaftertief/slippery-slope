module StaticImageLayer exposing (..)

import Html exposing (Html)
import Layer.Debug
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Static as Map


main : Html msg
main =
    Html.div []
        [ map 256
        , map 128
        ]


map : Int -> Html msg
map tileSize =
    Map.view { width = 600, height = 400 }
        (Map.center { lon = 7, lat = 51 } 8
            |> Map.tileSize tileSize
        )
        [ StaticImage.layer
            (StaticImage.config "//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ]
                |> StaticImage.withAttribution "© OpenStreetMap contributors"
            )
        , Layer.Debug.layer
        ]
