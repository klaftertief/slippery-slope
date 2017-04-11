module SlippyMap.Geo.Location exposing (..)

{-| Geographical coordinates
-}


type alias Location =
    { lon : Float
    , lat : Float
    }


wrap : Location -> Location
wrap ({ lon } as location) =
    { location | lon = clamp -180 180 lon }
