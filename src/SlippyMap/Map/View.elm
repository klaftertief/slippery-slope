module SlippyMap.Map.View exposing (view)

{-|
@docs view
-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode as Decode exposing (Decoder)
import Mouse exposing (Position)
import SlippyMap.Control.Attribution as Attribution
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Map.Config as Config exposing (Config(..))
import SlippyMap.Map.State as State exposing (State(..), Focus(..))
import SlippyMap.Map.Update as Update exposing (Msg(..), DragMsg(..))
import Svg exposing (Svg)
import Svg.Attributes


{-| -}
view : Config msg -> State -> List (Layer msg) -> Html msg
view (Config config) ((State { transform }) as state) layers =
    let
        -- TODO: onlye get attributions from currentlyc visible layers, whater that means or it's implemented
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
                    (List.concatMap
                        (viewPane (Config config) state layers)
                        Layer.panes
                    )
                , Svg.g [ Svg.Attributes.class "esm__controls" ]
                    [ Attribution.attribution config.attributionPrefix
                        layerAttributions
                    ]
                ]
            ]


viewPane : Config msg -> State -> List (Layer msg) -> Layer.Pane -> List (Svg msg)
viewPane (Config config) ((State { transform }) as state) layers pane =
    layers
        |> List.filter (Layer.getPane >> (==) pane)
        |> List.map (\layer -> Layer.render layer transform)


clientPosition : Decoder Point
clientPosition =
    Decode.map2 Point
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)
