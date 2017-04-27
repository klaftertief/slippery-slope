module SlippyMap.Map.LowLevel
    exposing
        ( Config
        , staticConfig
        , dynamicConfig
        , State
        , center
        , view
        , subscriptions
        )

import Json.Decode as Decode
import Mouse exposing (Position)
import SlippyMap.Control.Attribution as Attribution
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
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


{-| TODO: Do not have full Transfrom as the State.
Have a function `toTransform : Config msg -> State -> Transform`.
-}
type State
    = State
        { transform : Transform
        , drag : Maybe Drag
        }


type alias Drag =
    { last : Position
    , current : Position
    }


defaultState : State
defaultState =
    State
        { transform = defaultTransform
        , drag = Nothing
        }


setTransform : Transform -> State -> State
setTransform newTransform (State state) =
    State
        { state | transform = newTransform }


setDrag : Maybe Drag -> State -> State
setDrag newDrag (State state) =
    State
        { state | drag = newDrag }


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



-- SUBSCRIPTIONS


subscriptions : Config msg -> State -> Sub msg
subscriptions (Config config) ((State { drag }) as state) =
    case config.toMsg of
        Just toMsg ->
            case drag of
                Nothing ->
                    Sub.none

                Just _ ->
                    Sub.batch
                        [ Mouse.moves
                            (\xy ->
                                let
                                    newDrag =
                                        Maybe.map
                                            (\{ current } -> Drag current xy)
                                            drag
                                in
                                    setDrag newDrag state
                                        |> withDragTransform
                                        |> toMsg
                            )
                        , Mouse.ups
                            (\_ ->
                                setDrag Nothing state
                                    |> withDragTransform
                                    |> toMsg
                            )
                        ]

        Nothing ->
            Sub.none


withDragTransform : State -> State
withDragTransform ((State { transform, drag }) as state) =
    case drag of
        Nothing ->
            state

        Just { last, current } ->
            moveTo transform
                { x = transform.width / 2 + toFloat (last.x - current.x)
                , y = transform.height / 2 + toFloat (last.y - current.y)
                }
                |> (flip setTransform) state


moveTo : Transform -> Point -> Transform
moveTo transform toPoint =
    let
        currentCenterPoint =
            Transform.locationToPoint transform transform.center

        newCenterPoint =
            { x = toPoint.x + currentCenterPoint.x - transform.width / 2
            , y = toPoint.y + currentCenterPoint.y - transform.height / 2
            }
    in
        { transform | center = Transform.pointToLocation transform newCenterPoint }



-- VIEW


view : Config msg -> State -> List (Layer msg) -> Svg msg
view (Config config) ((State { transform }) as state) layers =
    let
        layerAttributions =
            List.map Layer.attribution layers
                |> List.filterMap identity

        -- TODO: Somehow inject event attributes, only for dynamic maps
        handlers =
            case config.toMsg of
                Just toMsg ->
                    [ -- Svg.Events.onClick
                      --(toMsg (setZoom (transform.zoom + 1) state))
                      Svg.Events.on "mousedown"
                        (Decode.map
                            (\xy ->
                                setDrag (Just (Drag xy xy)) state
                                    |> withDragTransform
                                    |> toMsg
                            )
                            Mouse.position
                        )
                    ]

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
