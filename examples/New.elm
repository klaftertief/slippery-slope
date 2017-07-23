module SlippyMap.Playground exposing (..)

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.CRS.EPSG3857 as EPSG3857
import SlippyMap.Geo.Location as Location exposing (Location)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Layer.GeoJson.Render as Render
import SlippyMap.Map.Transform as Transform exposing (Transform)
import Svg
import Svg.Attributes


transform : Transform
transform =
    { size = Point 600 400
    , crs = EPSG3857.crs
    , center = Location 4.21875 56.36525013685606
    , zoom = 4
    }



-- 17 -> 17429363.28888889 11233069.463062841 600 400
-- 18 -> 34859026.57777778 22466338.926125683 600 400


main : Svg.Svg msg
main =
    let
        centerPoint =
            Transform.locationToScreenPoint transform transform.center

        viewBox =
            [ 0, 0, transform.size.x, transform.size.y ]
                |> List.map toString
                |> String.join " "

        project ( lon, lat, _ ) =
            Transform.locationToScreenPoint transform (Location lon lat)

        style =
            always
                [ Svg.Attributes.stroke "#3388ff"
                , Svg.Attributes.strokeWidth "3"
                , Svg.Attributes.fill "#3388ff"
                , Svg.Attributes.fillOpacity "0.2"
                , Svg.Attributes.strokeLinecap "round"
                , Svg.Attributes.strokeLinejoin "round"
                ]

        renderConfig =
            Render.Config
                { project = project
                , style = style
                }
    in
    Svg.svg
        [ Svg.Attributes.width (toString transform.size.x)
        , Svg.Attributes.height (toString transform.size.y)
        , Svg.Attributes.viewBox viewBox
        ]
        [ Svg.g []
            [ Render.renderGeoJson renderConfig myGeoJson ]
        , Svg.circle
            [ Svg.Attributes.r "8"
            , Svg.Attributes.fill "#3388ff"
            , Svg.Attributes.stroke "white"
            , Svg.Attributes.strokeWidth "3"

            -- , Svg.Attributes.cx (toString <| floor centerPoint.x)
            -- , Svg.Attributes.cy (toString <| floor centerPoint.y)
            , Svg.Attributes.transform
                ("translate("
                    ++ toString centerPoint.x
                    ++ " "
                    ++ toString centerPoint.y
                    ++ ")"
                )
            ]
            []
        ]


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
