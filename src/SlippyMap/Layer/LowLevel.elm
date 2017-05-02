module SlippyMap.Layer.LowLevel
    exposing
        ( Config
        , withAttribution
        , withoutAttribution
        , Layer
        , withRender
        , getAttribution
        , render
        )

import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)


{-| Base configuration for all layers.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config
    = Config
        { attribution : Maybe String
        }


withAttribution : String -> Config
withAttribution attribution =
    Config
        { attribution = Just attribution }


withoutAttribution : Config
withoutAttribution =
    Config
        { attribution = Nothing }


type Layer msg
    = Layer Config (Render msg)


withRender : Config -> Render msg -> Layer msg
withRender =
    Layer


type alias Render msg =
    Transform -> Svg msg


getAttribution : Layer msg -> Maybe String
getAttribution (Layer (Config config) render) =
    config.attribution


render : Layer msg -> Render msg
render (Layer (Config config) render) =
    render
