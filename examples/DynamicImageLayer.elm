module DynamicImageLayer exposing (..)

import Data
import Data.World
import Dict exposing (Dict)
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Layer.Debug
import Set exposing (Set)
import SlippyMap.Interactive as Map
import SlippyMap.Layer.Circle as Circle
import SlippyMap.Layer.GeoJson as GeoJsonLayer
import SlippyMap.Layer.Grid as Grid
import SlippyMap.Layer.Heatmap as Heatmap
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Layer.Marker as Marker
import SlippyMap.Layer.Overlay as Overlay
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Layer.StaticImage as StaticImage
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Events
import Window


type alias Model =
    { mapState : Map.State
    , visibleLayerNames : Set String
    }


type Msg
    = MapMsg Map.Msg
    | Resize Window.Size
    | SetLayerVisibility String Bool


init : Window.Size -> ( Model, Cmd Msg )
init { width, height } =
    { mapState =
        Map.center { lon = 7, lat = 51 } 6
            |> Map.resize ( width, height )
    , visibleLayerNames = Set.empty
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            { model
                | mapState =
                    Map.update mapConfig
                        mapMsg
                        model.mapState
            }
                ! []

        Resize { width, height } ->
            { model
                | mapState =
                    Map.resize ( width, height )
                        model.mapState
            }
                ! []

        SetLayerVisibility layerName isVisible ->
            let
                newVisibleLayerNames =
                    if isVisible then
                        Set.insert layerName
                            model.visibleLayerNames
                    else
                        Set.remove layerName
                            model.visibleLayerNames

                newMapState =
                    if isVisible && layerName == "Heatmap" then
                        Map.jumpTo
                            { lon = 175.4, lat = -37.9 }
                            11
                            model.mapState
                    else if isVisible && layerName == "Marker" then
                        Map.jumpTo
                            { lon = 7, lat = 51 }
                            6
                            model.mapState
                    else if isVisible && layerName == "GeoJson" then
                        Map.jumpTo
                            { lon = 0, lat = 0 }
                            3
                            model.mapState
                    else if isVisible && layerName == "Image Overlay" then
                        Map.jumpTo
                            { lon = -74.17, lat = 40.74 }
                            12
                            model.mapState
                    else
                        model.mapState
            in
                { model
                    | visibleLayerNames = newVisibleLayerNames
                    , mapState = newMapState
                }
                    ! []


mapConfig : Map.Config Msg
mapConfig =
    Map.config MapMsg


view : Model -> Html Msg
view model =
    Html.div []
        [ Map.view mapConfig
            model.mapState
            --(imageLayer :: visibleLayers model.visibleLayerNames)
            (debugLayer :: visibleLayers model.visibleLayerNames)
        , Html.div
            [ Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "right", "8px" )
                , ( "top", "8px" )
                , ( "font-family", "sans-serif" )
                ]
            ]
            [ layerToggleControl model.visibleLayerNames ]
        ]


layerToggleControl : Set String -> Html Msg
layerToggleControl visibleLayerNames =
    Html.ul
        [ Html.Attributes.style
            [ ( "list-style", "none" )
            , ( "margin", "0" )
            , ( "padding", "8px" )
            , ( "background", "#fff" )
            , ( "border", "1px solid #aaa" )
            ]
        ]
        (List.map
            (layerToggle visibleLayerNames)
            (Dict.keys toggableLayers)
        )


layerToggle : Set String -> String -> Html Msg
layerToggle visibleLayerNames layerName =
    let
        isVisible =
            Set.member layerName visibleLayerNames
    in
        Html.li []
            [ Html.label []
                [ Html.input
                    [ Html.Attributes.type_ "checkbox"
                    , Html.Attributes.checked isVisible
                    , Html.Events.onCheck
                        (SetLayerVisibility layerName)
                    ]
                    []
                , Html.span
                    [ Html.Attributes.style
                        [ ( "margin-left", "4px" ) ]
                    ]
                    [ Html.text layerName ]
                ]
            ]


visibleLayers : Set String -> List (Layer Msg)
visibleLayers layerNames =
    layerNames
        |> Set.toList
        |> List.filterMap
            (flip Dict.get toggableLayers)


toggableLayers : Dict String (Layer Msg)
toggableLayers =
    Dict.fromList
        [ ( "Marker", markerLayer )
        , ( "Marker custom", customMarkerLayer )

        --, ( "Image Overlay", overlayLayer )
        , ( "GeoJson", geoJsonLayer )
        , ( "Heatmap", heatmapLayer )
        , ( "Popup", popupLayer )

        --, ( "Debug", debugLayer )
        --, ( "Circle", circleLayer )
        --, ( "Circle II", circleLayer2 )
        --, ( "Circle III", circleLayer3 )
        , ( "Graticules", graticuleLayer )
        ]


imageLayer : Layer Msg
imageLayer =
    StaticImage.layer
        (StaticImage.config "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ]
            |> StaticImage.withAttribution "© OpenStreetMap contributors"
        )


graticuleLayer : Layer Msg
graticuleLayer =
    Grid.layer Grid.defaultConfig


overlayLayer : Layer Msg
overlayLayer =
    Overlay.layer Overlay.defaultConfig
        [ ( { southWest = { lon = -74.22655, lat = 40.712216 }
            , northEast = { lon = -74.12544, lat = 40.773941 }
            }
            --, "http://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg"
          , "/slide.svg"
          )
        ]


geoJsonLayer : Layer Msg
geoJsonLayer =
    GeoJsonLayer.layer GeoJsonLayer.defaultConfig
        (Maybe.withDefault myGeoJson Data.World.geoJson)


heatmapLayer : Layer Msg
heatmapLayer =
    Heatmap.layer Heatmap.defaultConfig
        (List.map
            (\{ location, value } ->
                ( location
                , Maybe.withDefault 10 value
                    |> (\v ->
                            (if isNaN v then
                                5
                             else
                                clamp 15 25 (v / 10)
                            )
                                / 25
                       )
                  --, 15
                )
            )
            Data.locationData
        )


debugLayer : Layer Msg
debugLayer =
    Layer.Debug.layer


markerLayer : Layer Msg
markerLayer =
    Marker.simpleLayer Marker.defaultConfig
        [ { lon = 6, lat = 50 }
        , { lon = 7, lat = 51 }
        , { lon = 8, lat = 52 }
        ]


popupLayer : Layer Msg
popupLayer =
    Popup.layer Popup.config
        [ ( { lon = 5, lat = 50 }, "I'm a popup" ) ]


customMarkerLayer : Layer Msg
customMarkerLayer =
    Marker.layer
        (Marker.config coloredMarker)
        [ ( { lon = 5, lat = 50 }, "#ff3388" )
        , ( { lon = 6, lat = 52 }, "#33ff88" )
        , ( { lon = 7, lat = 49 }, "#3388ff" )
        ]


coloredMarker : String -> Svg Msg
coloredMarker color =
    Svg.circle
        [ Svg.Attributes.r "12"
        , Svg.Attributes.fill color
        , Svg.Attributes.stroke "white"
        , Svg.Attributes.strokeWidth "3"
        , Svg.Events.onClick (SetLayerVisibility "Popup" True)
        ]
        []


circleLayer : Layer Msg
circleLayer =
    Circle.layer (Circle.config 500)
        { lon = 6.714768, lat = 50.916492 }


circleLayer2 : Layer Msg
circleLayer2 =
    Circle.layer (Circle.config 500)
        { lon = 6.714768, lat = 0 }


circleLayer3 : Layer Msg
circleLayer3 =
    Circle.layer (Circle.config 500)
        { lon = 6.714768, lat = 75 }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Map.subscriptions mapConfig model.mapState
        , Window.resizes Resize
        ]


main : Program Window.Size Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


myGeoJson : GeoJson
myGeoJson =
    ( GeoJson.Geometry
        (GeoJson.Polygon
            [ [ ( -6.3281250000000036
                , 42.032974332441356
                , 0
                )
              , ( 14.414062499999996
                , 33.431441335575265
                , 0
                )
              , ( 29.179687499999996
                , 62.75472592723181
                , 0
                )
              , ( -5.273437500000001
                , 62.103882522897855
                , 0
                )
              , ( -17.226562500000004
                , 47.98992166741417
                , 0
                )
              , ( -6.3281250000000036
                , 42.032974332441356
                , 0
                )
              ]
            , [ ( 4.21875
                , 56.36525013685606
                , 0
                )
              , ( 1.40625
                , 46.558860303117164
                , 0
                )
              , ( 16.171875
                , 55.37911044801047
                , 0
                )
              , ( 4.21875
                , 56.36525013685606
                , 0
                )
              ]
            ]
        )
    , Nothing
    )
