module SlippyMap.Map.Config
    exposing
        ( Config(Config)
        , staticConfig
        , dynamicConfig
        , size
        )

{-|
@docs Config, staticConfig, dynamicConfig, size
-}

import SlippyMap.Map.Msg as Msg exposing (Msg)


{-| Configuration for the map.
-}
type Config msg
    = Config
        { attributionPrefix : Maybe String
        , dimensions : { width : Int, height : Int }
        , minZoom : Float
        , maxZoom : Float
        , toMsg : Maybe (Msg -> msg)
        }


{-| -}
staticConfig : { width : Int, height : Int } -> Config msg
staticConfig dimensions =
    Config
        { attributionPrefix = Just "Elm"
        , dimensions = dimensions
        , minZoom = 0
        , maxZoom = 19
        , toMsg = Nothing
        }


{-| -}
dynamicConfig : { width : Int, height : Int } -> (Msg -> msg) -> Config msg
dynamicConfig dimensions toMsg =
    Config
        { attributionPrefix = Just "Elm"
        , dimensions = dimensions
        , minZoom = 0
        , maxZoom = 19
        , toMsg = Just toMsg
        }


size : Config msg -> { width : Int, height : Int }
size (Config { dimensions }) =
    dimensions
