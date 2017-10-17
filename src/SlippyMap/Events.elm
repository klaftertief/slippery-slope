module SlippyMap.Events
    exposing
        ( Event
        , MapEvent
        , on
        , onn
        )

{-|

@docs Event, MapEvent, on, onn

-}

import Json.Decode exposing (Decoder)
import SlippyMap.Geo.Location exposing (Location)
import SlippyMap.Geo.Point exposing (Point)


{-| TODO: make opaque
-}
type alias Event data msg =
    { name : String
    , toDecoder : data -> Decoder msg
    }


{-| -}
type alias MapEvent msg =
    Event ( Point, Location ) msg


{-| -}
on : String -> (( Point, Location ) -> Decoder msg) -> Event ( Point, Location ) msg
on name toDecoder =
    Event name toDecoder


{-| -}
onn : String -> (data -> Decoder msg) -> Event data msg
onn name toDecoder =
    Event name toDecoder
