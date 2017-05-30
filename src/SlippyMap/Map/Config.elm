module SlippyMap.Map.Config
    exposing
        ( Config(..)
        , staticConfig
        , dynamicConfig
        )

{-|
@docs Config, staticConfig, dynamicConfig
-}

import SlippyMap.Map.Msg as Msg exposing (Msg)


{-| Configuration for the map.
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
        { attributionPrefix = Just "Elm"
        , minZoom = 0
        , maxZoom = 22
        , toMsg = Nothing
        }


{-| -}
dynamicConfig : (Msg -> msg) -> Config msg
dynamicConfig toMsg =
    Config
        { attributionPrefix = Just "Elm"
        , minZoom = 0
        , maxZoom = 22
        , toMsg = Just toMsg
        }
