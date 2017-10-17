module SlippyMap.Config
    exposing
        ( Config
        , Interactions
        , attributionPrefix
        , crs
        , interactions
        , interactive
        , maxZoom
        , minZoom
        , pointerPositionDecoder
        , size
        , static
        , tagger
        , withAttributionPrefix
        , withCRS
        , withMaxZoom
        , withMinZoom
        , withZoomDelta
        , withZoomSnap
        , withoutAttributionControl
        , withoutZoomControl
        , zoomControl
        , zoomDelta
        , zoomSnap
        )

{-|

@docs Config, static, interactive, size, withCRS, withZoomSnap, withZoomDelta, withMaxZoom, withMinZoom, withoutZoomControl, zoomControl, Interactions, crs, minZoom, maxZoom, zoomDelta, zoomSnap, tagger, interactions, attributionPrefix, withoutAttributionControl, withAttributionPrefix, pointerPositionDecoder

-}

import DOM
import Json.Decode as Decode exposing (Decoder)
import SlippyMap.Geo.CRS exposing (CRS)
import SlippyMap.Geo.CRS.EPSG3857 as EPSG3857
import SlippyMap.Geo.Point exposing (Point)
import SlippyMap.Msg exposing (Msg)


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
    , zoomControl : Bool
    , attributionControl : Bool
    , interactions : Interactions
    , pointerPositionDecoder : Decoder Point
    }


defaultConfigInternal : ConfigInternal msg
defaultConfigInternal =
    { attributionPrefix = Nothing
    , size = { x = 600, y = 400 }
    , minZoom = 0
    , maxZoom = 19
    , zoomSnap = 1
    , zoomDelta = 1
    , toMsg = Nothing
    , crs = EPSG3857.crs
    , zoomControl = False
    , attributionControl = True
    , interactions = interactiveInteractions
    , pointerPositionDecoder = domPointerPositionDecoder
    }


domPointerPositionDecoder : Decoder Point
domPointerPositionDecoder =
    Decode.map5
        (\x y r l t ->
            { x = x - r.left - l
            , y = y - r.top - t
            }
        )
        (Decode.field "clientX" Decode.float)
        (Decode.field "clientY" Decode.float)
        -- (DOM.target mapPosition)
        (Decode.field "currentTarget" mapPosition)
        (Decode.field "currentTarget" <|
            Decode.field "clientLeft" Decode.float
        )
        (Decode.field "currentTarget" <|
            Decode.field "clientTop" Decode.float
        )


mapPosition : Decoder DOM.Rectangle
mapPosition =
    Decode.oneOf
        [ DOM.boundingClientRect
        , Decode.lazy (\_ -> DOM.parentElement mapPosition)
        ]


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
            , zoomControl = True
        }


{-| -}
withCRS : CRS -> Config msg -> Config msg
withCRS crs (Config configInternal) =
    Config
        { configInternal | crs = crs }


{-| -}
withoutZoomControl : Config msg -> Config msg
withoutZoomControl (Config configInternal) =
    Config
        { configInternal | zoomControl = False }


{-| -}
withAttributionPrefix : String -> Config msg -> Config msg
withAttributionPrefix prefix (Config configInternal) =
    Config
        { configInternal | attributionPrefix = Just prefix }


{-| -}
withoutAttributionControl : Config msg -> Config msg
withoutAttributionControl (Config configInternal) =
    Config
        { configInternal | attributionControl = False }


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
zoomControl : Config msg -> Bool
zoomControl (Config { zoomControl }) =
    zoomControl


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


{-| -}
pointerPositionDecoder : Config msg -> Decoder Point
pointerPositionDecoder (Config { pointerPositionDecoder }) =
    pointerPositionDecoder
