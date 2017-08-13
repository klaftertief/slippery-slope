module Static exposing (main)

import Html exposing (Html)
import Html.Attributes
import Static.Simple


main : Html msg
main =
    Html.div
        [ Html.Attributes.style
            [ ( "padding", "1.5rem" ) ]
        ]
        [ Html.h1 []
            [ Html.text "Static maps" ]
        , example "At 0/0 and zoom 2"
            Static.Simple.viewAt
        , example "Around 6/35 and 19/48"
            Static.Simple.viewAround
        ]


example : String -> Html msg -> Html msg
example heading mapView =
    Html.div []
        [ Html.h2 []
            [ Html.text heading ]
        , mapView
        ]
