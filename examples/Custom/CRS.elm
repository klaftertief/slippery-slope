module Custom.CRS exposing (main)

import AnimationFrame
import Data.World
import GeoJson exposing (GeoJson)
import Html exposing (Html)
import Html.Attributes
import Html.Events
import SlippyMap.Geo.CRS as Geo
import SlippyMap.Geo.CRS.EPSG3857 as CRS_EPSG3857
import SlippyMap.Geo.CRS.Simple as CRS_Simple
import SlippyMap.Geo.CRS.Stereographic as CRS_Stereographic
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Layer.GeoJson as GeoJson
import SlippyMap.Layer.Graticule as Graticule
import SlippyMap.Map.Config as Map
import SlippyMap.Map.State as Map
import SlippyMap.Map.View as Map
import Time exposing (Time)


type Model
    = Static CRS
    | Transitioning Float CRS CRS


type CRS
    = EPSG3857
    | Simple
    | Stereographic


crsList : List CRS
crsList =
    [ EPSG3857
    , Simple
    , Stereographic
    ]


toGeoCRS : CRS -> Geo.CRS
toGeoCRS crs =
    case crs of
        EPSG3857 ->
            CRS_EPSG3857.crs

        Simple ->
            CRS_Simple.crs

        Stereographic ->
            CRS_Stereographic.crs


type Msg
    = SetCRS CRS
    | Tick Time


init : ( Model, Cmd Msg )
init =
    Static EPSG3857 ! []


duration : Time
duration =
    800


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetCRS toCrs ->
            case model of
                Static crs ->
                    Transitioning 0 crs toCrs ! []

                Transitioning t from to ->
                    Transitioning 0 to toCrs ! []

        Tick diff ->
            case model of
                Static crs ->
                    model ! []

                Transitioning t from to ->
                    let
                        progress =
                            t + diff / duration
                    in
                    if progress >= 1 then
                        Static to ! []
                    else
                        Transitioning progress from to ! []


mapConfig : Map.Config Msg
mapConfig =
    Map.static { x = 512, y = 512 }


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.style
            [ ( "padding", "1.5rem" ) ]
        ]
        [ Html.h1 []
            [ Html.text "Static map with different CRSs" ]
        , crsView model
        , mapView model
        ]


crsView : Model -> Html Msg
crsView model =
    let
        button crs =
            Html.button
                [ Html.Events.onClick (SetCRS crs) ]
                [ Html.text (toString crs) ]
    in
    Html.p []
        (List.map button crsList)


mapView : Model -> Html Msg
mapView model =
    let
        config =
            case model of
                Static crs ->
                    Map.withCRS (toGeoCRS crs) mapConfig

                Transitioning t from to ->
                    Map.withCRS
                        (morph t (toGeoCRS from) (toGeoCRS to))
                        mapConfig
    in
    Map.view config
        (Map.at config
            { center = Location 0 0
            , zoom = 1
            }
        )
        [ Graticule.layer
        , GeoJson.layer (GeoJson.defaultConfig (always []))
            (Maybe.withDefault myGeoJson Data.World.geoJson)
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Static _ ->
            Sub.none

        Transitioning _ _ _ ->
            AnimationFrame.diffs Tick


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


morph : Float -> Geo.CRS -> Geo.CRS -> Geo.CRS
morph progress fromCRS toCRS =
    let
        t =
            clamp 0 1 progress

        between a b =
            (1 - t) * a + t * b

        tween f x =
            between (f fromCRS x) (f toCRS x)

        tween2 f x y =
            between (f fromCRS x y) (f toCRS x y)

        locationToPoint z l =
            let
                from =
                    fromCRS.locationToPoint z l

                to =
                    toCRS.locationToPoint z l
            in
            { x = between from.x to.x
            , y = between from.y to.y
            }

        pointToLocation z p =
            let
                from =
                    fromCRS.pointToLocation z p

                to =
                    toCRS.pointToLocation z p
            in
            { lon = between from.lon to.lon
            , lat = between from.lat to.lat
            }

        project l =
            let
                from =
                    fromCRS.project l

                to =
                    toCRS.project l
            in
            { x = between from.x to.x
            , y = between from.y to.y
            }

        unproject p =
            let
                from =
                    fromCRS.unproject p

                to =
                    toCRS.unproject p
            in
            { lon = between from.lon to.lon
            , lat = between from.lat to.lat
            }

        zoom =
            tween .zoom

        scale =
            tween .scale

        distance =
            tween2 .distance
    in
    { locationToPoint = locationToPoint
    , pointToLocation = pointToLocation
    , project = project
    , unproject = unproject
    , scale = scale
    , zoom = zoom
    , distance = distance
    , code = "From " ++ fromCRS.code ++ " to " ++ toCRS.code
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
