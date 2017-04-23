module SlippyMap.Geo.Location exposing (..)

{-| Geographical coordinates
-}


type alias Location =
    { lon : Float
    , lat : Float
    }


type alias Bounds =
    { southWest : Location
    , northEast : Location
    }


center : Bounds -> Location
center { southWest, northEast } =
    { lon = (southWest.lon + northEast.lon) / 2
    , lat = (southWest.lat + northEast.lat) / 2
    }


wrap : Location -> Location
wrap ({ lon } as location) =
    { location | lon = clamp -180 180 lon }
