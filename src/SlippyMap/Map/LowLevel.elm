module SlippyMap.Map.LowLevel
    exposing
        ( Config
        , staticConfig
        , dynamicConfig
        , State
        , center
        , getTransform
        , getCoordinateBounds
        , getTileCover
        , Msg
        , update
        , view
        , subscriptions
        )

{-|
@docs Config, staticConfig, dynamicConfig, State, center, getTransform, getCoordinateBounds, getTileCover, Msg, update, view, subscriptions
-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Keyboard exposing (KeyCode)
import Mouse exposing (Position)
import SlippyMap.Control.Attribution as Attribution
import SlippyMap.Geo.Coordinate as Coordinate exposing (Coordinate)
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import Svg exposing (Svg)
import Svg.Attributes


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



-- STATE


{-| TODO: Do not have full Transfrom as the State.
Have a function `toTransform : Config msg -> State -> Transform`.
-}
type State
    = State
        { transform : Transform
        , drag : Maybe Drag
        , focus : Focus
        }


type alias Drag =
    { last : Position
    , current : Position
    }


type Focus
    = HasFocus
    | HasNoFocus


defaultState : State
defaultState =
    State
        { transform = defaultTransform
        , drag = Nothing
        , focus = HasNoFocus
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


{-| -}
center : Location -> Float -> State
center initialCenter initialZoom =
    defaultState
        |> setCenter initialCenter
        |> setZoom initialZoom


{-| -}
getTransform : State -> Transform
getTransform (State { transform }) =
    transform


{-| -}
getLocationBounds : State -> Location.Bounds
getLocationBounds =
    getTransform >> Transform.locationBounds


{-| -}
getCoordinateBounds : State -> Coordinate.Bounds
getCoordinateBounds =
    getTransform >> Transform.tileBounds


{-| -}
getTileCover : State -> List Tile
getTileCover =
    getCoordinateBounds >> Tile.cover



-- UPDATE


{-| -}
type Msg
    = ZoomIn
    | ZoomOut
    | ZoomInAround Point
    | ZoomByAround Float Point
    | DragMsg DragMsg
    | SetFocus Focus
    | KeyboardNavigation KeyCode


type DragMsg
    = DragStart Position
    | DragAt Position
    | DragEnd Position


{-| -}
update : Msg -> State -> State
update msg (State ({ transform, drag } as state)) =
    case msg of
        ZoomIn ->
            let
                newTransform =
                    { transform | zoom = transform.zoom + 1 }

                newState =
                    { state | transform = newTransform }
            in
                State newState

        ZoomOut ->
            let
                newTransform =
                    { transform | zoom = transform.zoom - 1 }

                newState =
                    { state | transform = newTransform }
            in
                State newState

        ZoomInAround point ->
            let
                newTransform =
                    Transform.zoomToAround transform (transform.zoom + 1) point

                newState =
                    { state | transform = newTransform }
            in
                State newState

        ZoomByAround delta point ->
            let
                newTransform =
                    Transform.zoomToAround transform (transform.zoom + delta) point

                newState =
                    { state | transform = newTransform }
            in
                State newState

        DragMsg dragMsg ->
            let
                draggedState =
                    updateDrag dragMsg (State state)
                        |> withDragTransform
            in
                draggedState

        SetFocus focus ->
            State { state | focus = focus }

        KeyboardNavigation keyCode ->
            let
                moveBy =
                    case keyCode of
                        -- Left
                        37 ->
                            { x = -10, y = 0 }

                        -- Up
                        38 ->
                            { x = 0, y = -10 }

                        -- Right
                        39 ->
                            { x = 10, y = 0 }

                        -- Down
                        40 ->
                            { x = 0, y = 10 }

                        _ ->
                            { x = 0, y = 0 }
            in
                Transform.moveTo transform
                    { x = transform.width / 2 + moveBy.x
                    , y = transform.height / 2 + moveBy.y
                    }
                    |> (flip setTransform) (State state)


updateDrag : DragMsg -> State -> State
updateDrag dragMsg (State ({ drag } as state)) =
    case dragMsg of
        DragStart xy ->
            State
                { state | drag = Just (Drag xy xy) }

        DragAt xy ->
            State
                { state
                    | drag =
                        Maybe.map
                            (\{ current } -> Drag current xy)
                            drag
                }

        DragEnd _ ->
            State
                { state | drag = Nothing }


withDragTransform : State -> State
withDragTransform ((State { transform, drag }) as state) =
    case drag of
        Nothing ->
            state

        Just { last, current } ->
            Transform.moveTo transform
                { x = transform.width / 2 + toFloat (last.x - current.x)
                , y = transform.height / 2 + toFloat (last.y - current.y)
                }
                |> (flip setTransform) state



-- SUBSCRIPTIONS


{-| -}
subscriptions : Config msg -> State -> Sub msg
subscriptions (Config config) ((State { drag, focus }) as state) =
    case config.toMsg of
        Just toMsg ->
            let
                dragSubscriptions =
                    case drag of
                        Nothing ->
                            []

                        Just _ ->
                            [ Mouse.moves (DragAt >> DragMsg)
                            , Mouse.ups (DragEnd >> DragMsg)
                            ]

                keyboardNavigationSubscriptions =
                    case focus of
                        HasFocus ->
                            [ Keyboard.downs KeyboardNavigation ]

                        HasNoFocus ->
                            []
            in
                (dragSubscriptions ++ keyboardNavigationSubscriptions)
                    |> List.map (Sub.map toMsg)
                    |> Sub.batch

        Nothing ->
            Sub.none



-- VIEW


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view (Config config) ((State { transform }) as state) layers =
    let
        layerAttributions =
            List.map Layer.getAttribution layers
                |> List.filterMap identity

        -- TODO: Somehow inject event attributes, only for dynamic maps
        handlers =
            case config.toMsg of
                Just toMsg ->
                    List.map
                        (Html.Attributes.map toMsg)
                        [ Html.Events.on "dblclick"
                            (Decode.map ZoomInAround clientPosition)
                        , Html.Events.on "mousedown"
                            (Decode.map (DragStart >> DragMsg) Mouse.position)
                        , Html.Events.onWithOptions "wheel"
                            { preventDefault = True
                            , stopPropagation = True
                            }
                            (Decode.map2 (\offset point -> ZoomByAround offset point)
                                (Decode.field "deltaY" Decode.float
                                    |> Decode.map (\y -> -y / 100)
                                )
                                clientPosition
                            )
                        , Html.Events.onFocus (SetFocus HasFocus)
                        , Html.Events.onBlur (SetFocus HasNoFocus)
                        ]

                Nothing ->
                    []
    in
        Html.div
            ([ Html.Attributes.tabindex 0
             , Html.Attributes.style
                [ ( "position", "relative" )
                , ( "width", toString transform.width ++ "px" )
                , ( "height", toString transform.height ++ "px" )
                , ( "background", "#eee" )
                ]
             ]
                ++ handlers
            )
            [ Svg.svg
                [ Svg.Attributes.class "esm__map"
                , Svg.Attributes.height (toString transform.height)
                , Svg.Attributes.width (toString transform.width)
                ]
                [ Svg.g [ Svg.Attributes.class "esm__layers" ]
                    (List.map
                        -- TODO: should the have access to the full state and not only the transform?
                        (\layer -> Layer.render layer transform)
                        layers
                    )
                , Svg.g [ Svg.Attributes.class "esm__controls" ]
                    [ Attribution.attribution config.attributionPrefix
                        layerAttributions
                    ]
                ]
            ]


clientPosition : Decoder Point
clientPosition =
    Decode.map2 Point
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
