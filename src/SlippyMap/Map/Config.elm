module SlippyMap.Map.Config
    exposing
        ( Config(Config)
        , Interactions
        , interactive
        , size
        , static
        , withCRS
        , withZoomDelta
        , withZoomSnap
        )

{-|

@docs Config, static, interactive, size, withCRS, withZoomSnap, withZoomDelta, Interactions

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
    , zoomSnap : Float
    , zoomDelta : Float
    , toMsg : Maybe (Msg -> msg)
    , crs : CRS
    , interactions : Interactions
    }


defaultConfigInternal : ConfigInternal msg
defaultConfigInternal =
    { attributionPrefix = Just "Elm"
    , size = { x = 600, y = 400 }
    , minZoom = 0
    , maxZoom = 19
    , zoomSnap = 0
    , zoomDelta = 1
    , toMsg = Nothing
    , crs = EPSG3857.crs
    , interactions = interactiveInteractions
    }


{-| -}
type alias Interactions =
    { scrollWheelZoom : Bool
    , doubleClickZoom : Bool
    , touchZoom : Bool
    , keyboardControl : Bool
    }


interactiveInteractions : Interactions
interactiveInteractions =
    { scrollWheelZoom = True
    , doubleClickZoom = True
    , touchZoom = True
    , keyboardControl = True
    }


staticInteractions : Interactions
staticInteractions =
    { scrollWheelZoom = False
    , doubleClickZoom = False
    , touchZoom = True
    , keyboardControl = False
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


{-| -}
withCRS : CRS -> Config msg -> Config msg
withCRS crs (Config configInternal) =
    Config
        { configInternal | crs = crs }


{-| -}
withZoomSnap : Float -> Config msg -> Config msg
withZoomSnap zoomSnap (Config configInternal) =
    Config
        { configInternal | zoomSnap = zoomSnap }


{-| -}
withZoomDelta : Float -> Config msg -> Config msg
withZoomDelta zoomDelta (Config configInternal) =
    Config
        { configInternal | zoomDelta = zoomDelta }


{-| -}
size : Config msg -> Point
size (Config { size }) =
    size
