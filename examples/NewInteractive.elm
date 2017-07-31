module NewInteractive exposing (..)

import Data.World
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import SlippyMap.Geo.CRS.EPSG3857 as CRS
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Interactive as Map
import SlippyMap.Layer.Circle as Circle
import SlippyMap.Layer.GeoJson as GeoJson
import SlippyMap.Layer.Graticule as Graticule
import Window


type alias Model =
    { mapState : Map.State
    , size : Window.Size
    }


type Msg
    = MapMsg Map.Msg
    | Resize Window.Size


init : Window.Size -> ( Model, Cmd Msg )
init size =
    { mapState =
        Map.center (mapConfig size)
            { lon = 7, lat = 51 }
            3
    , size = size
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            { model
                | mapState =
                    Map.update (mapConfig model.size)
                        mapMsg
                        model.mapState
            }
                ! []

        Resize size ->
            { model | size = size } ! []


mapConfig : Window.Size -> Map.Config Msg
mapConfig size =
    Map.config size MapMsg
        |> Map.withCRS CRS.crs


view : Model -> Html Msg
view model =
    Html.div []
        [ Map.view (mapConfig model.size)
            model.mapState
            [ Graticule.layer
            , GeoJson.layer GeoJson.defaultConfig (Maybe.withDefault myGeoJson Data.World.geoJson)
            , Circle.layer (Circle.config 500)
                (Location 7 51)
            , Circle.layer (Circle.config 500)
                (Location 7 80)
            , Circle.layer (Circle.config 500)
                (Location 7 0)
            ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Map.subscriptions (mapConfig model.size) model.mapState
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
