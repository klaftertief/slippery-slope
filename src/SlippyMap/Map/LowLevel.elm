module SlippyMap.Map.LowLevel exposing (..)

import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer(Layer))
import Svg exposing (Svg)
import Svg.Attributes


{-| Configuration for the map.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config
    = Config
        { attributionPrefix : Maybe String
        , minZoom : Float
        , maxZoom : Float
        }


type State
    = State
        { transform : Transform
        , attributions : List String
        }


view : Config -> State -> List (Layer msg) -> Svg msg
view (Config config) (State { transform }) layers =
    let
        -- TODO: collect attributions of all layers
        layerAttributions =
            []
    in
        Svg.svg
            [ Svg.Attributes.height (toString transform.height)
            , Svg.Attributes.width (toString transform.width)
            ]
            (List.map
                (\(Layer layerconfig render) -> render transform)
                layers
            )
