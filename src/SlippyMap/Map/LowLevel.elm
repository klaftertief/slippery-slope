module SlippyMap.Map.LowLevel
    exposing
        ( Config
        , staticConfig
        , dynamicConfig
        , State
        , center
        , view
        )

import SlippyMap.Control.Attribution as Attribution
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer(Layer))
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events


-- CONFIG


{-| Configuration for the map.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config msg
    = Config
        -- TODO: should width/height and tilesize live in Config as well and set an initial Transform?
        { attributionPrefix : Maybe String
        , minZoom : Float
        , maxZoom : Float
        , toMsg : Maybe (State -> msg)
        }


staticConfig : Config msg
staticConfig =
    Config
        { attributionPrefix = Just "ESM"
        , minZoom = 0
        , maxZoom = 22
        , toMsg = Nothing
        }


dynamicConfig : (State -> msg) -> Config msg
dynamicConfig toMsg =
    Config
        { attributionPrefix = Just "ESMd"
        , minZoom = 0
        , maxZoom = 22
        , toMsg = Just toMsg
        }



-- STATE


type State
    = State { transform : Transform }


defaultState : State
defaultState =
    State { transform = defaultTransform }


setTransform : Transform -> State -> State
setTransform newTransform (State state) =
    State
        { state | transform = newTransform }


defaultTransform : Transform
defaultTransform =
    { tileSize = 256
    , width = 600
    , height = 400
    , center = { lon = 0, lat = 0 }
    , zoom = 0
    }


setCenter : Location -> State -> State
setCenter newCenter ((State { transform }) as state) =
    setTransform { transform | center = newCenter } state


setZoom : Float -> State -> State
setZoom newZoom ((State { transform }) as state) =
    setTransform { transform | zoom = newZoom } state


center : Location -> Float -> State
center initialCenter initialZoom =
    defaultState
        |> setCenter initialCenter
        |> setZoom initialZoom



-- VIEW


view : Config msg -> State -> List (Layer msg) -> Svg msg
view (Config config) ((State { transform }) as state) layers =
    let
        layerAttributions =
            List.map Layer.attribution layers
                |> List.filterMap identity

        handlers =
            case config.toMsg of
                Just toMsg ->
                    [ Svg.Events.onClick (toMsg (setZoom (transform.zoom + 1) state)) ]

                Nothing ->
                    []
    in
        Svg.svg
            ([ Svg.Attributes.class "esm__map"
             , Svg.Attributes.height (toString transform.height)
             , Svg.Attributes.width (toString transform.width)
             ]
                ++ handlers
            )
            [ Svg.g [ Svg.Attributes.class "esm__layers" ]
                (List.map
                    (\(Layer layerconfig render) -> render transform)
                    layers
                )
            , Svg.g [ Svg.Attributes.class "esm__controls" ]
                [ Attribution.attribution config.attributionPrefix
                    layerAttributions
                ]
            ]
