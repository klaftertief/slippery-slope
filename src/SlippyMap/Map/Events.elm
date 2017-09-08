module SlippyMap.Map.Events
    exposing
        ( Event
        , on
        )

{-|

@docs Event, on

-}

import Json.Decode exposing (Decoder)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)


{-| -}
type alias Event msg =
    { name : String
    , toDecoder : ( Point, Location ) -> Decoder msg
    }


{-| -}
on : String -> (( Point, Location ) -> Decoder msg) -> Event msg
on name toDecoder =
    Event name toDecoder
