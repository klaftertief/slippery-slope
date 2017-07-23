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
static : { width : Int, height : Int } -> Config msg
static { width, height } =
    Config
        { defaultConfigInternal
            | size = { x = toFloat width, y = toFloat height }
        }


{-| -}
interactive : { width : Int, height : Int } -> (Msg -> msg) -> Config msg
interactive { width, height } toMsg =
    Config
        { defaultConfigInternal
            | size = { x = toFloat width, y = toFloat height }
            , toMsg = Just toMsg
        }


size : Config msg -> { width : Int, height : Int }
size (Config { size }) =
    { width = round size.x, height = round size.y }
