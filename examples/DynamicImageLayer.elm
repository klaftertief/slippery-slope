module DynamicImageLayer exposing (..)

import Data
import Data.World
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Html.Attributes
import Layer.Debug
import SlippyMap.Layer.GeoJson as GeoJsonLayer
import SlippyMap.Layer.Grid as Grid
import SlippyMap.Layer.Heatmap as Heatmap
import SlippyMap.Layer.Marker as Marker
import SlippyMap.Layer.Overlay as Overlay
import SlippyMap.Layer.StaticImage as StaticImage
import SlippyMap.Map.LowLevel as Map
import SlippyMap.Static as StaticMap


type alias Model =
    { mapState : Map.State }


type Msg
    = MapMsg Map.Msg


init : ( Model, Cmd Msg )
init =
    Model (StaticMap.center { lon = 7, lat = 51 } 6)
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            let
                newMapState =
                    Map.update mapMsg model.mapState
            in
                Model newMapState ! []


mapConfig : Map.Config Msg
mapConfig =
    Map.dynamicConfig MapMsg


view : Model -> Html Msg
view model =
    Html.div [ Html.Attributes.style [ ( "padding", "50px" ) ] ]
        [ Map.view mapConfig
            model.mapState
            [ StaticImage.layer
                (StaticImage.config "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ]
                    |> StaticImage.withAttribution "© OpenStreetMap contributors"
                )

            --, Grid.layer Grid.defaultConfig
            , Overlay.layer Overlay.defaultConfig
                [ ( { southWest = { lon = -74.22655, lat = 40.712216 }
                    , northEast = { lon = -74.12544, lat = 40.773941 }
                    }
                  , "http://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg"
                  )
                ]
            , GeoJsonLayer.layer GeoJsonLayer.defaultConfig
                (Maybe.withDefault myGeoJson Data.World.geoJson)

            --, GeoJsonLayer.layer GeoJsonLayer.defaultConfig
            --    myGeoJson
            --, Heatmap.layer Heatmap.defaultConfig
            --    (List.map
            --        (\{ location, value } ->
            --            ( location
            --            , Maybe.withDefault 10 value
            --                |> (\v ->
            --                        (if isNaN v then
            --                            5
            --                         else
            --                            clamp 15 25 (v / 10)
            --                        )
            --                            / 25
            --                   )
            --              --, 15
            --            )
            --        )
            --        Data.locationData
            --    )
            , Layer.Debug.layer
            , Marker.simpleLayer Marker.defaultConfig
                [ { lon = 6, lat = 50 }
                , { lon = 7, lat = 51 }
                , { lon = 8, lat = 52 }
                ]
            ]
        , Html.div []
            [ Html.text (toString model.mapState) ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Map.subscriptions mapConfig model.mapState


main : Program Never Model Msg
main =
    Html.program
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
