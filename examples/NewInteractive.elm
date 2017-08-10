module NewInteractive exposing (..)

import Data.World
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import Json.Decode
import Layer.Debug
import SlippyMap.Geo.CRS.EPSG3857 as CRS
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Interactive as Map
import SlippyMap.Layer as Layer
import SlippyMap.Layer.Circle as Circle
import SlippyMap.Layer.GeoJson as GeoJson
import SlippyMap.Layer.Graticule as Graticule
import SlippyMap.Layer.Marker.Circle as CircleMarker
import SlippyMap.Layer.Marker.Pin as PinMarker
import SlippyMap.Layer.Popup as Popup
import SlippyMap.Layer.StaticImage as StaticImage
import Svg.Attributes
import Window


type alias Model =
    { mapState : Map.State
    , size : Window.Size
    , info : Maybe String
    }


type Msg
    = MapMsg Map.Msg
    | Resize Window.Size
    | SetInfo String
    | ResetInfo


init : Window.Size -> ( Model, Cmd Msg )
init size =
    { mapState =
        -- Map.center (mapConfig size)
        --     { lon = 0, lat = 0 }
        --     3
        Map.around (mapConfig size)
            { southWest = Location -20 -30
            , northEast = Location 20 20
            }
    , size = size
    , info = Nothing
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

        SetInfo info ->
            { model | info = Just info } ! []

        ResetInfo ->
            { model | info = Nothing } ! []


mapConfig : Window.Size -> Map.Config Msg
mapConfig size =
    Map.config size MapMsg
        |> Map.withCRS CRS.crs


view : Model -> Html Msg
view model =
    Html.div []
        [ Map.view (mapConfig model.size)
            model.mapState
            [ {- StaticImage.layer
                     (StaticImage.config "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" [ "a", "b", "c" ]
                         |> StaticImage.withAttribution "© OpenStreetMap contributors"
                     )
                 ,
              -}
              --   Layer.Debug.layer
              Graticule.layer

            -- , GeoJson.layer
            --     (GeoJson.defaultConfig
            --         (\featureObject ->
            --             let
            --                 propertiesName =
            --                     Json.Decode.decodeValue
            --                         (Json.Decode.field "name" Json.Decode.string)
            --                         featureObject.properties
            --             in
            --             case propertiesName of
            --                 Ok name ->
            --                     [ Html.Events.onClick (SetInfo name)
            --                     -- , Svg.Attributes.pointerEvents "visible"
            --                     ]
            --                 Err _ ->
            --                     []
            --         )
            --     )
            --     (Maybe.withDefault myGeoJson Data.World.geoJson)
            -- , Layer.group
            --     [ Circle.layer (Circle.config 500)
            --         (Location 0 60)
            --     , Circle.layer (Circle.config 500)
            --         (Location 0 30)
            --     , Circle.layer (Circle.config 500)
            --         (Location 0 0)
            --     ]
            , CircleMarker.layer [ Location 0 0 ]

            -- , PinMarker.layer [ Location -10 0 ]
            -- , Popup.layer Popup.config
            --     [ ( Location -10 0, "I'm a popup" ) ]
            ]
        , Html.p
            [ Html.Attributes.style
                [ ( "position", "absolute" )
                , ( "top", "1em" )
                , ( "left", "1em" )
                , ( "right", "1em" )
                , ( "text-align", "center" )
                ]
            ]
            [ Html.text (toString model.info) ]
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
