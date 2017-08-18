module SlippyMap.Layer.Control
    exposing
        ( Config
        , bottomLeft
        , bottomRight
        , control
        , topLeft
        , topRight
        )

{-| A layer tor create custom controls.
-}

import Html exposing (Html)
import Html.Attributes
import SlippyMap.Layer as Layer exposing (Layer)
import SlippyMap.Map.Config as Map
import SlippyMap.Map.State as Map
import SlippyMap.Map.Transform as Transform exposing (Transform)


-- CONFIG


{-| Configuration for the layer.
-}
type Config msg
    = Config
        { position : Position
        , render : Transform -> Html msg
        }


type Position
    = TopLeft
    | TopRight
    | BottomRight
    | BottomLeft


config : Position -> Config msg
config position =
    Config
        { position = position
        , render = always (Html.text "")
        }


withRenderer : (Transform -> Html msg) -> Config msg -> Config msg
withRenderer renderer (Config config) =
    Config
        { config | render = renderer }


{-| -}
topLeft : Config msg
topLeft =
    config TopLeft


{-| -}
topRight : Config msg
topRight =
    config TopRight


{-| -}
bottomLeft : Config msg
bottomLeft =
    config BottomLeft


{-| -}
bottomRight : Config msg
bottomRight =
    config BottomRight


{-| -}
control : Config msg -> (Transform -> Html msg) -> Layer msg
control config renderer =
    Layer.custom
        (render (withRenderer renderer config))
        Layer.control


{-| -}
render : Config msg -> Transform -> Html msg
render (Config { position }) transform =
    Html.div []
        []
