module SlippyMap.Map.Config
    exposing
        ( Config(Config)
        , interactive
        , size
        , static
        )

{-|

@docs Config, static, interactive, size

TODO: Add field for client position decoder

-}

import SlippyMap.Geo.CRS as CRS exposing (CRS)
import SlippyMap.Geo.CRS.EPSG3857 as EPSG3857
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Map.Msg as Msg exposing (Msg)


{-| Configuration for the map.
-}
type Config msg
    = Config (ConfigInternal msg)


type alias ConfigInternal msg =
    { attributionPrefix : Maybe String
    , size : Point
    , minZoom : Float
    , maxZoom : Float
    , toMsg : Maybe (Msg -> msg)
    , crs : CRS
    }


defaultConfigInternal : ConfigInternal msg
defaultConfigInternal =
    { attributionPrefix = Just "Elm"
    , size = { x = 600, y = 400 }
    , minZoom = 0
    , maxZoom = 19
    , toMsg = Nothing
    , crs = EPSG3857.crs
    }


{-| -}
static : Point -> Config msg
static size =
    Config
        { defaultConfigInternal | size = size }


{-| -}
interactive : Point -> (Msg -> msg) -> Config msg
interactive size toMsg =
    Config
        { defaultConfigInternal
            | size = size
            , toMsg = Just toMsg
        }


size : Config msg -> Point
size (Config { size }) =
    size
