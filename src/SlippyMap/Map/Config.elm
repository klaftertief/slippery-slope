module SlippyMap.Map.Config
    exposing
        ( Config(..)
        , staticConfig
        , dynamicConfig
        )

{-|
@docs Config, staticConfig, dynamicConfig
-}

import SlippyMap.Map.Update as Update exposing (Msg)


{-| Configuration for the map.

TODO: add ConfigInternal alias
-}
type Config msg
    = Config
        -- TODO: should width/height and tilesize live in Config as well and set an initial Transform?
        { attributionPrefix : Maybe String
        , minZoom : Float
        , maxZoom : Float
        , toMsg : Maybe (Msg -> msg)
        }


{-| -}
staticConfig : Config msg
staticConfig =
    Config
        { attributionPrefix = Just "ESM"
        , minZoom = 0
        , maxZoom = 22
        , toMsg = Nothing
        }


{-| -}
dynamicConfig : (Msg -> msg) -> Config msg
dynamicConfig toMsg =
    Config
        { attributionPrefix = Just "ESMd"
        , minZoom = 0
        , maxZoom = 22
        , toMsg = Just toMsg
        }
