module SlippyMap.Map.Config
    exposing
        ( Config
        , Interactions
        , attributionPrefix
        , crs
        , interactions
        , interactive
        , maxZoom
        , minZoom
        , size
        , static
        , tagger
        , withCRS
        , withMaxZoom
        , withMinZoom
        , withZoomDelta
        , withZoomSnap
        , zoomDelta
        , zoomSnap
        )

{-|

@docs Config, static, interactive, size, withCRS, withZoomSnap, withZoomDelta, withMaxZoom, withMinZoom, Interactions, crs, minZoom, maxZoom, zoomDelta, zoomSnap, tagger, interactions, attributionPrefix

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
    , zoomSnap = 1
    , zoomDelta = 1
    , toMsg = Nothing
    , crs = EPSG3857.crs
    , interactions = interactiveInteractions
    }


{-| TODO: make opaque
-}
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
withMaxZoom : Float -> Config msg -> Config msg
withMaxZoom maxZoom (Config configInternal) =
    Config
        { configInternal | maxZoom = maxZoom }


{-| -}
withMinZoom : Float -> Config msg -> Config msg
withMinZoom minZoom (Config configInternal) =
    Config
        { configInternal | minZoom = minZoom }


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


{-| -}
crs : Config msg -> CRS
crs (Config { crs }) =
    crs


{-| -}
minZoom : Config msg -> Float
minZoom (Config { minZoom }) =
    minZoom


{-| -}
maxZoom : Config msg -> Float
maxZoom (Config { maxZoom }) =
    maxZoom


{-| -}
zoomDelta : Config msg -> Float
zoomDelta (Config { zoomDelta }) =
    zoomDelta


{-| -}
zoomSnap : Config msg -> Float
zoomSnap (Config { zoomSnap }) =
    zoomSnap


{-| -}
tagger : Config msg -> Maybe (Msg -> msg)
tagger (Config { toMsg }) =
    toMsg


{-| -}
interactions : Config msg -> Interactions
interactions (Config { interactions }) =
    interactions


{-| -}
attributionPrefix : Config msg -> Maybe String
attributionPrefix (Config { attributionPrefix }) =
    attributionPrefix
