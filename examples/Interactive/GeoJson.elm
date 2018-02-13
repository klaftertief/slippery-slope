module Interactive.GeoJson exposing (..)

import Data.Simplestyle
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Html.Attributes
import Json.Encode as Json
import SlippyMap.Bundle.Interactive as Map
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.GeoJson as GeoJsonLayer


type alias Model =
    { map : Map.State }


type Msg
    = MapMsg Map.Msg


init : ( Model, Cmd Msg )
init =
    { map =
        Map.at config
            { center = Location 5 50
            , zoom = 3
            }
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MapMsg mapMsg ->
            { model
                | map =
                    Map.update config mapMsg model.map
            }
                ! []


config : Map.Config Msg
config =
    Map.config { width = 600, height = 400 } MapMsg


subscriptions : Model -> Sub Msg
subscriptions model =
    Map.subscriptions config model.map


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.style
            [ ( "padding", "1.5rem" ) ]
        ]
        [ Html.h1 []
            [ Html.text "Map with GeoJson" ]
        , Map.view config
            model.map
            [ Map.tileLayer ""
            , GeoJsonLayer.layer (GeoJsonLayer.defaultConfig (always []))
                (Maybe.withDefault myGeoJson Data.Simplestyle.geoJson)
            ]
        ]



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
    ( GeoJson.FeatureCollection
        [ { geometry =
                Just <|
                    GeoJson.Polygon
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
          , properties = Json.null
          , id = Nothing
          }
        , { geometry =
                Just <|
                    GeoJson.Point ( 5, 50, 0 )
          , properties = Json.null
          , id = Nothing
          }
        ]
    , Nothing
    )
