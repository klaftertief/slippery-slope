module All exposing (..)

import LowLevel
import Static
import Shared
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Html exposing (Html)


main : Html msg
main =
    view Shared.transform


view : Transform -> Html msg
view transform =
    Html.div []
        [ Static.view transform
        , LowLevel.view transform
        ]
