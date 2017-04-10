module Source.VectorTile exposing (..)

import Dict exposing (Dict)
import GeoJson exposing (GeoJson)
import Json.Decode as Json


type Layer
    = Earth
      --| Boundaries
    | Roads


type alias Tiles =
    Dict String GeoJson


testTiles : Tiles
testTiles =
    tile_roads_5_16_10
        |> Maybe.map
            (\geoJson -> Dict.insert "5/16/10" geoJson Dict.empty)
        |> Maybe.withDefault Dict.empty


--tile_8_132_85 : Maybe GeoJson
--tile_8_132_85 =
--    Json.decodeString (Json.field "earth" GeoJson.decoder) tileJson_8_132_85
--        |> Debug.log "result"
--        |> Result.toMaybe


tile_roads_5_16_10 : Maybe GeoJson
tile_roads_5_16_10 =
    Json.decodeString (Json.field "earth" GeoJson.decoder) tileJson_5_16_10
        |> Result.toMaybe


tileJson_5_16_10 : String
tileJson_5_16_10 =
    """{
  "roads": {
    "type": "FeatureCollection",
    "features": [
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.315,
              49.551
            ],
            [
              8.314,
              49.559
            ],
            [
              8.31,
              49.565
            ],
            [
              8.305,
              49.57
            ],
            [
              8.3,
              49.576
            ],
            [
              8.296,
              49.588
            ],
            [
              8.295,
              49.6
            ],
            [
              8.296,
              49.646
            ],
            [
              8.295,
              49.656
            ],
            [
              8.291,
              49.666
            ],
            [
              8.285,
              49.675
            ],
            [
              8.277,
              49.682
            ],
            [
              8.267,
              49.685
            ],
            [
              8.256,
              49.687
            ],
            [
              8.246,
              49.686
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "31",
          "id": 4188
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.246,
              49.686
            ],
            [
              8.234,
              49.685
            ],
            [
              8.223,
              49.685
            ],
            [
              8.212,
              49.688
            ],
            [
              8.204,
              49.691
            ],
            [
              8.197,
              49.695
            ],
            [
              8.189,
              49.699
            ],
            [
              8.16,
              49.73
            ],
            [
              8.113,
              49.771
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "31",
          "id": 4188
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.923,
              49.915
            ],
            [
              7.92,
              49.917
            ],
            [
              7.888,
              49.937
            ],
            [
              7.869,
              49.945
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "31",
          "id": 4189
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.869,
                49.945
              ],
              [
                7.853,
                49.953
              ]
            ],
            [
              [
                8.113,
                49.771
              ],
              [
                7.923,
                49.915
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "31",
          "id": 4189
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.915,
                52.329
              ],
              [
                4.92,
                52.311
              ],
              [
                4.924,
                52.302
              ],
              [
                4.929,
                52.294
              ],
              [
                4.932,
                52.291
              ]
            ],
            [
              [
                4.989,
                52.141
              ],
              [
                4.981,
                52.078
              ],
              [
                4.981,
                52.074
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "35",
          "id": 4195
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.932,
                52.291
              ],
              [
                4.935,
                52.287
              ],
              [
                4.939,
                52.283
              ],
              [
                4.943,
                52.281
              ],
              [
                4.952,
                52.276
              ],
              [
                4.956,
                52.273
              ],
              [
                4.96,
                52.27
              ],
              [
                4.963,
                52.266
              ],
              [
                4.965,
                52.262
              ],
              [
                4.967,
                52.258
              ],
              [
                4.968,
                52.253
              ],
              [
                4.971,
                52.222
              ],
              [
                4.972,
                52.213
              ],
              [
                4.975,
                52.204
              ],
              [
                4.979,
                52.196
              ],
              [
                4.981,
                52.192
              ],
              [
                4.987,
                52.186
              ],
              [
                4.99,
                52.183
              ],
              [
                4.992,
                52.18
              ],
              [
                4.992,
                52.176
              ],
              [
                4.993,
                52.172
              ],
              [
                4.989,
                52.141
              ]
            ],
            [
              [
                4.981,
                52.074
              ],
              [
                4.981,
                52.072
              ],
              [
                4.983,
                52.065
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "35",
          "id": 4195
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.184,
              51.578
            ],
            [
              7.195,
              51.56
            ],
            [
              7.21,
              51.546
            ],
            [
              7.227,
              51.533
            ],
            [
              7.242,
              51.519
            ],
            [
              7.255,
              51.503
            ],
            [
              7.265,
              51.483
            ],
            [
              7.27,
              51.463
            ],
            [
              7.267,
              51.442
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "37",
          "id": 4196
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.371,
              52.029
            ],
            [
              4.377,
              52.015
            ],
            [
              4.385,
              52.003
            ],
            [
              4.445,
              51.936
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "19",
          "id": 4197
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.424,
              48.922
            ],
            [
              2.511,
              49.017
            ],
            [
              2.517,
              49.026
            ],
            [
              2.521,
              49.037
            ],
            [
              2.524,
              49.048
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 4,
          "id": 4198
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.409,
              52.061
            ],
            [
              4.402,
              52.051
            ],
            [
              4.376,
              52.04
            ],
            [
              4.371,
              52.029
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4205
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.079,
              50.041
            ],
            [
              10.074,
              50.023
            ],
            [
              10.062,
              50.007
            ],
            [
              10.034,
              49.981
            ],
            [
              10.019,
              49.962
            ],
            [
              10.006,
              49.94
            ],
            [
              9.998,
              49.916
            ],
            [
              9.997,
              49.891
            ],
            [
              10.002,
              49.875
            ],
            [
              10.012,
              49.862
            ],
            [
              10.056,
              49.824
            ],
            [
              10.089,
              49.786
            ],
            [
              10.107,
              49.762
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "43",
          "id": 4206
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.382,
              50.636
            ],
            [
              8.396,
              50.624
            ],
            [
              8.414,
              50.617
            ],
            [
              8.453,
              50.614
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "41",
          "id": 4212
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.372,
              49.527
            ],
            [
              4.329,
              49.498
            ],
            [
              4.288,
              49.466
            ],
            [
              4.263,
              49.44
            ],
            [
              4.179,
              49.327
            ],
            [
              4.153,
              49.303
            ],
            [
              4.135,
              49.291
            ],
            [
              4.115,
              49.281
            ],
            [
              4.093,
              49.273
            ],
            [
              4.071,
              49.268
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "46",
          "id": 4215
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.384,
                51.004
              ],
              [
                5.374,
                51.005
              ],
              [
                5.322,
                51.007
              ],
              [
                5.243,
                50.995
              ]
            ],
            [
              [
                5.549,
                50.971
              ],
              [
                5.522,
                50.975
              ],
              [
                5.435,
                50.994
              ]
            ],
            [
              [
                6.229,
                50.856
              ],
              [
                6.211,
                50.855
              ],
              [
                6.177,
                50.856
              ],
              [
                6.009,
                50.879
              ],
              [
                6.003,
                50.881
              ],
              [
                5.969,
                50.893
              ],
              [
                5.913,
                50.922
              ],
              [
                5.886,
                50.943
              ],
              [
                5.876,
                50.953
              ],
              [
                5.873,
                50.956
              ],
              [
                5.868,
                50.958
              ],
              [
                5.859,
                50.962
              ],
              [
                5.85,
                50.965
              ],
              [
                5.841,
                50.967
              ],
              [
                5.822,
                50.968
              ],
              [
                5.642,
                50.962
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "314",
          "id": 4218
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.435,
                50.994
              ],
              [
                5.399,
                51.003
              ],
              [
                5.384,
                51.004
              ]
            ],
            [
              [
                5.642,
                50.962
              ],
              [
                5.616,
                50.962
              ],
              [
                5.549,
                50.971
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "314",
          "id": 4218
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                0.15,
                51.67
              ],
              [
                0.123,
                51.676
              ],
              [
                0.012,
                51.685
              ]
            ],
            [
              [
                0.137,
                51.333
              ],
              [
                0.148,
                51.354
              ],
              [
                0.242,
                51.482
              ],
              [
                0.259,
                51.512
              ],
              [
                0.267,
                51.533
              ],
              [
                0.271,
                51.553
              ],
              [
                0.269,
                51.574
              ],
              [
                0.261,
                51.594
              ],
              [
                0.255,
                51.602
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4224
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                0,
                51.263
              ],
              [
                0.086,
                51.282
              ],
              [
                0.126,
                51.287
              ],
              [
                0.125,
                51.3
              ],
              [
                0.128,
                51.314
              ],
              [
                0.133,
                51.326
              ],
              [
                0.137,
                51.333
              ]
            ],
            [
              [
                0.012,
                51.685
              ],
              [
                0,
                51.686
              ]
            ],
            [
              [
                0.255,
                51.602
              ],
              [
                0.254,
                51.604
              ],
              [
                0.245,
                51.613
              ],
              [
                0.227,
                51.63
              ],
              [
                0.21,
                51.642
              ],
              [
                0.192,
                51.654
              ],
              [
                0.158,
                51.668
              ],
              [
                0.15,
                51.67
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 4224
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              0.24,
              49.263
            ],
            [
              0.229,
              49.258
            ],
            [
              0.219,
              49.254
            ],
            [
              0.208,
              49.252
            ],
            [
              0.196,
              49.25
            ],
            [
              0,
              49.243
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "46",
          "id": 4327
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                1.627,
                50.743
              ],
              [
                1.627,
                50.744
              ],
              [
                1.629,
                50.75
              ],
              [
                1.632,
                50.756
              ],
              [
                1.681,
                50.813
              ],
              [
                1.71,
                50.838
              ],
              [
                1.765,
                50.873
              ]
            ],
            [
              [
                1.659,
                50.588
              ],
              [
                1.658,
                50.595
              ],
              [
                1.658,
                50.603
              ],
              [
                1.659,
                50.611
              ],
              [
                1.663,
                50.637
              ],
              [
                1.664,
                50.646
              ],
              [
                1.663,
                50.656
              ],
              [
                1.661,
                50.666
              ],
              [
                1.658,
                50.675
              ],
              [
                1.653,
                50.684
              ],
              [
                1.649,
                50.689
              ],
              [
                1.636,
                50.704
              ],
              [
                1.632,
                50.71
              ],
              [
                1.63,
                50.714
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "402",
          "id": 4342
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              1.844,
              50.922
            ],
            [
              1.845,
              50.923
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "402",
          "id": 4342
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                1.63,
                50.714
              ],
              [
                1.628,
                50.716
              ],
              [
                1.626,
                50.724
              ],
              [
                1.626,
                50.731
              ],
              [
                1.626,
                50.738
              ],
              [
                1.627,
                50.743
              ]
            ],
            [
              [
                1.776,
                50.202
              ],
              [
                1.777,
                50.213
              ],
              [
                1.777,
                50.223
              ],
              [
                1.775,
                50.233
              ],
              [
                1.771,
                50.242
              ],
              [
                1.767,
                50.25
              ],
              [
                1.736,
                50.29
              ],
              [
                1.723,
                50.31
              ],
              [
                1.712,
                50.331
              ],
              [
                1.702,
                50.353
              ],
              [
                1.694,
                50.377
              ],
              [
                1.688,
                50.401
              ],
              [
                1.681,
                50.451
              ],
              [
                1.681,
                50.462
              ],
              [
                1.683,
                50.509
              ],
              [
                1.682,
                50.522
              ],
              [
                1.679,
                50.534
              ],
              [
                1.661,
                50.579
              ],
              [
                1.659,
                50.587
              ],
              [
                1.659,
                50.588
              ]
            ],
            [
              [
                1.765,
                50.873
              ],
              [
                1.844,
                50.922
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "402",
          "id": 4342
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.86,
              52.466
            ],
            [
              4.853,
              52.464
            ],
            [
              4.84,
              52.454
            ],
            [
              4.831,
              52.441
            ],
            [
              4.825,
              52.427
            ],
            [
              4.822,
              52.412
            ],
            [
              4.823,
              52.397
            ],
            [
              4.826,
              52.378
            ],
            [
              4.834,
              52.361
            ],
            [
              4.845,
              52.346
            ],
            [
              4.859,
              52.334
            ],
            [
              4.875,
              52.325
            ],
            [
              4.893,
              52.32
            ],
            [
              4.911,
              52.318
            ],
            [
              4.93,
              52.321
            ],
            [
              4.952,
              52.331
            ],
            [
              4.966,
              52.348
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4343
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.966,
              52.348
            ],
            [
              4.967,
              52.35
            ],
            [
              4.974,
              52.372
            ],
            [
              4.973,
              52.397
            ],
            [
              4.964,
              52.423
            ],
            [
              4.948,
              52.444
            ],
            [
              4.927,
              52.459
            ],
            [
              4.901,
              52.469
            ],
            [
              4.885,
              52.471
            ],
            [
              4.868,
              52.469
            ],
            [
              4.86,
              52.466
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 4343
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.794,
              49.746
            ],
            [
              4.773,
              49.745
            ],
            [
              4.752,
              49.743
            ],
            [
              4.731,
              49.738
            ],
            [
              4.711,
              49.732
            ],
            [
              4.693,
              49.723
            ],
            [
              4.372,
              49.527
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "46",
          "id": 4344
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.794,
              49.746
            ],
            [
              4.843,
              49.737
            ],
            [
              4.957,
              49.695
            ],
            [
              4.997,
              49.702
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "44",
          "id": 4345
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.095,
                49.383
              ],
              [
                6.097,
                49.378
              ],
              [
                6.103,
                49.371
              ],
              [
                6.111,
                49.365
              ],
              [
                6.12,
                49.361
              ],
              [
                6.13,
                49.359
              ],
              [
                6.149,
                49.358
              ],
              [
                6.163,
                49.353
              ],
              [
                6.173,
                49.344
              ],
              [
                6.18,
                49.331
              ],
              [
                6.185,
                49.317
              ],
              [
                6.187,
                49.3
              ],
              [
                6.187,
                49.24
              ],
              [
                6.187,
                49.238
              ],
              [
                6.186,
                49.237
              ],
              [
                6.18,
                49.235
              ],
              [
                6.177,
                49.233
              ],
              [
                6.174,
                49.23
              ],
              [
                6.172,
                49.227
              ],
              [
                6.17,
                49.22
              ],
              [
                6.168,
                49.196
              ]
            ],
            [
              [
                6.12,
                49.527
              ],
              [
                6.12,
                49.522
              ],
              [
                6.118,
                49.513
              ],
              [
                6.107,
                49.474
              ]
            ],
            [
              [
                6.127,
                49.584
              ],
              [
                6.123,
                49.576
              ],
              [
                6.121,
                49.567
              ],
              [
                6.119,
                49.559
              ],
              [
                6.119,
                49.557
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4358
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.107,
                49.474
              ],
              [
                6.089,
                49.413
              ],
              [
                6.088,
                49.404
              ],
              [
                6.09,
                49.395
              ],
              [
                6.093,
                49.386
              ],
              [
                6.095,
                49.383
              ]
            ],
            [
              [
                6.119,
                49.557
              ],
              [
                6.119,
                49.55
              ],
              [
                6.12,
                49.531
              ],
              [
                6.12,
                49.527
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 4358
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.488,
              50.912
            ],
            [
              4.462,
              50.919
            ],
            [
              4.453,
              50.921
            ],
            [
              4.448,
              50.92
            ],
            [
              4.405,
              50.916
            ],
            [
              4.336,
              50.902
            ],
            [
              4.324,
              50.898
            ],
            [
              4.305,
              50.887
            ],
            [
              4.294,
              50.883
            ],
            [
              4.284,
              50.881
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "19",
          "id": 4359
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.442,
              51.239
            ],
            [
              4.44,
              51.194
            ],
            [
              4.442,
              51.15
            ],
            [
              4.475,
              50.965
            ],
            [
              4.477,
              50.947
            ],
            [
              4.476,
              50.928
            ],
            [
              4.472,
              50.911
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "19",
          "id": 4360
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                1.845,
                50.923
              ],
              [
                1.862,
                50.93
              ],
              [
                1.878,
                50.934
              ],
              [
                1.895,
                50.937
              ],
              [
                1.899,
                50.937
              ]
            ],
            [
              [
                2.172,
                50.968
              ],
              [
                2.405,
                51.006
              ],
              [
                2.416,
                51.009
              ],
              [
                2.438,
                51.017
              ],
              [
                2.465,
                51.031
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "40",
          "id": 4361
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                1.899,
                50.937
              ],
              [
                2.011,
                50.941
              ],
              [
                2.172,
                50.968
              ]
            ],
            [
              [
                2.465,
                51.031
              ],
              [
                2.512,
                51.053
              ],
              [
                2.535,
                51.06
              ],
              [
                2.561,
                51.062
              ],
              [
                2.643,
                51.059
              ],
              [
                2.66,
                51.062
              ],
              [
                2.676,
                51.068
              ],
              [
                2.691,
                51.075
              ],
              [
                2.727,
                51.097
              ],
              [
                2.735,
                51.1
              ],
              [
                2.847,
                51.141
              ],
              [
                2.886,
                51.151
              ],
              [
                2.924,
                51.165
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "40",
          "id": 4361
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                2.931,
                51.168
              ],
              [
                2.969,
                51.183
              ],
              [
                2.993,
                51.189
              ],
              [
                3.017,
                51.192
              ],
              [
                3.027,
                51.192
              ]
            ],
            [
              [
                3.165,
                51.148
              ],
              [
                3.19,
                51.142
              ]
            ],
            [
              [
                3.638,
                51.026
              ],
              [
                3.75,
                50.983
              ],
              [
                3.759,
                50.981
              ],
              [
                3.784,
                50.977
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "40",
          "id": 4362
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                2.924,
                51.165
              ],
              [
                2.931,
                51.168
              ]
            ],
            [
              [
                3.027,
                51.192
              ],
              [
                3.029,
                51.192
              ],
              [
                3.054,
                51.189
              ],
              [
                3.084,
                51.182
              ],
              [
                3.121,
                51.169
              ],
              [
                3.165,
                51.148
              ],
              [
                3.165,
                51.148
              ]
            ],
            [
              [
                3.19,
                51.142
              ],
              [
                3.628,
                51.03
              ],
              [
                3.638,
                51.026
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "40",
          "id": 4362
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                3.781,
                50.976
              ],
              [
                3.794,
                50.974
              ]
            ],
            [
              [
                3.852,
                50.961
              ],
              [
                3.912,
                50.948
              ]
            ],
            [
              [
                3.933,
                50.943
              ],
              [
                4.016,
                50.925
              ],
              [
                4.114,
                50.896
              ]
            ],
            [
              [
                4.247,
                50.879
              ],
              [
                4.293,
                50.883
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "40",
          "id": 4363
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                3.794,
                50.974
              ],
              [
                3.852,
                50.961
              ]
            ],
            [
              [
                3.912,
                50.948
              ],
              [
                3.933,
                50.943
              ]
            ],
            [
              [
                4.114,
                50.896
              ],
              [
                4.164,
                50.881
              ],
              [
                4.187,
                50.877
              ],
              [
                4.21,
                50.876
              ],
              [
                4.247,
                50.879
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "40",
          "id": 4363
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.549,
              49.083
            ],
            [
              2.566,
              49.128
            ],
            [
              2.576,
              49.148
            ],
            [
              2.588,
              49.167
            ],
            [
              2.602,
              49.185
            ],
            [
              2.673,
              49.255
            ],
            [
              2.696,
              49.285
            ],
            [
              2.697,
              49.287
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "15",
          "id": 4366
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.53,
              49.035
            ],
            [
              2.549,
              49.083
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "15",
          "id": 4366
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.697,
              49.287
            ],
            [
              2.71,
              49.321
            ],
            [
              2.711,
              49.331
            ],
            [
              2.706,
              49.506
            ],
            [
              2.712,
              49.573
            ],
            [
              2.716,
              49.59
            ],
            [
              2.736,
              49.645
            ],
            [
              2.769,
              49.77
            ],
            [
              2.779,
              49.795
            ],
            [
              2.82,
              49.873
            ],
            [
              2.873,
              50.026
            ],
            [
              2.877,
              50.045
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "15",
          "id": 4366
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.877,
              50.045
            ],
            [
              2.874,
              50.121
            ],
            [
              2.864,
              50.197
            ],
            [
              2.855,
              50.243
            ],
            [
              2.854,
              50.251
            ],
            [
              2.855,
              50.259
            ],
            [
              2.856,
              50.267
            ],
            [
              2.862,
              50.283
            ],
            [
              2.887,
              50.327
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "15",
          "id": 4367
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              3.847,
              49.236
            ],
            [
              3.837,
              49.229
            ],
            [
              3.831,
              49.226
            ],
            [
              3.825,
              49.223
            ],
            [
              3.821,
              49.222
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "50",
          "id": 4368
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                3.821,
                49.222
              ],
              [
                3.82,
                49.222
              ],
              [
                3.801,
                49.219
              ],
              [
                3.791,
                49.216
              ],
              [
                3.781,
                49.212
              ],
              [
                3.773,
                49.206
              ],
              [
                3.765,
                49.197
              ],
              [
                3.747,
                49.173
              ],
              [
                3.74,
                49.166
              ],
              [
                3.733,
                49.161
              ],
              [
                3.718,
                49.153
              ],
              [
                3.71,
                49.149
              ],
              [
                3.671,
                49.135
              ],
              [
                3.63,
                49.127
              ],
              [
                3.427,
                49.106
              ],
              [
                3.401,
                49.1
              ],
              [
                3.389,
                49.096
              ],
              [
                3.377,
                49.09
              ],
              [
                3.35,
                49.068
              ],
              [
                3.34,
                49.062
              ],
              [
                3.328,
                49.058
              ],
              [
                3.315,
                49.056
              ],
              [
                3.273,
                49.056
              ],
              [
                3.243,
                49.052
              ],
              [
                3.18,
                49.031
              ],
              [
                3.111,
                48.999
              ],
              [
                3.068,
                48.972
              ],
              [
                3.059,
                48.965
              ],
              [
                3.038,
                48.947
              ],
              [
                3.03,
                48.941
              ],
              [
                3.012,
                48.931
              ],
              [
                2.993,
                48.926
              ],
              [
                2.968,
                48.922
              ]
            ],
            [
              [
                3.962,
                49.268
              ],
              [
                3.951,
                49.257
              ],
              [
                3.935,
                49.253
              ],
              [
                3.888,
                49.251
              ],
              [
                3.873,
                49.249
              ],
              [
                3.86,
                49.244
              ],
              [
                3.847,
                49.236
              ],
              [
                3.847,
                49.236
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "50",
          "id": 4368
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.286,
              48.922
            ],
            [
              4.301,
              49.021
            ],
            [
              4.301,
              49.04
            ],
            [
              4.298,
              49.059
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "17",
          "id": 4370
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.024,
              49.292
            ],
            [
              3.964,
              49.362
            ],
            [
              3.951,
              49.381
            ],
            [
              3.941,
              49.402
            ],
            [
              3.909,
              49.481
            ],
            [
              3.9,
              49.499
            ],
            [
              3.889,
              49.516
            ],
            [
              3.874,
              49.532
            ],
            [
              3.856,
              49.545
            ],
            [
              3.836,
              49.555
            ],
            [
              3.815,
              49.561
            ],
            [
              3.747,
              49.574
            ],
            [
              3.716,
              49.586
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "17",
          "id": 4371
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              3.716,
              49.586
            ],
            [
              3.632,
              49.641
            ],
            [
              3.617,
              49.649
            ],
            [
              3.503,
              49.687
            ],
            [
              3.485,
              49.696
            ],
            [
              3.469,
              49.706
            ],
            [
              3.41,
              49.752
            ],
            [
              3.309,
              49.816
            ],
            [
              3.291,
              49.831
            ],
            [
              3.282,
              49.839
            ],
            [
              3.275,
              49.848
            ],
            [
              3.268,
              49.858
            ],
            [
              3.262,
              49.868
            ],
            [
              3.236,
              49.931
            ],
            [
              3.225,
              49.951
            ],
            [
              3.2,
              49.988
            ],
            [
              3.186,
              50.012
            ],
            [
              3.181,
              50.024
            ],
            [
              3.176,
              50.037
            ],
            [
              3.157,
              50.115
            ],
            [
              3.152,
              50.126
            ],
            [
              3.147,
              50.137
            ],
            [
              3.141,
              50.148
            ],
            [
              3.133,
              50.158
            ],
            [
              3.125,
              50.167
            ],
            [
              3.116,
              50.176
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "17",
          "id": 4372
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              3.122,
              50.17
            ],
            [
              3.079,
              50.218
            ],
            [
              3.032,
              50.249
            ],
            [
              2.923,
              50.303
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "17",
          "id": 4373
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.257,
              50.674
            ],
            [
              2.241,
              50.693
            ],
            [
              2.232,
              50.7
            ],
            [
              2.125,
              50.768
            ],
            [
              2.061,
              50.819
            ],
            [
              2.04,
              50.838
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "15",
          "id": 4374
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              2.757,
              50.426
            ],
            [
              2.745,
              50.435
            ],
            [
              2.741,
              50.438
            ],
            [
              2.739,
              50.442
            ],
            [
              2.736,
              50.446
            ],
            [
              2.731,
              50.454
            ],
            [
              2.72,
              50.481
            ],
            [
              2.714,
              50.489
            ],
            [
              2.708,
              50.495
            ],
            [
              2.7,
              50.5
            ],
            [
              2.691,
              50.503
            ],
            [
              2.673,
              50.508
            ],
            [
              2.636,
              50.515
            ],
            [
              2.514,
              50.526
            ],
            [
              2.475,
              50.534
            ],
            [
              2.456,
              50.54
            ],
            [
              2.444,
              50.547
            ],
            [
              2.436,
              50.553
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "15",
          "id": 4374
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                2.04,
                50.838
              ],
              [
                1.939,
                50.935
              ]
            ],
            [
              [
                2.436,
                50.553
              ],
              [
                2.412,
                50.572
              ],
              [
                2.393,
                50.583
              ],
              [
                2.321,
                50.615
              ],
              [
                2.311,
                50.621
              ],
              [
                2.301,
                50.627
              ],
              [
                2.292,
                50.634
              ],
              [
                2.284,
                50.642
              ],
              [
                2.257,
                50.674
              ]
            ],
            [
              [
                2.923,
                50.303
              ],
              [
                2.897,
                50.325
              ],
              [
                2.811,
                50.379
              ],
              [
                2.803,
                50.384
              ],
              [
                2.775,
                50.412
              ],
              [
                2.757,
                50.426
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "15",
          "id": 4374
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.155,
              49.194
            ],
            [
              4.181,
              49.184
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "17",
          "id": 4375
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.077,
                49.256
              ],
              [
                4.077,
                49.244
              ],
              [
                4.082,
                49.234
              ],
              [
                4.09,
                49.225
              ],
              [
                4.1,
                49.218
              ],
              [
                4.113,
                49.21
              ],
              [
                4.155,
                49.194
              ]
            ],
            [
              [
                4.181,
                49.184
              ],
              [
                4.181,
                49.184
              ],
              [
                4.192,
                49.178
              ],
              [
                4.203,
                49.171
              ],
              [
                4.221,
                49.155
              ],
              [
                4.251,
                49.118
              ],
              [
                4.304,
                49.045
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "17",
          "id": 4375
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                1.031,
                49.352
              ],
              [
                1.037,
                49.333
              ],
              [
                1.044,
                49.315
              ],
              [
                1.053,
                49.298
              ],
              [
                1.065,
                49.282
              ],
              [
                1.066,
                49.281
              ]
            ],
            [
              [
                1.841,
                48.948
              ],
              [
                1.86,
                48.951
              ],
              [
                1.882,
                48.951
              ],
              [
                1.896,
                48.949
              ],
              [
                1.91,
                48.945
              ],
              [
                1.923,
                48.939
              ],
              [
                1.942,
                48.928
              ],
              [
                1.944,
                48.926
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "5",
          "id": 4377
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                1.066,
                49.281
              ],
              [
                1.076,
                49.269
              ],
              [
                1.089,
                49.258
              ],
              [
                1.103,
                49.248
              ],
              [
                1.117,
                49.239
              ],
              [
                1.249,
                49.176
              ],
              [
                1.328,
                49.123
              ],
              [
                1.419,
                49.072
              ],
              [
                1.726,
                48.943
              ],
              [
                1.738,
                48.939
              ],
              [
                1.75,
                48.937
              ],
              [
                1.761,
                48.937
              ],
              [
                1.783,
                48.939
              ],
              [
                1.841,
                48.948
              ]
            ],
            [
              [
                1.944,
                48.926
              ],
              [
                1.949,
                48.923
              ],
              [
                1.949,
                48.922
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "5",
          "id": 4377
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              0.245,
              49.473
            ],
            [
              0.247,
              49.478
            ],
            [
              0.26,
              49.496
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "44",
          "id": 4378
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                0.227,
                49.264
              ],
              [
                0.235,
                49.265
              ],
              [
                0.242,
                49.269
              ],
              [
                0.247,
                49.276
              ],
              [
                0.246,
                49.285
              ],
              [
                0.242,
                49.291
              ],
              [
                0.235,
                49.293
              ],
              [
                0.227,
                49.294
              ],
              [
                0.213,
                49.294
              ],
              [
                0.202,
                49.295
              ],
              [
                0.192,
                49.297
              ],
              [
                0.187,
                49.299
              ],
              [
                0.183,
                49.301
              ],
              [
                0.18,
                49.304
              ],
              [
                0.178,
                49.308
              ],
              [
                0.178,
                49.312
              ],
              [
                0.179,
                49.317
              ],
              [
                0.181,
                49.321
              ],
              [
                0.184,
                49.324
              ],
              [
                0.187,
                49.327
              ],
              [
                0.191,
                49.33
              ],
              [
                0.221,
                49.35
              ],
              [
                0.228,
                49.357
              ],
              [
                0.234,
                49.364
              ],
              [
                0.238,
                49.372
              ],
              [
                0.241,
                49.382
              ],
              [
                0.242,
                49.391
              ],
              [
                0.24,
                49.409
              ],
              [
                0.236,
                49.429
              ],
              [
                0.235,
                49.438
              ],
              [
                0.236,
                49.448
              ],
              [
                0.237,
                49.457
              ],
              [
                0.241,
                49.466
              ],
              [
                0.245,
                49.473
              ]
            ],
            [
              [
                0.26,
                49.496
              ],
              [
                0.264,
                49.501
              ],
              [
                0.27,
                49.508
              ],
              [
                0.277,
                49.514
              ],
              [
                0.284,
                49.519
              ],
              [
                0.292,
                49.522
              ],
              [
                0.302,
                49.525
              ],
              [
                0.322,
                49.528
              ],
              [
                0.35,
                49.53
              ],
              [
                0.36,
                49.532
              ],
              [
                0.369,
                49.535
              ],
              [
                0.377,
                49.54
              ],
              [
                0.402,
                49.557
              ],
              [
                0.419,
                49.566
              ],
              [
                0.613,
                49.635
              ],
              [
                0.653,
                49.644
              ],
              [
                0.669,
                49.647
              ],
              [
                0.694,
                49.648
              ],
              [
                0.81,
                49.667
              ],
              [
                0.837,
                49.668
              ],
              [
                0.864,
                49.665
              ],
              [
                1.011,
                49.64
              ],
              [
                1.173,
                49.635
              ],
              [
                1.233,
                49.643
              ],
              [
                1.251,
                49.647
              ],
              [
                1.272,
                49.655
              ],
              [
                1.276,
                49.657
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "44",
          "id": 4378
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              1.119,
              49.481
            ],
            [
              1.104,
              49.47
            ],
            [
              1.079,
              49.444
            ],
            [
              1.065,
              49.426
            ],
            [
              1.061,
              49.42
            ],
            [
              1.058,
              49.413
            ],
            [
              1.048,
              49.375
            ],
            [
              1.047,
              49.371
            ],
            [
              1.038,
              49.358
            ],
            [
              1.035,
              49.356
            ],
            [
              1.022,
              49.345
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4380
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              1.28,
              49.662
            ],
            [
              1.277,
              49.652
            ],
            [
              1.275,
              49.642
            ],
            [
              1.274,
              49.638
            ],
            [
              1.276,
              49.595
            ],
            [
              1.274,
              49.585
            ],
            [
              1.272,
              49.58
            ],
            [
              1.27,
              49.575
            ],
            [
              1.265,
              49.566
            ],
            [
              1.262,
              49.562
            ],
            [
              1.252,
              49.551
            ],
            [
              1.244,
              49.545
            ],
            [
              1.236,
              49.54
            ],
            [
              1.131,
              49.49
            ],
            [
              1.119,
              49.481
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 4380
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.474,
                50.809
              ],
              [
                4.476,
                50.801
              ],
              [
                4.481,
                50.794
              ],
              [
                4.486,
                50.787
              ],
              [
                4.537,
                50.741
              ],
              [
                4.579,
                50.713
              ],
              [
                4.624,
                50.69
              ],
              [
                4.671,
                50.673
              ]
            ],
            [
              [
                4.874,
                50.507
              ],
              [
                4.886,
                50.495
              ],
              [
                4.952,
                50.444
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "411",
          "id": 4381
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.671,
                50.673
              ],
              [
                4.744,
                50.646
              ],
              [
                4.767,
                50.634
              ],
              [
                4.789,
                50.621
              ],
              [
                4.806,
                50.606
              ],
              [
                4.819,
                50.588
              ],
              [
                4.854,
                50.53
              ],
              [
                4.861,
                50.52
              ],
              [
                4.869,
                50.511
              ],
              [
                4.874,
                50.507
              ]
            ],
            [
              [
                4.952,
                50.444
              ],
              [
                4.967,
                50.433
              ],
              [
                4.981,
                50.419
              ],
              [
                4.992,
                50.403
              ],
              [
                4.998,
                50.394
              ],
              [
                5.056,
                50.189
              ],
              [
                5.066,
                50.165
              ],
              [
                5.074,
                50.15
              ],
              [
                5.083,
                50.138
              ],
              [
                5.094,
                50.126
              ],
              [
                5.107,
                50.116
              ],
              [
                5.174,
                50.073
              ],
              [
                5.189,
                50.061
              ],
              [
                5.202,
                50.047
              ],
              [
                5.212,
                50.031
              ],
              [
                5.219,
                50.013
              ],
              [
                5.222,
                49.998
              ],
              [
                5.226,
                49.952
              ],
              [
                5.227,
                49.945
              ],
              [
                5.229,
                49.939
              ],
              [
                5.232,
                49.933
              ],
              [
                5.236,
                49.927
              ],
              [
                5.242,
                49.922
              ],
              [
                5.25,
                49.918
              ],
              [
                5.258,
                49.915
              ],
              [
                5.266,
                49.913
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "411",
          "id": 4381
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.495,
              49.861
            ],
            [
              5.508,
              49.844
            ],
            [
              5.533,
              49.786
            ],
            [
              5.545,
              49.766
            ],
            [
              5.561,
              49.749
            ],
            [
              5.579,
              49.736
            ],
            [
              5.6,
              49.725
            ],
            [
              5.621,
              49.717
            ],
            [
              5.715,
              49.694
            ],
            [
              5.743,
              49.682
            ],
            [
              5.801,
              49.665
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "25",
          "id": 4382
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.801,
              49.665
            ],
            [
              5.959,
              49.635
            ],
            [
              5.977,
              49.629
            ],
            [
              5.994,
              49.622
            ],
            [
              6.01,
              49.612
            ],
            [
              6.024,
              49.6
            ],
            [
              6.053,
              49.57
            ],
            [
              6.068,
              49.558
            ],
            [
              6.076,
              49.553
            ],
            [
              6.084,
              49.549
            ],
            [
              6.1,
              49.544
            ],
            [
              6.117,
              49.542
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "25",
          "id": 4383
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.463,
              51.296
            ],
            [
              4.455,
              51.291
            ],
            [
              4.448,
              51.282
            ],
            [
              4.442,
              51.273
            ],
            [
              4.439,
              51.263
            ],
            [
              4.44,
              51.251
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "19",
          "id": 4384
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.74,
              51.483
            ],
            [
              4.685,
              51.4
            ],
            [
              4.651,
              51.365
            ],
            [
              4.608,
              51.339
            ],
            [
              4.586,
              51.331
            ],
            [
              4.499,
              51.313
            ],
            [
              4.484,
              51.308
            ],
            [
              4.469,
              51.3
            ],
            [
              4.463,
              51.296
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "19",
          "id": 4384
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.168,
              49.204
            ],
            [
              6.182,
              49.174
            ],
            [
              6.176,
              49.144
            ],
            [
              6.159,
              49.116
            ],
            [
              6.126,
              49.072
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "21",
          "id": 4394
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.126,
              49.072
            ],
            [
              6.12,
              49.064
            ],
            [
              6.113,
              49.049
            ],
            [
              6.085,
              48.922
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "21",
          "id": 4394
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.496,
              49.865
            ],
            [
              5.489,
              49.871
            ],
            [
              5.482,
              49.875
            ],
            [
              5.474,
              49.877
            ],
            [
              5.435,
              49.879
            ],
            [
              5.425,
              49.88
            ],
            [
              5.361,
              49.898
            ],
            [
              5.34,
              49.902
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "25",
          "id": 4400
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.402,
              48.987
            ],
            [
              8.387,
              48.979
            ],
            [
              8.376,
              48.966
            ],
            [
              8.359,
              48.936
            ],
            [
              8.353,
              48.926
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "35",
          "id": 4401
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.353,
              48.926
            ],
            [
              8.35,
              48.922
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "35",
          "id": 4401
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.47,
              49.362
            ],
            [
              8.444,
              49.367
            ],
            [
              8.431,
              49.372
            ],
            [
              8.423,
              49.376
            ],
            [
              8.366,
              49.416
            ],
            [
              8.359,
              49.422
            ],
            [
              8.353,
              49.429
            ],
            [
              8.347,
              49.437
            ],
            [
              8.343,
              49.445
            ],
            [
              8.338,
              49.458
            ],
            [
              8.323,
              49.519
            ],
            [
              8.322,
              49.526
            ],
            [
              8.322,
              49.555
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "50",
          "id": 4402
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.846,
              50.982
            ],
            [
              7.866,
              50.949
            ],
            [
              7.891,
              50.922
            ],
            [
              7.921,
              50.9
            ],
            [
              7.955,
              50.883
            ],
            [
              8.06,
              50.844
            ],
            [
              8.102,
              50.824
            ],
            [
              8.11,
              50.82
            ],
            [
              8.117,
              50.814
            ],
            [
              8.123,
              50.808
            ],
            [
              8.133,
              50.792
            ],
            [
              8.139,
              50.785
            ],
            [
              8.147,
              50.779
            ],
            [
              8.156,
              50.774
            ],
            [
              8.167,
              50.772
            ],
            [
              8.209,
              50.763
            ],
            [
              8.23,
              50.756
            ],
            [
              8.242,
              50.751
            ],
            [
              8.253,
              50.745
            ],
            [
              8.263,
              50.737
            ],
            [
              8.271,
              50.726
            ],
            [
              8.294,
              50.682
            ],
            [
              8.303,
              50.668
            ],
            [
              8.312,
              50.659
            ],
            [
              8.323,
              50.651
            ],
            [
              8.335,
              50.645
            ],
            [
              8.389,
              50.629
            ],
            [
              8.402,
              50.624
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "41",
          "id": 4403
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.021,
              52.349
            ],
            [
              8.035,
              52.321
            ],
            [
              8.036,
              52.317
            ],
            [
              8.037,
              52.313
            ],
            [
              8.037,
              52.308
            ],
            [
              8.036,
              52.305
            ],
            [
              8.033,
              52.302
            ],
            [
              8.03,
              52.299
            ],
            [
              8.027,
              52.297
            ],
            [
              8.023,
              52.295
            ],
            [
              7.999,
              52.289
            ],
            [
              7.981,
              52.282
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "37",
          "id": 4404
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.212,
              52.823
            ],
            [
              8.196,
              52.766
            ],
            [
              8.195,
              52.761
            ],
            [
              8.194,
              52.734
            ],
            [
              8.197,
              52.694
            ],
            [
              8.197,
              52.686
            ],
            [
              8.195,
              52.677
            ],
            [
              8.192,
              52.67
            ],
            [
              8.187,
              52.663
            ],
            [
              8.185,
              52.659
            ],
            [
              8.182,
              52.656
            ],
            [
              8.14,
              52.626
            ],
            [
              8.134,
              52.619
            ],
            [
              8.131,
              52.615
            ],
            [
              8.128,
              52.611
            ],
            [
              8.126,
              52.606
            ],
            [
              8.124,
              52.602
            ],
            [
              8.123,
              52.597
            ],
            [
              8.119,
              52.563
            ],
            [
              8.117,
              52.554
            ],
            [
              8.114,
              52.546
            ],
            [
              8.097,
              52.511
            ],
            [
              8.076,
              52.479
            ],
            [
              8.038,
              52.432
            ],
            [
              8.033,
              52.425
            ],
            [
              8.029,
              52.417
            ],
            [
              8.017,
              52.382
            ],
            [
              8.016,
              52.378
            ],
            [
              8.016,
              52.369
            ],
            [
              8.017,
              52.36
            ],
            [
              8.02,
              52.352
            ],
            [
              8.021,
              52.349
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "37",
          "id": 4404
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.248,
              53.118
            ],
            [
              8.247,
              53.118
            ],
            [
              8.246,
              53.118
            ],
            [
              8.241,
              53.118
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4405
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.227,
              52.857
            ],
            [
              8.203,
              52.874
            ],
            [
              8.198,
              52.879
            ],
            [
              8.194,
              52.885
            ],
            [
              8.19,
              52.89
            ],
            [
              8.182,
              52.905
            ],
            [
              8.177,
              52.92
            ],
            [
              8.176,
              52.935
            ],
            [
              8.179,
              52.951
            ],
            [
              8.19,
              52.983
            ],
            [
              8.241,
              53.072
            ],
            [
              8.245,
              53.084
            ],
            [
              8.248,
              53.097
            ],
            [
              8.249,
              53.103
            ],
            [
              8.25,
              53.112
            ],
            [
              8.25,
              53.116
            ],
            [
              8.249,
              53.117
            ],
            [
              8.249,
              53.118
            ],
            [
              8.248,
              53.118
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 4405
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.717,
              53.037
            ],
            [
              8.697,
              53.03
            ],
            [
              8.679,
              53.021
            ],
            [
              8.667,
              53.013
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "22",
          "id": 4406
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.667,
              53.013
            ],
            [
              8.615,
              52.977
            ],
            [
              8.605,
              52.971
            ],
            [
              8.593,
              52.968
            ],
            [
              8.581,
              52.967
            ],
            [
              8.556,
              52.966
            ],
            [
              8.544,
              52.965
            ],
            [
              8.534,
              52.961
            ],
            [
              8.524,
              52.956
            ],
            [
              8.496,
              52.938
            ],
            [
              8.487,
              52.933
            ],
            [
              8.476,
              52.93
            ],
            [
              8.4,
              52.92
            ],
            [
              8.357,
              52.904
            ],
            [
              8.286,
              52.887
            ],
            [
              8.269,
              52.881
            ],
            [
              8.256,
              52.874
            ],
            [
              8.247,
              52.869
            ],
            [
              8.239,
              52.862
            ],
            [
              8.228,
              52.851
            ],
            [
              8.223,
              52.845
            ],
            [
              8.219,
              52.838
            ],
            [
              8.212,
              52.823
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4406
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.988,
              52.067
            ],
            [
              4.985,
              52.057
            ],
            [
              4.984,
              52.055
            ],
            [
              4.986,
              52.047
            ],
            [
              4.987,
              52.042
            ],
            [
              4.993,
              52.027
            ],
            [
              4.995,
              52.023
            ],
            [
              4.997,
              52.009
            ],
            [
              4.999,
              52.004
            ],
            [
              5.001,
              52
            ],
            [
              5.013,
              51.987
            ],
            [
              5.026,
              51.975
            ],
            [
              5.057,
              51.953
            ],
            [
              5.156,
              51.894
            ],
            [
              5.169,
              51.881
            ],
            [
              5.18,
              51.867
            ],
            [
              5.187,
              51.851
            ],
            [
              5.19,
              51.844
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "25",
          "id": 4407
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.279,
                51.755
              ],
              [
                5.28,
                51.754
              ],
              [
                5.292,
                51.739
              ],
              [
                5.295,
                51.735
              ],
              [
                5.298,
                51.73
              ],
              [
                5.3,
                51.721
              ],
              [
                5.3,
                51.711
              ],
              [
                5.298,
                51.692
              ],
              [
                5.297,
                51.687
              ],
              [
                5.3,
                51.668
              ],
              [
                5.307,
                51.644
              ],
              [
                5.314,
                51.627
              ],
              [
                5.324,
                51.611
              ],
              [
                5.33,
                51.603
              ],
              [
                5.336,
                51.596
              ],
              [
                5.341,
                51.591
              ]
            ],
            [
              [
                5.392,
                51.543
              ],
              [
                5.394,
                51.541
              ],
              [
                5.398,
                51.534
              ],
              [
                5.399,
                51.53
              ],
              [
                5.4,
                51.528
              ],
              [
                5.4,
                51.526
              ],
              [
                5.4,
                51.508
              ],
              [
                5.403,
                51.479
              ],
              [
                5.402,
                51.471
              ],
              [
                5.401,
                51.464
              ],
              [
                5.4,
                51.46
              ],
              [
                5.399,
                51.456
              ],
              [
                5.394,
                51.447
              ],
              [
                5.392,
                51.443
              ],
              [
                5.392,
                51.44
              ],
              [
                5.395,
                51.438
              ],
              [
                5.404,
                51.435
              ],
              [
                5.413,
                51.433
              ],
              [
                5.422,
                51.432
              ],
              [
                5.459,
                51.431
              ],
              [
                5.473,
                51.427
              ],
              [
                5.482,
                51.418
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "25",
          "id": 4408
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.19,
                51.844
              ],
              [
                5.191,
                51.837
              ],
              [
                5.191,
                51.835
              ],
              [
                5.19,
                51.833
              ],
              [
                5.184,
                51.827
              ],
              [
                5.182,
                51.824
              ],
              [
                5.181,
                51.819
              ],
              [
                5.18,
                51.815
              ],
              [
                5.182,
                51.811
              ],
              [
                5.189,
                51.805
              ],
              [
                5.198,
                51.802
              ],
              [
                5.245,
                51.793
              ],
              [
                5.254,
                51.79
              ],
              [
                5.264,
                51.786
              ],
              [
                5.266,
                51.784
              ],
              [
                5.272,
                51.779
              ],
              [
                5.274,
                51.776
              ],
              [
                5.275,
                51.771
              ],
              [
                5.276,
                51.762
              ],
              [
                5.278,
                51.758
              ],
              [
                5.279,
                51.755
              ]
            ],
            [
              [
                5.341,
                51.591
              ],
              [
                5.389,
                51.548
              ],
              [
                5.392,
                51.543
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "25",
          "id": 4408
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.642,
              51.729
            ],
            [
              4.642,
              51.726
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "national_park",
          "shield_text": "19",
          "id": 4409
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.445,
                51.936
              ],
              [
                4.475,
                51.913
              ],
              [
                4.573,
                51.853
              ],
              [
                4.588,
                51.842
              ],
              [
                4.601,
                51.83
              ],
              [
                4.613,
                51.817
              ],
              [
                4.624,
                51.802
              ],
              [
                4.628,
                51.793
              ],
              [
                4.632,
                51.784
              ],
              [
                4.635,
                51.775
              ],
              [
                4.638,
                51.766
              ],
              [
                4.64,
                51.747
              ]
            ],
            [
              [
                4.648,
                51.701
              ],
              [
                4.651,
                51.694
              ]
            ],
            [
              [
                4.693,
                51.639
              ],
              [
                4.706,
                51.624
              ],
              [
                4.715,
                51.611
              ],
              [
                4.727,
                51.579
              ],
              [
                4.728,
                51.575
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "19",
          "id": 4409
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.64,
                51.747
              ],
              [
                4.642,
                51.729
              ]
            ],
            [
              [
                4.642,
                51.726
              ],
              [
                4.643,
                51.717
              ],
              [
                4.648,
                51.701
              ],
              [
                4.648,
                51.701
              ]
            ],
            [
              [
                4.651,
                51.694
              ],
              [
                4.655,
                51.686
              ],
              [
                4.664,
                51.672
              ],
              [
                4.693,
                51.639
              ]
            ],
            [
              [
                4.728,
                51.575
              ],
              [
                4.733,
                51.546
              ],
              [
                4.735,
                51.478
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "19",
          "id": 4409
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.831,
              52.396
            ],
            [
              4.805,
              52.361
            ],
            [
              4.772,
              52.334
            ],
            [
              4.512,
              52.178
            ],
            [
              4.476,
              52.147
            ],
            [
              4.458,
              52.127
            ],
            [
              4.441,
              52.105
            ],
            [
              4.412,
              52.058
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "19",
          "id": 4410
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.971,
                52.342
              ],
              [
                4.97,
                52.343
              ],
              [
                4.961,
                52.349
              ]
            ],
            [
              [
                5.215,
                52.262
              ],
              [
                5.147,
                52.285
              ]
            ],
            [
              [
                5.315,
                52.227
              ],
              [
                5.224,
                52.259
              ]
            ],
            [
              [
                5.369,
                52.208
              ],
              [
                5.365,
                52.21
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "231",
          "id": 4411
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.147,
                52.285
              ],
              [
                5.05,
                52.318
              ],
              [
                4.991,
                52.334
              ],
              [
                4.98,
                52.338
              ],
              [
                4.971,
                52.342
              ]
            ],
            [
              [
                5.224,
                52.259
              ],
              [
                5.215,
                52.262
              ]
            ],
            [
              [
                5.365,
                52.21
              ],
              [
                5.315,
                52.227
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "231",
          "id": 4411
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.387,
              53.105
            ],
            [
              5.384,
              53.105
            ],
            [
              5.336,
              53.087
            ],
            [
              5.111,
              52.979
            ],
            [
              5.073,
              52.953
            ],
            [
              5.063,
              52.945
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "22",
          "id": 4412
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.063,
                52.945
              ],
              [
                5.062,
                52.944
              ],
              [
                5.058,
                52.939
              ],
              [
                5.054,
                52.934
              ],
              [
                5.049,
                52.926
              ],
              [
                5.046,
                52.917
              ],
              [
                5.041,
                52.9
              ]
            ],
            [
              [
                5.433,
                53.112
              ],
              [
                5.387,
                53.105
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4412
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.041,
              52.9
            ],
            [
              5.035,
              52.851
            ],
            [
              5.05,
              52.703
            ],
            [
              5.049,
              52.695
            ],
            [
              5.044,
              52.688
            ],
            [
              5.001,
              52.646
            ],
            [
              4.947,
              52.579
            ],
            [
              4.933,
              52.565
            ],
            [
              4.925,
              52.558
            ],
            [
              4.866,
              52.522
            ],
            [
              4.861,
              52.519
            ],
            [
              4.858,
              52.515
            ],
            [
              4.858,
              52.51
            ],
            [
              4.859,
              52.508
            ],
            [
              4.86,
              52.506
            ],
            [
              4.864,
              52.502
            ],
            [
              4.872,
              52.492
            ],
            [
              4.875,
              52.488
            ],
            [
              4.877,
              52.483
            ],
            [
              4.879,
              52.478
            ],
            [
              4.88,
              52.473
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4413
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.432,
              53.109
            ],
            [
              5.455,
              53.097
            ],
            [
              5.48,
              53.088
            ],
            [
              5.53,
              53.074
            ],
            [
              5.676,
              53.015
            ],
            [
              5.72,
              53.004
            ],
            [
              5.73,
              52.999
            ],
            [
              5.734,
              52.997
            ],
            [
              5.741,
              52.992
            ],
            [
              5.744,
              52.991
            ],
            [
              5.75,
              52.988
            ],
            [
              5.758,
              52.985
            ],
            [
              5.763,
              52.985
            ],
            [
              5.797,
              52.983
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4414
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.938,
              52.313
            ],
            [
              6.77,
              52.312
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "30",
          "id": 4415
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.77,
                52.312
              ],
              [
                6.652,
                52.311
              ],
              [
                6.613,
                52.307
              ],
              [
                6.467,
                52.275
              ],
              [
                6.321,
                52.262
              ],
              [
                6.085,
                52.21
              ],
              [
                6.037,
                52.207
              ]
            ],
            [
              [
                6.965,
                52.313
              ],
              [
                6.938,
                52.313
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "30",
          "id": 4415
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.464,
              52.178
            ],
            [
              5.432,
              52.187
            ],
            [
              5.368,
              52.213
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "30",
          "id": 4416
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.045,
              52.207
            ],
            [
              6.029,
              52.198
            ],
            [
              6.012,
              52.192
            ],
            [
              5.977,
              52.185
            ],
            [
              5.941,
              52.179
            ],
            [
              5.905,
              52.178
            ],
            [
              5.877,
              52.181
            ],
            [
              5.796,
              52.196
            ],
            [
              5.741,
              52.198
            ],
            [
              5.499,
              52.174
            ],
            [
              5.465,
              52.178
            ],
            [
              5.464,
              52.178
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "30",
          "id": 4416
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.789,
              52.976
            ],
            [
              5.862,
              52.994
            ],
            [
              5.983,
              53.014
            ],
            [
              5.991,
              53.017
            ],
            [
              5.998,
              53.021
            ],
            [
              6.004,
              53.027
            ],
            [
              6.041,
              53.078
            ],
            [
              6.062,
              53.098
            ],
            [
              6.07,
              53.103
            ],
            [
              6.079,
              53.108
            ],
            [
              6.098,
              53.114
            ],
            [
              6.107,
              53.116
            ],
            [
              6.145,
              53.121
            ],
            [
              6.164,
              53.127
            ],
            [
              6.173,
              53.13
            ],
            [
              6.181,
              53.134
            ],
            [
              6.195,
              53.144
            ],
            [
              6.203,
              53.148
            ],
            [
              6.423,
              53.21
            ],
            [
              6.432,
              53.212
            ],
            [
              6.454,
              53.212
            ],
            [
              6.573,
              53.201
            ],
            [
              6.61,
              53.202
            ],
            [
              6.648,
              53.199
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4417
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.93,
              51.016
            ],
            [
              6.854,
              50.987
            ],
            [
              6.837,
              50.979
            ],
            [
              6.822,
              50.969
            ],
            [
              6.818,
              50.966
            ],
            [
              6.815,
              50.963
            ],
            [
              6.809,
              50.956
            ],
            [
              6.807,
              50.953
            ],
            [
              6.806,
              50.95
            ],
            [
              6.805,
              50.948
            ],
            [
              6.805,
              50.944
            ],
            [
              6.807,
              50.935
            ],
            [
              6.807,
              50.93
            ],
            [
              6.806,
              50.925
            ],
            [
              6.805,
              50.924
            ],
            [
              6.804,
              50.922
            ],
            [
              6.803,
              50.921
            ],
            [
              6.801,
              50.92
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4418
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.995,
              51.024
            ],
            [
              6.977,
              51.023
            ],
            [
              6.939,
              51.017
            ],
            [
              6.921,
              51.015
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "35",
          "id": 4419
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.466,
              50.007
            ],
            [
              8.471,
              49.998
            ],
            [
              8.472,
              49.996
            ],
            [
              8.473,
              49.989
            ],
            [
              8.473,
              49.985
            ],
            [
              8.472,
              49.98
            ],
            [
              8.468,
              49.962
            ],
            [
              8.467,
              49.957
            ],
            [
              8.466,
              49.951
            ],
            [
              8.467,
              49.947
            ],
            [
              8.467,
              49.942
            ],
            [
              8.469,
              49.938
            ],
            [
              8.471,
              49.934
            ],
            [
              8.481,
              49.92
            ],
            [
              8.495,
              49.908
            ],
            [
              8.51,
              49.898
            ],
            [
              8.613,
              49.851
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 4420
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.498,
                51.394
              ],
              [
                5.486,
                51.407
              ],
              [
                5.475,
                51.425
              ]
            ],
            [
              [
                5.733,
                51.265
              ],
              [
                5.671,
                51.274
              ],
              [
                5.659,
                51.279
              ]
            ],
            [
              [
                5.815,
                50.964
              ],
              [
                5.838,
                51.048
              ],
              [
                5.858,
                51.098
              ],
              [
                5.862,
                51.115
              ],
              [
                5.863,
                51.124
              ],
              [
                5.861,
                51.134
              ],
              [
                5.859,
                51.143
              ],
              [
                5.851,
                51.163
              ],
              [
                5.839,
                51.183
              ],
              [
                5.818,
                51.21
              ],
              [
                5.816,
                51.212
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "25",
          "id": 4421
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                5.659,
                51.279
              ],
              [
                5.65,
                51.282
              ],
              [
                5.631,
                51.294
              ],
              [
                5.582,
                51.338
              ],
              [
                5.565,
                51.349
              ],
              [
                5.514,
                51.38
              ],
              [
                5.499,
                51.393
              ],
              [
                5.498,
                51.394
              ]
            ],
            [
              [
                5.816,
                51.212
              ],
              [
                5.802,
                51.227
              ],
              [
                5.784,
                51.242
              ],
              [
                5.765,
                51.255
              ],
              [
                5.742,
                51.264
              ],
              [
                5.733,
                51.265
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "25",
          "id": 4421
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.992,
                51.028
              ],
              [
                7.049,
                51.04
              ],
              [
                7.068,
                51.046
              ],
              [
                7.077,
                51.051
              ],
              [
                7.086,
                51.056
              ],
              [
                7.09,
                51.06
              ],
              [
                7.092,
                51.064
              ],
              [
                7.097,
                51.073
              ],
              [
                7.098,
                51.073
              ]
            ],
            [
              [
                7.217,
                51.167
              ],
              [
                7.221,
                51.171
              ],
              [
                7.23,
                51.185
              ],
              [
                7.239,
                51.2
              ],
              [
                7.243,
                51.209
              ],
              [
                7.245,
                51.219
              ],
              [
                7.246,
                51.229
              ],
              [
                7.245,
                51.239
              ],
              [
                7.238,
                51.268
              ],
              [
                7.237,
                51.278
              ],
              [
                7.238,
                51.296
              ],
              [
                7.241,
                51.309
              ]
            ],
            [
              [
                7.258,
                51.407
              ],
              [
                7.261,
                51.423
              ],
              [
                7.267,
                51.442
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "37",
          "id": 4422
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.098,
                51.073
              ],
              [
                7.103,
                51.08
              ],
              [
                7.109,
                51.086
              ],
              [
                7.117,
                51.09
              ],
              [
                7.163,
                51.111
              ],
              [
                7.167,
                51.113
              ],
              [
                7.171,
                51.115
              ],
              [
                7.178,
                51.121
              ],
              [
                7.189,
                51.132
              ],
              [
                7.217,
                51.167
              ]
            ],
            [
              [
                7.241,
                51.309
              ],
              [
                7.258,
                51.407
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "37",
          "id": 4422
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.918,
              52.254
            ],
            [
              7.914,
              52.252
            ],
            [
              7.829,
              52.221
            ],
            [
              7.808,
              52.211
            ],
            [
              7.801,
              52.207
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "37",
          "id": 4423
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.555,
                51.967
              ],
              [
                7.552,
                51.956
              ],
              [
                7.549,
                51.948
              ],
              [
                7.544,
                51.941
              ],
              [
                7.539,
                51.937
              ]
            ],
            [
              [
                7.96,
                52.291
              ],
              [
                7.947,
                52.274
              ],
              [
                7.945,
                52.273
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "37",
          "id": 4423
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.539,
                51.937
              ],
              [
                7.538,
                51.936
              ]
            ],
            [
              [
                7.801,
                52.207
              ],
              [
                7.762,
                52.184
              ],
              [
                7.718,
                52.154
              ],
              [
                7.637,
                52.085
              ],
              [
                7.6,
                52.043
              ],
              [
                7.566,
                51.998
              ],
              [
                7.562,
                51.99
              ],
              [
                7.555,
                51.967
              ]
            ],
            [
              [
                7.945,
                52.273
              ],
              [
                7.932,
                52.262
              ],
              [
                7.918,
                52.254
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "37",
          "id": 4423
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.829,
                52.214
              ],
              [
                8.859,
                52.231
              ]
            ],
            [
              [
                9.606,
                52.426
              ],
              [
                9.643,
                52.428
              ],
              [
                9.848,
                52.416
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "30",
          "id": 4424
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.78,
                52.187
              ],
              [
                8.801,
                52.197
              ],
              [
                8.829,
                52.214
              ]
            ],
            [
              [
                8.859,
                52.231
              ],
              [
                8.86,
                52.232
              ],
              [
                8.881,
                52.241
              ],
              [
                8.904,
                52.245
              ],
              [
                8.926,
                52.247
              ],
              [
                9.203,
                52.234
              ],
              [
                9.224,
                52.237
              ],
              [
                9.248,
                52.242
              ],
              [
                9.272,
                52.25
              ],
              [
                9.294,
                52.26
              ],
              [
                9.316,
                52.272
              ],
              [
                9.459,
                52.379
              ],
              [
                9.502,
                52.401
              ],
              [
                9.547,
                52.416
              ],
              [
                9.594,
                52.425
              ],
              [
                9.606,
                52.426
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "30",
          "id": 4424
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.12,
                52.257
              ],
              [
                7.977,
                52.283
              ]
            ],
            [
              [
                8.777,
                52.195
              ],
              [
                8.752,
                52.205
              ],
              [
                8.734,
                52.21
              ],
              [
                8.715,
                52.213
              ],
              [
                8.684,
                52.214
              ],
              [
                8.674,
                52.213
              ],
              [
                8.656,
                52.209
              ],
              [
                8.586,
                52.185
              ],
              [
                8.581,
                52.184
              ],
              [
                8.555,
                52.182
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "30",
          "id": 4425
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.555,
                52.182
              ],
              [
                8.553,
                52.182
              ],
              [
                8.527,
                52.183
              ],
              [
                8.12,
                52.257
              ]
            ],
            [
              [
                8.787,
                52.191
              ],
              [
                8.777,
                52.195
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "30",
          "id": 4425
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.508,
                52.33
              ],
              [
                7.474,
                52.338
              ]
            ],
            [
              [
                7.977,
                52.283
              ],
              [
                7.946,
                52.283
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "30",
          "id": 4426
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.474,
                52.338
              ],
              [
                7.452,
                52.343
              ],
              [
                7.406,
                52.362
              ],
              [
                7.366,
                52.375
              ],
              [
                7.355,
                52.377
              ],
              [
                7.336,
                52.38
              ],
              [
                7.298,
                52.38
              ],
              [
                7.219,
                52.373
              ],
              [
                6.962,
                52.315
              ]
            ],
            [
              [
                7.946,
                52.283
              ],
              [
                7.737,
                52.284
              ],
              [
                7.701,
                52.287
              ],
              [
                7.508,
                52.33
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "30",
          "id": 4426
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.442,
              50.344
            ],
            [
              7.33,
              50.32
            ],
            [
              7.311,
              50.313
            ],
            [
              7.297,
              50.307
            ],
            [
              7.293,
              50.305
            ],
            [
              7.27,
              50.288
            ],
            [
              7.237,
              50.252
            ],
            [
              7.222,
              50.239
            ],
            [
              7.206,
              50.228
            ],
            [
              7.188,
              50.221
            ],
            [
              7.169,
              50.219
            ],
            [
              7.151,
              50.22
            ],
            [
              7.143,
              50.222
            ],
            [
              7.109,
              50.234
            ],
            [
              7.096,
              50.238
            ],
            [
              7.083,
              50.24
            ],
            [
              7.066,
              50.239
            ],
            [
              7.049,
              50.236
            ],
            [
              7.034,
              50.23
            ],
            [
              6.986,
              50.205
            ],
            [
              6.969,
              50.198
            ],
            [
              6.951,
              50.194
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "44",
          "id": 4427
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.954,
              50.191
            ],
            [
              6.945,
              50.192
            ],
            [
              6.936,
              50.191
            ],
            [
              6.928,
              50.188
            ],
            [
              6.91,
              50.181
            ],
            [
              6.892,
              50.171
            ],
            [
              6.877,
              50.159
            ],
            [
              6.87,
              50.153
            ],
            [
              6.864,
              50.145
            ],
            [
              6.86,
              50.136
            ],
            [
              6.858,
              50.125
            ],
            [
              6.86,
              50.114
            ],
            [
              6.864,
              50.104
            ],
            [
              6.869,
              50.094
            ],
            [
              6.882,
              50.075
            ],
            [
              6.889,
              50.067
            ],
            [
              6.897,
              50.059
            ],
            [
              6.916,
              50.043
            ],
            [
              6.923,
              50.037
            ],
            [
              6.93,
              50.025
            ],
            [
              6.931,
              50.012
            ],
            [
              6.929,
              49.999
            ],
            [
              6.923,
              49.986
            ],
            [
              6.915,
              49.974
            ],
            [
              6.896,
              49.951
            ],
            [
              6.848,
              49.903
            ],
            [
              6.798,
              49.861
            ],
            [
              6.78,
              49.849
            ],
            [
              6.771,
              49.844
            ],
            [
              6.754,
              49.837
            ],
            [
              6.75,
              49.834
            ],
            [
              6.738,
              49.824
            ],
            [
              6.731,
              49.81
            ],
            [
              6.726,
              49.795
            ],
            [
              6.724,
              49.78
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "44",
          "id": 4428
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.398,
              50.829
            ],
            [
              6.427,
              50.829
            ],
            [
              6.442,
              50.83
            ],
            [
              6.457,
              50.833
            ],
            [
              6.462,
              50.835
            ],
            [
              6.483,
              50.847
            ],
            [
              6.537,
              50.884
            ],
            [
              6.557,
              50.894
            ],
            [
              6.567,
              50.897
            ],
            [
              6.577,
              50.899
            ],
            [
              6.585,
              50.899
            ],
            [
              6.667,
              50.892
            ],
            [
              6.683,
              50.892
            ],
            [
              6.691,
              50.893
            ],
            [
              6.807,
              50.92
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "40",
          "id": 4429
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.118,
              49.568
            ],
            [
              6.134,
              49.592
            ],
            [
              6.143,
              49.609
            ],
            [
              6.153,
              49.621
            ],
            [
              6.164,
              49.632
            ],
            [
              6.176,
              49.64
            ],
            [
              6.19,
              49.647
            ],
            [
              6.208,
              49.653
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "44",
          "id": 4430
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.208,
              49.653
            ],
            [
              6.222,
              49.657
            ],
            [
              6.256,
              49.662
            ],
            [
              6.358,
              49.668
            ],
            [
              6.392,
              49.673
            ],
            [
              6.409,
              49.678
            ],
            [
              6.425,
              49.684
            ],
            [
              6.544,
              49.751
            ],
            [
              6.591,
              49.771
            ],
            [
              6.64,
              49.784
            ],
            [
              6.656,
              49.786
            ],
            [
              6.673,
              49.787
            ],
            [
              6.69,
              49.787
            ],
            [
              6.706,
              49.786
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "44",
          "id": 4430
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.658,
                50.896
              ],
              [
                6.662,
                50.883
              ],
              [
                6.664,
                50.879
              ],
              [
                6.672,
                50.868
              ],
              [
                6.675,
                50.864
              ],
              [
                6.707,
                50.839
              ],
              [
                6.738,
                50.82
              ],
              [
                6.754,
                50.812
              ],
              [
                6.821,
                50.788
              ]
            ],
            [
              [
                6.867,
                50.772
              ],
              [
                6.88,
                50.767
              ],
              [
                6.89,
                50.763
              ],
              [
                6.897,
                50.759
              ],
              [
                6.905,
                50.753
              ],
              [
                6.911,
                50.746
              ],
              [
                6.911,
                50.745
              ]
            ],
            [
              [
                6.961,
                50.632
              ],
              [
                6.981,
                50.619
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "31",
          "id": 4431
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.821,
                50.788
              ],
              [
                6.867,
                50.772
              ]
            ],
            [
              [
                6.911,
                50.745
              ],
              [
                6.914,
                50.737
              ],
              [
                6.918,
                50.686
              ],
              [
                6.92,
                50.677
              ],
              [
                6.922,
                50.669
              ],
              [
                6.926,
                50.661
              ],
              [
                6.932,
                50.653
              ],
              [
                6.939,
                50.646
              ],
              [
                6.961,
                50.632
              ]
            ],
            [
              [
                6.981,
                50.619
              ],
              [
                7.01,
                50.6
              ],
              [
                7.037,
                50.588
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "31",
          "id": 4431
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.57,
              50.21
            ],
            [
              7.596,
              50.208
            ],
            [
              7.605,
              50.207
            ],
            [
              7.615,
              50.204
            ],
            [
              7.623,
              50.2
            ],
            [
              7.63,
              50.193
            ],
            [
              7.634,
              50.185
            ],
            [
              7.634,
              50.176
            ],
            [
              7.633,
              50.167
            ],
            [
              7.623,
              50.133
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "31",
          "id": 4432
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.355,
              50.385
            ],
            [
              7.383,
              50.387
            ],
            [
              7.4,
              50.385
            ],
            [
              7.402,
              50.384
            ],
            [
              7.409,
              50.381
            ],
            [
              7.413,
              50.379
            ],
            [
              7.422,
              50.369
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "31",
          "id": 4432
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.037,
                50.588
              ],
              [
                7.147,
                50.55
              ],
              [
                7.164,
                50.54
              ],
              [
                7.18,
                50.528
              ],
              [
                7.194,
                50.514
              ],
              [
                7.206,
                50.499
              ],
              [
                7.217,
                50.483
              ],
              [
                7.227,
                50.465
              ],
              [
                7.229,
                50.461
              ],
              [
                7.231,
                50.457
              ],
              [
                7.232,
                50.448
              ],
              [
                7.233,
                50.443
              ],
              [
                7.232,
                50.434
              ],
              [
                7.233,
                50.429
              ],
              [
                7.236,
                50.42
              ],
              [
                7.237,
                50.416
              ],
              [
                7.24,
                50.412
              ],
              [
                7.244,
                50.408
              ],
              [
                7.247,
                50.405
              ],
              [
                7.251,
                50.402
              ],
              [
                7.256,
                50.399
              ],
              [
                7.264,
                50.395
              ],
              [
                7.274,
                50.391
              ],
              [
                7.292,
                50.387
              ],
              [
                7.31,
                50.384
              ],
              [
                7.319,
                50.383
              ],
              [
                7.355,
                50.385
              ]
            ],
            [
              [
                7.422,
                50.369
              ],
              [
                7.464,
                50.324
              ],
              [
                7.467,
                50.321
              ],
              [
                7.517,
                50.23
              ],
              [
                7.525,
                50.219
              ],
              [
                7.529,
                50.216
              ],
              [
                7.532,
                50.214
              ],
              [
                7.537,
                50.212
              ],
              [
                7.545,
                50.211
              ],
              [
                7.57,
                50.21
              ]
            ],
            [
              [
                7.623,
                50.133
              ],
              [
                7.622,
                50.129
              ],
              [
                7.62,
                50.119
              ],
              [
                7.62,
                50.11
              ],
              [
                7.62,
                50.105
              ],
              [
                7.621,
                50.101
              ],
              [
                7.63,
                50.08
              ],
              [
                7.649,
                50.044
              ],
              [
                7.657,
                50.032
              ],
              [
                7.667,
                50.022
              ],
              [
                7.679,
                50.013
              ],
              [
                7.69,
                50.006
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "31",
          "id": 4432
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.5,
              51.395
            ],
            [
              7.502,
              51.39
            ],
            [
              7.518,
              51.348
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "41",
          "id": 4433
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.518,
              51.348
            ],
            [
              7.52,
              51.343
            ],
            [
              7.525,
              51.332
            ],
            [
              7.55,
              51.299
            ],
            [
              7.61,
              51.243
            ],
            [
              7.638,
              51.212
            ],
            [
              7.649,
              51.194
            ],
            [
              7.658,
              51.176
            ],
            [
              7.682,
              51.112
            ],
            [
              7.688,
              51.099
            ],
            [
              7.696,
              51.088
            ],
            [
              7.716,
              51.071
            ],
            [
              7.741,
              51.062
            ],
            [
              7.803,
              51.048
            ],
            [
              7.813,
              51.044
            ],
            [
              7.822,
              51.038
            ],
            [
              7.829,
              51.03
            ],
            [
              7.835,
              51.019
            ],
            [
              7.839,
              51.007
            ],
            [
              7.846,
              50.982
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "41",
          "id": 4433
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.69,
              50.006
            ],
            [
              7.823,
              49.967
            ],
            [
              7.845,
              49.958
            ],
            [
              7.853,
              49.953
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "31",
          "id": 4434
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.674,
                50.286
              ],
              [
                8.671,
                50.273
              ],
              [
                8.664,
                50.251
              ],
              [
                8.654,
                50.231
              ],
              [
                8.644,
                50.216
              ],
              [
                8.632,
                50.204
              ],
              [
                8.598,
                50.175
              ],
              [
                8.592,
                50.169
              ],
              [
                8.587,
                50.161
              ],
              [
                8.584,
                50.153
              ],
              [
                8.581,
                50.144
              ],
              [
                8.577,
                50.116
              ]
            ],
            [
              [
                8.703,
                50.436
              ],
              [
                8.7,
                50.431
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "451",
          "id": 4438
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.7,
                50.431
              ],
              [
                8.699,
                50.429
              ],
              [
                8.695,
                50.418
              ],
              [
                8.693,
                50.406
              ],
              [
                8.689,
                50.357
              ],
              [
                8.674,
                50.286
              ]
            ],
            [
              [
                8.834,
                50.627
              ],
              [
                8.816,
                50.597
              ],
              [
                8.788,
                50.562
              ],
              [
                8.753,
                50.53
              ],
              [
                8.746,
                50.521
              ],
              [
                8.741,
                50.512
              ],
              [
                8.73,
                50.478
              ],
              [
                8.725,
                50.467
              ],
              [
                8.719,
                50.457
              ],
              [
                8.705,
                50.439
              ],
              [
                8.703,
                50.436
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "451",
          "id": 4438
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.836,
              50.61
            ],
            [
              8.85,
              50.623
            ],
            [
              8.867,
              50.629
            ],
            [
              8.905,
              50.635
            ],
            [
              8.946,
              50.648
            ],
            [
              8.963,
              50.655
            ],
            [
              9.078,
              50.726
            ],
            [
              9.113,
              50.742
            ],
            [
              9.152,
              50.751
            ],
            [
              9.312,
              50.763
            ],
            [
              9.584,
              50.834
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "40",
          "id": 4439
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.613,
              49.851
            ],
            [
              8.625,
              49.843
            ],
            [
              8.628,
              49.84
            ],
            [
              8.631,
              49.835
            ],
            [
              8.632,
              49.831
            ],
            [
              8.632,
              49.826
            ],
            [
              8.631,
              49.813
            ],
            [
              8.606,
              49.719
            ],
            [
              8.604,
              49.709
            ],
            [
              8.604,
              49.699
            ],
            [
              8.607,
              49.676
            ],
            [
              8.631,
              49.608
            ],
            [
              8.637,
              49.581
            ],
            [
              8.642,
              49.402
            ],
            [
              8.641,
              49.388
            ],
            [
              8.639,
              49.375
            ],
            [
              8.597,
              49.215
            ],
            [
              8.596,
              49.211
            ],
            [
              8.587,
              49.195
            ],
            [
              8.576,
              49.179
            ],
            [
              8.52,
              49.117
            ],
            [
              8.471,
              49.075
            ],
            [
              8.398,
              48.996
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "35",
          "id": 4440
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.742,
                49.28
              ],
              [
                8.732,
                49.28
              ],
              [
                8.676,
                49.262
              ],
              [
                8.656,
                49.26
              ],
              [
                8.654,
                49.26
              ],
              [
                8.643,
                49.266
              ],
              [
                8.641,
                49.267
              ],
              [
                8.609,
                49.291
              ],
              [
                8.566,
                49.334
              ],
              [
                8.563,
                49.335
              ],
              [
                8.498,
                49.356
              ],
              [
                8.47,
                49.362
              ]
            ],
            [
              [
                9.262,
                49.163
              ],
              [
                9.226,
                49.169
              ],
              [
                9.11,
                49.212
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "50",
          "id": 4441
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.11,
              49.212
            ],
            [
              9.072,
              49.226
            ],
            [
              9.038,
              49.234
            ],
            [
              9.002,
              49.239
            ],
            [
              8.881,
              49.241
            ],
            [
              8.861,
              49.244
            ],
            [
              8.842,
              49.249
            ],
            [
              8.838,
              49.25
            ],
            [
              8.786,
              49.273
            ],
            [
              8.768,
              49.278
            ],
            [
              8.75,
              49.281
            ],
            [
              8.742,
              49.28
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "50",
          "id": 4441
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.258,
              49.222
            ],
            [
              10.196,
              49.206
            ],
            [
              10.124,
              49.203
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "50",
          "id": 4442
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.388,
              49.182
            ],
            [
              9.342,
              49.168
            ],
            [
              9.301,
              49.162
            ],
            [
              9.262,
              49.163
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "50",
          "id": 4442
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.124,
              49.203
            ],
            [
              10.027,
              49.198
            ],
            [
              9.903,
              49.18
            ],
            [
              9.867,
              49.179
            ],
            [
              9.83,
              49.181
            ],
            [
              9.587,
              49.214
            ],
            [
              9.548,
              49.214
            ],
            [
              9.509,
              49.211
            ],
            [
              9.451,
              49.2
            ],
            [
              9.388,
              49.182
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "50",
          "id": 4442
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.364,
              49.247
            ],
            [
              10.258,
              49.222
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "50",
          "id": 4443
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.08,
              49.369
            ],
            [
              11.045,
              49.352
            ],
            [
              11.025,
              49.344
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "50",
          "id": 4443
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.025,
              49.344
            ],
            [
              11.008,
              49.337
            ],
            [
              10.97,
              49.328
            ],
            [
              10.951,
              49.325
            ],
            [
              10.809,
              49.324
            ],
            [
              10.792,
              49.322
            ],
            [
              10.775,
              49.318
            ],
            [
              10.658,
              49.273
            ],
            [
              10.623,
              49.263
            ],
            [
              10.591,
              49.258
            ],
            [
              10.367,
              49.248
            ],
            [
              10.364,
              49.247
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "50",
          "id": 4443
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.614,
              50.528
            ],
            [
              8.621,
              50.526
            ],
            [
              8.673,
              50.519
            ],
            [
              8.684,
              50.515
            ],
            [
              8.694,
              50.508
            ],
            [
              8.703,
              50.5
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "41",
          "id": 4444
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.506,
                50.616
              ],
              [
                8.514,
                50.6
              ],
              [
                8.519,
                50.592
              ],
              [
                8.526,
                50.585
              ],
              [
                8.558,
                50.556
              ],
              [
                8.572,
                50.546
              ],
              [
                8.588,
                50.537
              ],
              [
                8.604,
                50.53
              ],
              [
                8.614,
                50.528
              ]
            ],
            [
              [
                8.703,
                50.5
              ],
              [
                8.712,
                50.493
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "41",
          "id": 4444
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.575,
              51.323
            ],
            [
              9.5,
              51.256
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "45",
          "id": 4446
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.842,
              51.454
            ],
            [
              9.83,
              51.439
            ],
            [
              9.823,
              51.433
            ],
            [
              9.816,
              51.427
            ],
            [
              9.807,
              51.421
            ],
            [
              9.798,
              51.417
            ],
            [
              9.778,
              51.411
            ],
            [
              9.664,
              51.387
            ],
            [
              9.645,
              51.38
            ],
            [
              9.628,
              51.371
            ],
            [
              9.575,
              51.323
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4446
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.505,
              51.259
            ],
            [
              9.493,
              51.25
            ],
            [
              9.493,
              51.25
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "45",
          "id": 4447
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.493,
              51.25
            ],
            [
              9.484,
              51.237
            ],
            [
              9.477,
              51.222
            ],
            [
              9.473,
              51.207
            ],
            [
              9.468,
              51.171
            ],
            [
              9.466,
              51.116
            ],
            [
              9.467,
              51.107
            ],
            [
              9.476,
              51.076
            ],
            [
              9.478,
              51.065
            ],
            [
              9.478,
              51.054
            ],
            [
              9.475,
              51.025
            ],
            [
              9.476,
              51.015
            ],
            [
              9.477,
              51.005
            ],
            [
              9.48,
              50.996
            ],
            [
              9.483,
              50.986
            ],
            [
              9.491,
              50.969
            ],
            [
              9.496,
              50.961
            ],
            [
              9.501,
              50.953
            ],
            [
              9.507,
              50.946
            ],
            [
              9.515,
              50.939
            ],
            [
              9.535,
              50.925
            ],
            [
              9.538,
              50.922
            ],
            [
              9.556,
              50.899
            ],
            [
              9.561,
              50.89
            ],
            [
              9.582,
              50.84
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4447
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.168,
              49.429
            ],
            [
              11.149,
              49.415
            ],
            [
              11.08,
              49.369
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "51",
          "id": 4449
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.25,
              49.493
            ],
            [
              11.168,
              49.429
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "51",
          "id": 4449
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.754,
              50.376
            ],
            [
              9.759,
              50.365
            ],
            [
              9.77,
              50.346
            ],
            [
              9.784,
              50.331
            ],
            [
              9.801,
              50.318
            ],
            [
              9.839,
              50.295
            ],
            [
              9.856,
              50.281
            ],
            [
              9.886,
              50.249
            ],
            [
              9.935,
              50.208
            ],
            [
              9.941,
              50.201
            ],
            [
              9.947,
              50.193
            ],
            [
              9.951,
              50.185
            ],
            [
              9.954,
              50.178
            ],
            [
              9.956,
              50.17
            ],
            [
              9.958,
              50.161
            ],
            [
              9.958,
              50.157
            ],
            [
              9.959,
              50.152
            ],
            [
              9.958,
              50.147
            ],
            [
              9.957,
              50.141
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "45",
          "id": 4450
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.568,
                50.84
              ],
              [
                9.607,
                50.77
              ],
              [
                9.617,
                50.756
              ],
              [
                9.623,
                50.749
              ],
              [
                9.658,
                50.711
              ],
              [
                9.679,
                50.677
              ],
              [
                9.689,
                50.639
              ],
              [
                9.696,
                50.54
              ],
              [
                9.704,
                50.502
              ],
              [
                9.716,
                50.464
              ],
              [
                9.754,
                50.376
              ]
            ],
            [
              [
                9.957,
                50.141
              ],
              [
                9.956,
                50.132
              ],
              [
                9.956,
                50.129
              ],
              [
                9.959,
                50.121
              ],
              [
                9.967,
                50.115
              ],
              [
                10.033,
                50.092
              ],
              [
                10.048,
                50.084
              ],
              [
                10.06,
                50.073
              ],
              [
                10.069,
                50.061
              ],
              [
                10.075,
                50.047
              ],
              [
                10.081,
                50.033
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "45",
          "id": 4450
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.398,
                48.996
              ],
              [
                8.448,
                48.98
              ],
              [
                8.497,
                48.959
              ],
              [
                8.515,
                48.954
              ]
            ],
            [
              [
                8.633,
                48.927
              ],
              [
                8.72,
                48.934
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "52",
          "id": 4451
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                8.515,
                48.954
              ],
              [
                8.579,
                48.934
              ],
              [
                8.614,
                48.927
              ],
              [
                8.623,
                48.927
              ],
              [
                8.633,
                48.927
              ]
            ],
            [
              [
                8.72,
                48.934
              ],
              [
                8.743,
                48.935
              ],
              [
                8.762,
                48.935
              ],
              [
                8.784,
                48.931
              ],
              [
                8.789,
                48.93
              ],
              [
                8.793,
                48.928
              ],
              [
                8.796,
                48.925
              ],
              [
                8.798,
                48.922
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "52",
          "id": 4451
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.25,
              49.405
            ],
            [
              11.25,
              49.405
            ],
            [
              11.249,
              49.407
            ],
            [
              11.249,
              49.41
            ],
            [
              11.249,
              49.412
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "56",
          "id": 4453
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.262,
              49.218
            ],
            [
              10.277,
              49.186
            ],
            [
              10.28,
              49.178
            ],
            [
              10.281,
              49.169
            ],
            [
              10.281,
              49.168
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "43",
          "id": 4454
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.281,
              49.168
            ],
            [
              10.277,
              49.155
            ],
            [
              10.268,
              49.145
            ],
            [
              10.257,
              49.136
            ],
            [
              10.227,
              49.117
            ],
            [
              10.21,
              49.104
            ],
            [
              10.197,
              49.089
            ],
            [
              10.188,
              49.069
            ],
            [
              10.187,
              49.053
            ],
            [
              10.19,
              49.036
            ],
            [
              10.198,
              49.003
            ],
            [
              10.2,
              48.979
            ],
            [
              10.199,
              48.956
            ],
            [
              10.195,
              48.922
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "43",
          "id": 4454
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.584,
              50.834
            ],
            [
              9.659,
              50.848
            ],
            [
              9.738,
              50.857
            ],
            [
              9.758,
              50.863
            ],
            [
              9.873,
              50.914
            ],
            [
              9.882,
              50.919
            ],
            [
              9.897,
              50.93
            ],
            [
              9.925,
              50.958
            ],
            [
              9.933,
              50.964
            ],
            [
              9.942,
              50.97
            ],
            [
              9.96,
              50.976
            ],
            [
              10.016,
              50.985
            ],
            [
              10.036,
              50.991
            ],
            [
              10.099,
              51.02
            ],
            [
              10.139,
              51.034
            ],
            [
              10.143,
              51.035
            ],
            [
              10.174,
              51.038
            ],
            [
              10.182,
              51.037
            ],
            [
              10.19,
              51.036
            ],
            [
              10.27,
              51.014
            ],
            [
              10.34,
              51.006
            ],
            [
              10.357,
              51.003
            ],
            [
              10.375,
              50.998
            ],
            [
              10.42,
              50.981
            ],
            [
              10.447,
              50.968
            ],
            [
              10.455,
              50.963
            ],
            [
              10.502,
              50.922
            ],
            [
              10.527,
              50.907
            ],
            [
              10.536,
              50.903
            ],
            [
              10.545,
              50.9
            ],
            [
              10.58,
              50.894
            ],
            [
              10.588,
              50.894
            ],
            [
              10.69,
              50.9
            ],
            [
              10.695,
              50.9
            ],
            [
              10.699,
              50.899
            ],
            [
              10.704,
              50.897
            ],
            [
              10.708,
              50.895
            ],
            [
              10.716,
              50.888
            ],
            [
              10.725,
              50.883
            ],
            [
              10.734,
              50.879
            ],
            [
              10.743,
              50.876
            ],
            [
              10.753,
              50.874
            ],
            [
              10.761,
              50.873
            ],
            [
              10.771,
              50.874
            ],
            [
              10.78,
              50.875
            ],
            [
              10.801,
              50.882
            ],
            [
              10.82,
              50.891
            ],
            [
              10.825,
              50.893
            ],
            [
              10.843,
              50.897
            ],
            [
              10.861,
              50.899
            ],
            [
              10.962,
              50.896
            ],
            [
              10.983,
              50.898
            ],
            [
              11.016,
              50.904
            ],
            [
              11.213,
              50.961
            ],
            [
              11.231,
              50.965
            ],
            [
              11.25,
              50.966
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "40",
          "id": 4465
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.877,
              52.416
            ],
            [
              9.878,
              52.409
            ],
            [
              9.879,
              52.404
            ],
            [
              9.878,
              52.394
            ],
            [
              9.877,
              52.384
            ],
            [
              9.866,
              52.344
            ],
            [
              9.866,
              52.337
            ],
            [
              9.87,
              52.329
            ],
            [
              9.876,
              52.323
            ],
            [
              9.884,
              52.317
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "45",
          "id": 4473
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.884,
                52.317
              ],
              [
                9.908,
                52.299
              ],
              [
                9.919,
                52.288
              ],
              [
                9.922,
                52.285
              ],
              [
                9.924,
                52.281
              ],
              [
                9.929,
                52.267
              ],
              [
                9.934,
                52.257
              ],
              [
                9.984,
                52.183
              ],
              [
                10.011,
                52.156
              ],
              [
                10.034,
                52.138
              ],
              [
                10.037,
                52.137
              ],
              [
                10.041,
                52.135
              ],
              [
                10.092,
                52.128
              ],
              [
                10.109,
                52.123
              ],
              [
                10.127,
                52.118
              ],
              [
                10.153,
                52.106
              ],
              [
                10.182,
                52.09
              ],
              [
                10.185,
                52.087
              ],
              [
                10.188,
                52.084
              ],
              [
                10.191,
                52.081
              ],
              [
                10.194,
                52.078
              ],
              [
                10.196,
                52.075
              ],
              [
                10.197,
                52.072
              ],
              [
                10.198,
                52.069
              ],
              [
                10.197,
                52.065
              ],
              [
                10.155,
                51.952
              ],
              [
                10.153,
                51.94
              ],
              [
                10.149,
                51.875
              ],
              [
                10.145,
                51.853
              ],
              [
                10.142,
                51.844
              ],
              [
                10.138,
                51.836
              ],
              [
                10.133,
                51.829
              ],
              [
                10.126,
                51.823
              ],
              [
                10.118,
                51.817
              ],
              [
                10.109,
                51.813
              ],
              [
                10.055,
                51.789
              ],
              [
                9.945,
                51.708
              ],
              [
                9.936,
                51.7
              ],
              [
                9.921,
                51.683
              ],
              [
                9.908,
                51.664
              ],
              [
                9.897,
                51.646
              ],
              [
                9.893,
                51.636
              ],
              [
                9.889,
                51.626
              ],
              [
                9.884,
                51.605
              ],
              [
                9.875,
                51.529
              ],
              [
                9.872,
                51.518
              ],
              [
                9.868,
                51.508
              ],
              [
                9.842,
                51.454
              ]
            ],
            [
              [
                9.876,
                52.422
              ],
              [
                9.877,
                52.416
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4473
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.842,
              52.321
            ],
            [
              10.905,
              52.302
            ],
            [
              11.003,
              52.28
            ],
            [
              11.013,
              52.277
            ],
            [
              11.021,
              52.272
            ],
            [
              11.045,
              52.255
            ],
            [
              11.049,
              52.253
            ],
            [
              11.053,
              52.251
            ],
            [
              11.061,
              52.249
            ],
            [
              11.067,
              52.248
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "park",
          "shield_text": "30",
          "id": 4474
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.926,
                52.416
              ],
              [
                9.963,
                52.41
              ],
              [
                10.013,
                52.408
              ]
            ],
            [
              [
                10.548,
                52.321
              ],
              [
                10.56,
                52.319
              ],
              [
                10.582,
                52.318
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "30",
          "id": 4474
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.885,
                52.422
              ],
              [
                9.926,
                52.416
              ]
            ],
            [
              [
                10.013,
                52.408
              ],
              [
                10.042,
                52.407
              ],
              [
                10.061,
                52.403
              ],
              [
                10.096,
                52.394
              ],
              [
                10.189,
                52.355
              ],
              [
                10.196,
                52.353
              ],
              [
                10.452,
                52.338
              ],
              [
                10.548,
                52.321
              ]
            ],
            [
              [
                10.582,
                52.318
              ],
              [
                10.713,
                52.312
              ],
              [
                10.739,
                52.315
              ],
              [
                10.748,
                52.317
              ],
              [
                10.774,
                52.327
              ],
              [
                10.784,
                52.329
              ],
              [
                10.794,
                52.33
              ],
              [
                10.799,
                52.33
              ],
              [
                10.818,
                52.329
              ],
              [
                10.842,
                52.321
              ]
            ],
            [
              [
                11.067,
                52.248
              ],
              [
                11.25,
                52.22
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "30",
          "id": 4474
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.027,
              53.39
            ],
            [
              10.033,
              53.386
            ],
            [
              10.038,
              53.382
            ],
            [
              10.058,
              53.357
            ],
            [
              10.076,
              53.329
            ],
            [
              10.083,
              53.317
            ],
            [
              10.087,
              53.303
            ],
            [
              10.09,
              53.289
            ],
            [
              10.09,
              53.252
            ],
            [
              10.084,
              53.197
            ],
            [
              10.078,
              53.173
            ],
            [
              10.075,
              53.16
            ],
            [
              10.074,
              53.158
            ],
            [
              10.072,
              53.158
            ],
            [
              10.036,
              53.156
            ],
            [
              10.02,
              53.154
            ],
            [
              10.005,
              53.149
            ],
            [
              9.99,
              53.138
            ],
            [
              9.98,
              53.123
            ],
            [
              9.962,
              53.088
            ],
            [
              9.913,
              53.008
            ],
            [
              9.904,
              52.995
            ],
            [
              9.893,
              52.984
            ],
            [
              9.882,
              52.974
            ],
            [
              9.87,
              52.964
            ],
            [
              9.765,
              52.907
            ],
            [
              9.729,
              52.883
            ],
            [
              9.713,
              52.87
            ],
            [
              9.698,
              52.856
            ],
            [
              9.685,
              52.84
            ],
            [
              9.674,
              52.822
            ],
            [
              9.667,
              52.802
            ],
            [
              9.662,
              52.78
            ],
            [
              9.662,
              52.779
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4475
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                10.032,
                53.401
              ],
              [
                10.031,
                53.43
              ]
            ],
            [
              [
                10.038,
                53.505
              ],
              [
                10.06,
                53.54
              ],
              [
                10.094,
                53.56
              ],
              [
                10.134,
                53.569
              ],
              [
                10.174,
                53.575
              ],
              [
                10.212,
                53.586
              ],
              [
                10.217,
                53.589
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "22",
          "id": 4476
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                10.031,
                53.43
              ],
              [
                10.03,
                53.463
              ],
              [
                10.038,
                53.505
              ],
              [
                10.038,
                53.505
              ]
            ],
            [
              [
                10.033,
                53.378
              ],
              [
                10.032,
                53.401
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4476
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.25,
              53.504
            ],
            [
              11.227,
              53.513
            ],
            [
              10.983,
              53.543
            ],
            [
              10.946,
              53.545
            ],
            [
              10.862,
              53.539
            ],
            [
              10.837,
              53.54
            ],
            [
              10.827,
              53.542
            ],
            [
              10.721,
              53.577
            ],
            [
              10.681,
              53.585
            ],
            [
              10.643,
              53.589
            ],
            [
              10.485,
              53.588
            ],
            [
              10.332,
              53.602
            ],
            [
              10.26,
              53.6
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "26",
          "id": 4479
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.148,
              53.164
            ],
            [
              8.188,
              53.141
            ],
            [
              8.248,
              53.115
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "22",
          "id": 4481
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                7.273,
                53.151
              ],
              [
                7.289,
                53.149
              ],
              [
                7.3,
                53.158
              ],
              [
                7.306,
                53.173
              ],
              [
                7.314,
                53.204
              ],
              [
                7.316,
                53.209
              ],
              [
                7.318,
                53.213
              ],
              [
                7.322,
                53.217
              ],
              [
                7.329,
                53.223
              ],
              [
                7.336,
                53.228
              ],
              [
                7.344,
                53.233
              ],
              [
                7.353,
                53.236
              ],
              [
                7.388,
                53.245
              ],
              [
                7.498,
                53.259
              ],
              [
                7.538,
                53.258
              ],
              [
                7.661,
                53.241
              ],
              [
                7.678,
                53.24
              ],
              [
                7.695,
                53.241
              ],
              [
                7.713,
                53.243
              ],
              [
                7.824,
                53.274
              ],
              [
                7.867,
                53.278
              ],
              [
                7.876,
                53.278
              ],
              [
                7.931,
                53.271
              ],
              [
                7.975,
                53.259
              ],
              [
                7.993,
                53.252
              ],
              [
                8.148,
                53.164
              ]
            ],
            [
              [
                8.248,
                53.115
              ],
              [
                8.253,
                53.113
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4481
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.953,
              53.074
            ],
            [
              8.944,
              53.075
            ],
            [
              8.932,
              53.076
            ],
            [
              8.717,
              53.037
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "22",
          "id": 4482
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.033,
              53.378
            ],
            [
              9.875,
              53.387
            ],
            [
              9.823,
              53.386
            ],
            [
              9.784,
              53.381
            ],
            [
              9.765,
              53.376
            ],
            [
              9.414,
              53.24
            ],
            [
              9.402,
              53.237
            ],
            [
              9.339,
              53.231
            ],
            [
              9.327,
              53.228
            ],
            [
              9.316,
              53.224
            ],
            [
              9.305,
              53.219
            ],
            [
              9.294,
              53.212
            ],
            [
              9.275,
              53.197
            ],
            [
              9.202,
              53.131
            ],
            [
              9.127,
              53.074
            ],
            [
              9.107,
              53.062
            ],
            [
              9.096,
              53.058
            ],
            [
              9.085,
              53.055
            ],
            [
              9.074,
              53.053
            ],
            [
              9.062,
              53.052
            ],
            [
              9.051,
              53.053
            ],
            [
              9.039,
              53.054
            ],
            [
              8.968,
              53.072
            ],
            [
              8.953,
              53.074
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 4482
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.961,
              54.196
            ],
            [
              9.964,
              54.179
            ],
            [
              9.962,
              54.161
            ],
            [
              9.956,
              54.144
            ],
            [
              9.951,
              54.133
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "45",
          "id": 4487
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.915,
                53.632
              ],
              [
                9.895,
                53.548
              ],
              [
                9.894,
                53.481
              ],
              [
                9.893,
                53.473
              ],
              [
                9.893,
                53.468
              ],
              [
                9.894,
                53.464
              ],
              [
                9.895,
                53.463
              ]
            ],
            [
              [
                9.902,
                53.456
              ],
              [
                9.972,
                53.412
              ],
              [
                9.995,
                53.401
              ]
            ],
            [
              [
                9.916,
                53.759
              ],
              [
                9.916,
                53.725
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "45",
          "id": 4487
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.895,
                53.463
              ],
              [
                9.897,
                53.46
              ],
              [
                9.901,
                53.457
              ],
              [
                9.902,
                53.456
              ]
            ],
            [
              [
                9.916,
                53.725
              ],
              [
                9.917,
                53.644
              ],
              [
                9.916,
                53.636
              ],
              [
                9.915,
                53.632
              ]
            ],
            [
              [
                9.951,
                54.133
              ],
              [
                9.932,
                54.092
              ],
              [
                9.927,
                54.074
              ],
              [
                9.925,
                54.054
              ],
              [
                9.927,
                54.035
              ],
              [
                9.944,
                53.982
              ],
              [
                9.948,
                53.961
              ],
              [
                9.946,
                53.94
              ],
              [
                9.941,
                53.919
              ],
              [
                9.914,
                53.829
              ],
              [
                9.912,
                53.819
              ],
              [
                9.912,
                53.81
              ],
              [
                9.916,
                53.768
              ],
              [
                9.916,
                53.759
              ]
            ],
            [
              [
                9.995,
                53.401
              ],
              [
                10.039,
                53.378
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4487
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.516,
              55.383
            ],
            [
              10.449,
              55.389
            ],
            [
              10.432,
              55.389
            ],
            [
              10.423,
              55.388
            ],
            [
              10.404,
              55.384
            ],
            [
              10.358,
              55.367
            ],
            [
              10.349,
              55.365
            ],
            [
              10.338,
              55.364
            ],
            [
              10.327,
              55.364
            ],
            [
              10.322,
              55.364
            ],
            [
              10.304,
              55.37
            ],
            [
              10.264,
              55.388
            ],
            [
              10.254,
              55.391
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "20",
          "id": 4488
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                10.254,
                55.391
              ],
              [
                10.158,
                55.421
              ],
              [
                10.013,
                55.437
              ],
              [
                9.966,
                55.45
              ],
              [
                9.863,
                55.496
              ],
              [
                9.812,
                55.514
              ],
              [
                9.759,
                55.527
              ],
              [
                9.694,
                55.538
              ],
              [
                9.495,
                55.546
              ]
            ],
            [
              [
                10.771,
                55.367
              ],
              [
                10.669,
                55.352
              ],
              [
                10.653,
                55.352
              ],
              [
                10.637,
                55.354
              ],
              [
                10.565,
                55.375
              ],
              [
                10.527,
                55.382
              ],
              [
                10.516,
                55.383
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "20",
          "id": 4488
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.573,
              55.571
            ],
            [
              9.554,
              55.569
            ],
            [
              9.536,
              55.565
            ],
            [
              9.519,
              55.558
            ],
            [
              9.502,
              55.549
            ],
            [
              9.489,
              55.537
            ],
            [
              9.477,
              55.524
            ],
            [
              9.468,
              55.51
            ],
            [
              9.461,
              55.494
            ],
            [
              9.458,
              55.484
            ],
            [
              9.454,
              55.464
            ],
            [
              9.453,
              55.454
            ],
            [
              9.453,
              55.442
            ],
            [
              9.457,
              55.393
            ],
            [
              9.456,
              55.38
            ],
            [
              9.454,
              55.368
            ],
            [
              9.451,
              55.355
            ],
            [
              9.446,
              55.344
            ],
            [
              9.434,
              55.323
            ],
            [
              9.391,
              55.258
            ],
            [
              9.382,
              55.238
            ],
            [
              9.376,
              55.22
            ],
            [
              9.367,
              55.182
            ],
            [
              9.358,
              55.103
            ],
            [
              9.357,
              55.057
            ],
            [
              9.359,
              55.038
            ],
            [
              9.385,
              54.936
            ],
            [
              9.384,
              54.901
            ],
            [
              9.367,
              54.869
            ],
            [
              9.359,
              54.861
            ],
            [
              9.329,
              54.843
            ],
            [
              9.319,
              54.834
            ],
            [
              9.313,
              54.824
            ],
            [
              9.31,
              54.813
            ],
            [
              9.31,
              54.8
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4489
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.785,
              54.294
            ],
            [
              9.84,
              54.238
            ],
            [
              9.858,
              54.223
            ],
            [
              9.877,
              54.209
            ],
            [
              9.895,
              54.199
            ],
            [
              9.905,
              54.196
            ],
            [
              9.915,
              54.195
            ],
            [
              9.941,
              54.2
            ],
            [
              9.953,
              54.198
            ],
            [
              9.958,
              54.188
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "45",
          "id": 4490
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.481,
              54.583
            ],
            [
              9.484,
              54.576
            ],
            [
              9.494,
              54.557
            ],
            [
              9.506,
              54.54
            ],
            [
              9.534,
              54.51
            ],
            [
              9.559,
              54.487
            ],
            [
              9.585,
              54.468
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "protected_area",
          "shield_text": "45",
          "id": 4490
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.31,
                54.8
              ],
              [
                9.314,
                54.785
              ],
              [
                9.322,
                54.773
              ],
              [
                9.333,
                54.763
              ],
              [
                9.345,
                54.755
              ],
              [
                9.405,
                54.724
              ],
              [
                9.412,
                54.719
              ],
              [
                9.419,
                54.714
              ],
              [
                9.424,
                54.708
              ],
              [
                9.43,
                54.702
              ],
              [
                9.432,
                54.698
              ],
              [
                9.471,
                54.617
              ],
              [
                9.472,
                54.613
              ],
              [
                9.48,
                54.585
              ],
              [
                9.481,
                54.583
              ]
            ],
            [
              [
                9.585,
                54.468
              ],
              [
                9.692,
                54.387
              ],
              [
                9.785,
                54.294
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4490
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.55,
              55.691
            ],
            [
              9.556,
              55.746
            ],
            [
              9.556,
              55.748
            ],
            [
              9.557,
              55.749
            ],
            [
              9.599,
              55.765
            ],
            [
              9.61,
              55.771
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "45",
          "id": 4491
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                9.585,
                55.57
              ],
              [
                9.579,
                55.59
              ],
              [
                9.559,
                55.627
              ],
              [
                9.552,
                55.647
              ],
              [
                9.549,
                55.66
              ],
              [
                9.549,
                55.673
              ],
              [
                9.55,
                55.691
              ]
            ],
            [
              [
                9.61,
                55.771
              ],
              [
                9.622,
                55.777
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 4491
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.744,
              55.355
            ],
            [
              10.76,
              55.355
            ],
            [
              10.774,
              55.351
            ],
            [
              10.786,
              55.343
            ],
            [
              10.807,
              55.321
            ],
            [
              10.818,
              55.311
            ],
            [
              10.831,
              55.304
            ],
            [
              10.846,
              55.3
            ],
            [
              10.867,
              55.301
            ],
            [
              10.887,
              55.305
            ],
            [
              11.005,
              55.349
            ],
            [
              11.059,
              55.36
            ],
            [
              11.25,
              55.382
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "20",
          "id": 4496
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.183,
              51.578
            ],
            [
              7.144,
              51.699
            ],
            [
              7.143,
              51.704
            ],
            [
              7.144,
              51.707
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "37",
          "id": 4676
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.144,
              51.707
            ],
            [
              7.144,
              51.709
            ],
            [
              7.146,
              51.713
            ],
            [
              7.15,
              51.717
            ],
            [
              7.157,
              51.723
            ],
            [
              7.191,
              51.762
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "37",
          "id": 4676
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.185,
              51.578
            ],
            [
              7.251,
              51.591
            ],
            [
              7.323,
              51.597
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "34",
          "id": 4677
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.5415429513,
              51.9358032935
            ],
            [
              7.5420527114,
              51.9362407745
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "37",
          "id": 4691
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.184,
              51.757
            ],
            [
              7.192,
              51.767
            ],
            [
              7.199,
              51.777
            ],
            [
              7.223,
              51.824
            ],
            [
              7.228,
              51.831
            ],
            [
              7.234,
              51.838
            ],
            [
              7.241,
              51.844
            ],
            [
              7.249,
              51.849
            ],
            [
              7.276,
              51.861
            ],
            [
              7.462,
              51.927
            ],
            [
              7.481,
              51.931
            ],
            [
              7.495,
              51.933
            ],
            [
              7.502,
              51.933
            ],
            [
              7.527,
              51.93
            ],
            [
              7.536,
              51.931
            ],
            [
              7.542,
              51.936
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "37",
          "id": 4691
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.116,
              49.391
            ],
            [
              11.163,
              49.396
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "50",
          "id": 4695
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              11.163,
              49.396
            ],
            [
              11.25,
              49.405
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "50",
          "id": 4695
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.504,
              50.845
            ],
            [
              4.532,
              50.856
            ],
            [
              4.546,
              50.86
            ],
            [
              4.56,
              50.862
            ],
            [
              4.622,
              50.863
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "313",
          "id": 5068
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.453,
              50.614
            ],
            [
              8.485,
              50.616
            ],
            [
              8.499,
              50.613
            ],
            [
              8.51,
              50.602
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "major_road",
          "sort_rank": 380,
          "kind_detail": "primary",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "id": 5078
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.997,
              49.686
            ],
            [
              5.002,
              49.719
            ],
            [
              5.02,
              49.746
            ],
            [
              5.071,
              49.792
            ],
            [
              5.076,
              49.798
            ],
            [
              5.08,
              49.805
            ],
            [
              5.084,
              49.811
            ],
            [
              5.086,
              49.819
            ],
            [
              5.089,
              49.841
            ],
            [
              5.091,
              49.848
            ],
            [
              5.101,
              49.86
            ],
            [
              5.116,
              49.868
            ],
            [
              5.133,
              49.872
            ],
            [
              5.149,
              49.873
            ],
            [
              5.204,
              49.868
            ],
            [
              5.222,
              49.868
            ],
            [
              5.241,
              49.872
            ],
            [
              5.257,
              49.882
            ],
            [
              5.269,
              49.896
            ],
            [
              5.278,
              49.913
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "major_road",
          "sort_rank": 380,
          "kind_detail": "primary",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 5079
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.212,
              53.184
            ],
            [
              7.24,
              53.174
            ],
            [
              7.249,
              53.17
            ],
            [
              7.256,
              53.164
            ],
            [
              7.269,
              53.153
            ],
            [
              7.276,
              53.148
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 5104
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.075,
              49.241
            ],
            [
              4.077,
              49.247
            ],
            [
              4.079,
              49.253
            ],
            [
              4.08,
              49.259
            ],
            [
              4.079,
              49.265
            ],
            [
              4.076,
              49.27
            ],
            [
              4.072,
              49.275
            ],
            [
              4.067,
              49.278
            ],
            [
              4.062,
              49.28
            ],
            [
              4.052,
              49.284
            ],
            [
              4.04,
              49.287
            ],
            [
              4.029,
              49.289
            ],
            [
              4.008,
              49.291
            ],
            [
              3.999,
              49.291
            ],
            [
              3.99,
              49.29
            ],
            [
              3.982,
              49.287
            ],
            [
              3.978,
              49.285
            ],
            [
              3.975,
              49.282
            ],
            [
              3.961,
              49.258
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 5114
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.259,
              49.908
            ],
            [
              5.3,
              49.907
            ],
            [
              5.32,
              49.906
            ],
            [
              5.34,
              49.902
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "major_road",
          "sort_rank": 380,
          "kind_detail": "primary",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 5115
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              4.484,
              50.917
            ],
            [
              4.498,
              50.907
            ],
            [
              4.505,
              50.901
            ],
            [
              4.511,
              50.895
            ],
            [
              4.515,
              50.887
            ],
            [
              4.516,
              50.878
            ],
            [
              4.515,
              50.869
            ],
            [
              4.512,
              50.861
            ],
            [
              4.502,
              50.848
            ],
            [
              4.489,
              50.837
            ],
            [
              4.478,
              50.824
            ],
            [
              4.474,
              50.809
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 5116
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.229,
              50.856
            ],
            [
              6.332,
              50.845
            ],
            [
              6.356,
              50.84
            ],
            [
              6.386,
              50.831
            ],
            [
              6.404,
              50.827
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "40",
          "id": 5117
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.575,
              50.121
            ],
            [
              8.506,
              50.119
            ],
            [
              8.498,
              50.117
            ],
            [
              8.48,
              50.112
            ],
            [
              8.462,
              50.105
            ],
            [
              8.407,
              50.076
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 5118
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              8.41,
              50.073
            ],
            [
              8.404,
              50.071
            ],
            [
              8.398,
              50.069
            ],
            [
              8.393,
              50.065
            ],
            [
              8.393,
              50.059
            ],
            [
              8.397,
              50.053
            ],
            [
              8.403,
              50.047
            ],
            [
              8.416,
              50.038
            ],
            [
              8.454,
              50.016
            ],
            [
              8.466,
              50.007
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "major_road",
          "landuse_kind": "urban_area",
          "sort_rank": 380,
          "kind_detail": "primary",
          "min_zoom": 3,
          "id": 5119
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              0.429,
              51.318
            ],
            [
              0.444,
              51.317
            ],
            [
              0.479,
              51.31
            ],
            [
              0.557,
              51.286
            ],
            [
              0.586,
              51.274
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "15",
          "id": 5772
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                0.321,
                51.327
              ],
              [
                0.429,
                51.318
              ]
            ],
            [
              [
                0.586,
                51.274
              ],
              [
                0.663,
                51.243
              ],
              [
                0.863,
                51.185
              ],
              [
                0.91,
                51.163
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "15",
          "id": 5772
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              0.91,
              51.163
            ],
            [
              0.991,
              51.113
            ],
            [
              1.014,
              51.105
            ],
            [
              1.038,
              51.1
            ],
            [
              1.215,
              51.099
            ],
            [
              1.241,
              51.102
            ],
            [
              1.257,
              51.106
            ],
            [
              1.265,
              51.109
            ],
            [
              1.272,
              51.113
            ],
            [
              1.324,
              51.155
            ],
            [
              1.327,
              51.158
            ],
            [
              1.329,
              51.16
            ],
            [
              1.331,
              51.161
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 5773
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.228,
              49.137
            ],
            [
              6.228,
              49.157
            ],
            [
              6.218,
              49.173
            ],
            [
              6.2,
              49.185
            ],
            [
              6.176,
              49.194
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "50",
          "id": 6313
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              0.035,
              51.422
            ],
            [
              0.046,
              51.415
            ],
            [
              0.089,
              51.407
            ],
            [
              0.133,
              51.409
            ],
            [
              0.198,
              51.421
            ],
            [
              0.208,
              51.422
            ],
            [
              0.218,
              51.422
            ],
            [
              0.227,
              51.42
            ],
            [
              0.235,
              51.416
            ],
            [
              0.242,
              51.412
            ],
            [
              0.249,
              51.406
            ],
            [
              0.254,
              51.397
            ],
            [
              0.255,
              51.388
            ],
            [
              0.255,
              51.378
            ],
            [
              0.258,
              51.369
            ],
            [
              0.259,
              51.367
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "source": "naturalearthdata.com",
          "kind": "highway",
          "landuse_kind": "urban_area",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "min_zoom": 3,
          "id": 7860
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                0.008,
                51.438
              ],
              [
                0.035,
                51.422
              ]
            ],
            [
              [
                0.259,
                51.367
              ],
              [
                0.26,
                51.366
              ],
              [
                0.262,
                51.363
              ],
              [
                0.266,
                51.361
              ],
              [
                0.299,
                51.343
              ],
              [
                0.321,
                51.327
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "id": 7860
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              1.276,
              49.657
            ],
            [
              1.286,
              49.663
            ],
            [
              1.379,
              49.698
            ],
            [
              1.403,
              49.709
            ],
            [
              1.425,
              49.724
            ],
            [
              1.465,
              49.757
            ],
            [
              1.501,
              49.795
            ],
            [
              1.544,
              49.851
            ],
            [
              1.697,
              49.996
            ],
            [
              1.749,
              50.054
            ],
            [
              1.759,
              50.07
            ],
            [
              1.766,
              50.086
            ],
            [
              1.78,
              50.126
            ],
            [
              1.781,
              50.129
            ],
            [
              1.781,
              50.143
            ],
            [
              1.773,
              50.182
            ],
            [
              1.772,
              50.185
            ],
            [
              1.773,
              50.189
            ],
            [
              1.776,
              50.202
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "44",
          "id": 8059
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.208,
              53.598
            ],
            [
              10.05,
              53.594
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "26",
          "id": 8070
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              10.26,
              53.6
            ],
            [
              10.208,
              53.598
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "26",
          "id": 8070
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              9.662,
              52.779
            ],
            [
              9.662,
              52.758
            ],
            [
              9.665,
              52.736
            ],
            [
              9.679,
              52.695
            ],
            [
              9.701,
              52.656
            ],
            [
              9.862,
              52.449
            ],
            [
              9.869,
              52.436
            ],
            [
              9.876,
              52.422
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "45",
          "id": 8071
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              6.714,
              53.194
            ],
            [
              6.739,
              53.193
            ],
            [
              6.756,
              53.189
            ],
            [
              6.775,
              53.182
            ],
            [
              6.793,
              53.174
            ],
            [
              6.801,
              53.171
            ],
            [
              6.81,
              53.169
            ],
            [
              6.819,
              53.168
            ],
            [
              6.839,
              53.167
            ],
            [
              6.899,
              53.172
            ],
            [
              6.908,
              53.175
            ],
            [
              6.962,
              53.194
            ],
            [
              6.975,
              53.197
            ],
            [
              6.985,
              53.197
            ],
            [
              6.994,
              53.194
            ],
            [
              7.003,
              53.19
            ],
            [
              7.011,
              53.186
            ],
            [
              7.018,
              53.18
            ],
            [
              7.025,
              53.174
            ],
            [
              7.033,
              53.169
            ],
            [
              7.041,
              53.166
            ],
            [
              7.047,
              53.166
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "22",
          "id": 8072
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                6.648,
                53.199
              ],
              [
                6.714,
                53.194
              ]
            ],
            [
              [
                7.047,
                53.166
              ],
              [
                7.06,
                53.165
              ],
              [
                7.079,
                53.166
              ],
              [
                7.165,
                53.185
              ],
              [
                7.178,
                53.187
              ],
              [
                7.19,
                53.187
              ],
              [
                7.196,
                53.187
              ],
              [
                7.212,
                53.184
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "22",
          "id": 8072
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              7.307,
              51.594
            ],
            [
              7.323,
              51.591
            ],
            [
              7.334,
              51.581
            ],
            [
              7.35,
              51.554
            ],
            [
              7.357,
              51.544
            ],
            [
              7.47,
              51.437
            ],
            [
              7.484,
              51.421
            ],
            [
              7.497,
              51.401
            ],
            [
              7.5,
              51.395
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "urban_area",
          "shield_text": "41",
          "id": 8073
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                10.186,
                49.511
              ],
              [
                10.194,
                49.498
              ],
              [
                10.204,
                49.486
              ]
            ],
            [
              [
                10.236,
                49.438
              ],
              [
                10.24,
                49.429
              ],
              [
                10.243,
                49.409
              ],
              [
                10.241,
                49.387
              ],
              [
                10.228,
                49.343
              ],
              [
                10.227,
                49.336
              ],
              [
                10.226,
                49.329
              ],
              [
                10.228,
                49.314
              ],
              [
                10.232,
                49.295
              ],
              [
                10.257,
                49.228
              ],
              [
                10.262,
                49.218
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "landuse_kind": "protected_area",
          "shield_text": "43",
          "id": 8087
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                10.105,
                49.77
              ],
              [
                10.116,
                49.76
              ],
              [
                10.121,
                49.744
              ],
              [
                10.124,
                49.711
              ],
              [
                10.13,
                49.691
              ],
              [
                10.163,
                49.638
              ],
              [
                10.17,
                49.613
              ],
              [
                10.173,
                49.561
              ],
              [
                10.176,
                49.535
              ],
              [
                10.184,
                49.516
              ],
              [
                10.186,
                49.511
              ]
            ],
            [
              [
                10.204,
                49.486
              ],
              [
                10.219,
                49.466
              ],
              [
                10.231,
                49.448
              ],
              [
                10.236,
                49.438
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 4,
          "shield_text": "43",
          "id": 8087
        }
      },
      {
        "geometry": {
          "type": "MultiLineString",
          "coordinates": [
            [
              [
                4.954,
                50.955
              ],
              [
                4.95,
                50.955
              ],
              [
                4.94,
                50.956
              ],
              [
                4.9,
                50.966
              ],
              [
                4.871,
                50.97
              ],
              [
                4.85,
                50.972
              ],
              [
                4.829,
                50.97
              ],
              [
                4.809,
                50.966
              ],
              [
                4.789,
                50.961
              ],
              [
                4.766,
                50.952
              ],
              [
                4.745,
                50.941
              ],
              [
                4.704,
                50.915
              ],
              [
                4.668,
                50.886
              ],
              [
                4.653,
                50.872
              ],
              [
                4.648,
                50.866
              ],
              [
                4.646,
                50.864
              ],
              [
                4.642,
                50.863
              ],
              [
                4.622,
                50.863
              ]
            ],
            [
              [
                5.243,
                50.995
              ],
              [
                5.039,
                50.966
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "landuse_kind": "urban_area",
          "shield_text": "314",
          "id": 8088
        }
      },
      {
        "geometry": {
          "type": "LineString",
          "coordinates": [
            [
              5.039,
              50.966
            ],
            [
              4.961,
              50.955
            ],
            [
              4.954,
              50.955
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "kind": "highway",
          "network": "e-road",
          "sort_rank": 383,
          "kind_detail": "motorway",
          "source": "naturalearthdata.com",
          "min_zoom": 3,
          "shield_text": "314",
          "id": 8088
        }
      }
    ]
  },
  "earth": {
    "type": "FeatureCollection",
    "features": [
      {
        "geometry": {
          "type": "MultiPolygon",
          "coordinates": [
            [
              [
                [
                  0.93637129,
                  51.37103913
                ],
                [
                  0.911468946,
                  51.364406643
                ],
                [
                  0.794769727,
                  51.370550848
                ],
                [
                  0.775075717,
                  51.375311591
                ],
                [
                  0.757578972,
                  51.386419989
                ],
                [
                  0.743500196,
                  51.400091864
                ],
                [
                  0.733897332,
                  51.412176825
                ],
                [
                  0.746836785,
                  51.439642645
                ],
                [
                  0.753916863,
                  51.445705471
                ],
                [
                  0.766937696,
                  51.447943427
                ],
                [
                  0.890798373,
                  51.421047268
                ],
                [
                  0.900563998,
                  51.417547919
                ],
                [
                  0.911468946,
                  51.412176825
                ],
                [
                  0.93246504,
                  51.397691148
                ],
                [
                  0.942149285,
                  51.38300202
                ],
                [
                  0.93637129,
                  51.37103913
                ]
              ]
            ],
            [
              [
                [
                  4.015391472,
                  51.701727606
                ],
                [
                  4.020274285,
                  51.696478583
                ],
                [
                  4.026621941,
                  51.691107489
                ],
                [
                  4.036631707,
                  51.685858466
                ],
                [
                  4.078379754,
                  51.678615627
                ],
                [
                  4.097341342,
                  51.670233466
                ],
                [
                  4.099375847,
                  51.654120184
                ],
                [
                  4.089040561,
                  51.644029039
                ],
                [
                  4.072601759,
                  51.63690827
                ],
                [
                  4.054860873,
                  51.632635809
                ],
                [
                  3.978037957,
                  51.623277085
                ],
                [
                  3.960297071,
                  51.623846747
                ],
                [
                  3.923106316,
                  51.632473049
                ],
                [
                  3.901540561,
                  51.641994533
                ],
                [
                  3.891937696,
                  51.655503648
                ],
                [
                  3.88559004,
                  51.668361721
                ],
                [
                  3.86980228,
                  51.676092841
                ],
                [
                  3.830577019,
                  51.685858466
                ],
                [
                  3.823903842,
                  51.689886786
                ],
                [
                  3.817637566,
                  51.69525788
                ],
                [
                  3.809255405,
                  51.699530341
                ],
                [
                  3.79590905,
                  51.700140692
                ],
                [
                  3.771250847,
                  51.681830145
                ],
                [
                  3.765391472,
                  51.678412177
                ],
                [
                  3.720550977,
                  51.676825262
                ],
                [
                  3.700043165,
                  51.680609442
                ],
                [
                  3.686696811,
                  51.692694403
                ],
                [
                  3.689463738,
                  51.725043036
                ],
                [
                  3.725840691,
                  51.739732164
                ],
                [
                  3.810069207,
                  51.747300523
                ],
                [
                  3.814219597,
                  51.748236395
                ],
                [
                  3.830577019,
                  51.747300523
                ],
                [
                  3.843760613,
                  51.742824611
                ],
                [
                  3.939626498,
                  51.741156317
                ],
                [
                  3.961761915,
                  51.738104559
                ],
                [
                  3.978037957,
                  51.730292059
                ],
                [
                  4.015391472,
                  51.701727606
                ]
              ]
            ],
            [
              [
                [
                  4.892588738,
                  53.111029364
                ],
                [
                  4.892588738,
                  53.104803778
                ],
                [
                  4.91309655,
                  53.104803778
                ],
                [
                  4.906097852,
                  53.091701565
                ],
                [
                  4.893077019,
                  53.076117255
                ],
                [
                  4.865244988,
                  53.050197658
                ],
                [
                  4.818125847,
                  53.026760158
                ],
                [
                  4.79566491,
                  53.000311591
                ],
                [
                  4.761973504,
                  52.994330145
                ],
                [
                  4.726817254,
                  53.003078518
                ],
                [
                  4.707692905,
                  53.028469143
                ],
                [
                  4.7138778,
                  53.05463288
                ],
                [
                  4.733653191,
                  53.084214585
                ],
                [
                  4.758474155,
                  53.108465887
                ],
                [
                  4.805674675,
                  53.13300202
                ],
                [
                  4.829274936,
                  53.162990627
                ],
                [
                  4.85434004,
                  53.18773021
                ],
                [
                  4.8857528,
                  53.186712958
                ],
                [
                  4.889821811,
                  53.180853583
                ],
                [
                  4.892100457,
                  53.17572663
                ],
                [
                  4.891368035,
                  53.170965887
                ],
                [
                  4.8857528,
                  53.166205145
                ],
                [
                  4.899912957,
                  53.15232982
                ],
                [
                  4.910166863,
                  53.134588934
                ],
                [
                  4.909922722,
                  53.118841864
                ],
                [
                  4.892588738,
                  53.111029364
                ]
              ]
            ],
            [
              [
                [
                  4.935720248,
                  53.225978908
                ],
                [
                  4.910166863,
                  53.212469794
                ],
                [
                  4.878916863,
                  53.220892645
                ],
                [
                  4.921234571,
                  53.253729559
                ],
                [
                  4.986501498,
                  53.289984442
                ],
                [
                  5.054453972,
                  53.313788153
                ],
                [
                  5.104828321,
                  53.309637762
                ],
                [
                  5.104828321,
                  53.302801825
                ],
                [
                  5.078135613,
                  53.302801825
                ],
                [
                  5.065603061,
                  53.298488674
                ],
                [
                  5.036468946,
                  53.291815497
                ],
                [
                  4.957530144,
                  53.245550848
                ],
                [
                  4.935720248,
                  53.225978908
                ]
              ]
            ],
            [
              [
                [
                  0,
                  53.5354147933
                ],
                [
                  0.000091993,
                  53.53534577
                ],
                [
                  0.095957879,
                  53.4883487
                ],
                [
                  0.115082227,
                  53.483221747
                ],
                [
                  0.134043816,
                  53.48061758
                ],
                [
                  0.151866082,
                  53.475816148
                ],
                [
                  0.167816602,
                  53.464504299
                ],
                [
                  0.17090905,
                  53.45701732
                ],
                [
                  0.173106316,
                  53.446763414
                ],
                [
                  0.175791863,
                  53.43768952
                ],
                [
                  0.181488477,
                  53.43374258
                ],
                [
                  0.190603061,
                  53.431870835
                ],
                [
                  0.219493035,
                  53.419501044
                ],
                [
                  0.211924675,
                  53.412665106
                ],
                [
                  0.22934004,
                  53.404771226
                ],
                [
                  0.24488366,
                  53.390936591
                ],
                [
                  0.256114129,
                  53.37506745
                ],
                [
                  0.26042728,
                  53.361476955
                ],
                [
                  0.342133009,
                  53.226304429
                ],
                [
                  0.356211785,
                  53.188544012
                ],
                [
                  0.356618686,
                  53.145738023
                ],
                [
                  0.335785352,
                  53.093451239
                ],
                [
                  0.329844597,
                  53.086493231
                ],
                [
                  0.318695509,
                  53.083685614
                ],
                [
                  0.298838738,
                  53.081203518
                ],
                [
                  0.282481316,
                  53.074855861
                ],
                [
                  0.193044467,
                  53.020086981
                ],
                [
                  0.17448978,
                  53.015448309
                ],
                [
                  0.160817905,
                  53.008978583
                ],
                [
                  0.082123243,
                  52.938666083
                ],
                [
                  0.061167839,
                  52.924994208
                ],
                [
                  0.037608269,
                  52.919175523
                ],
                [
                  0.02214603,
                  52.912583726
                ],
                [
                  0.008555535,
                  52.89862702
                ],
                [
                  0.010264519,
                  52.886460679
                ],
                [
                  0.040660027,
                  52.885077216
                ],
                [
                  0.09253991,
                  52.892523505
                ],
                [
                  0.105642123,
                  52.889349677
                ],
                [
                  0.133474155,
                  52.87518952
                ],
                [
                  0.14714603,
                  52.872015692
                ],
                [
                  0.17090905,
                  52.862127997
                ],
                [
                  0.222422722,
                  52.813666083
                ],
                [
                  0.246755405,
                  52.795721747
                ],
                [
                  0.26449629,
                  52.803697007
                ],
                [
                  0.285655144,
                  52.805568752
                ],
                [
                  0.325531446,
                  52.803168036
                ],
                [
                  0.341807488,
                  52.797430731
                ],
                [
                  0.36988366,
                  52.773016669
                ],
                [
                  0.384532097,
                  52.768377997
                ],
                [
                  0.384532097,
                  52.775213934
                ],
                [
                  0.379242384,
                  52.790838934
                ],
                [
                  0.399424675,
                  52.809515692
                ],
                [
                  0.425547722,
                  52.827378648
                ],
                [
                  0.438649936,
                  52.840725002
                ],
                [
                  0.44402103,
                  52.865057684
                ],
                [
                  0.456716342,
                  52.891994533
                ],
                [
                  0.472341342,
                  52.916449286
                ],
                [
                  0.485687696,
                  52.93349844
                ],
                [
                  0.520274285,
                  52.955267645
                ],
                [
                  0.569590691,
                  52.969305731
                ],
                [
                  0.623383009,
                  52.975653387
                ],
                [
                  0.671885613,
                  52.974432684
                ],
                [
                  0.664398634,
                  52.981878973
                ],
                [
                  0.684743686,
                  52.986395575
                ],
                [
                  0.706797722,
                  52.983221747
                ],
                [
                  0.72917728,
                  52.977484442
                ],
                [
                  0.750498894,
                  52.974432684
                ],
                [
                  0.835703972,
                  52.974432684
                ],
                [
                  0.875498894,
                  52.968166408
                ],
                [
                  0.921071811,
                  52.954657294
                ],
                [
                  0.968435092,
                  52.947495835
                ],
                [
                  1.013926629,
                  52.960150458
                ],
                [
                  1.003428582,
                  52.96474844
                ],
                [
                  0.991547071,
                  52.967474677
                ],
                [
                  0.979014519,
                  52.968410549
                ],
                [
                  0.966075066,
                  52.967596747
                ],
                [
                  0.966075066,
                  52.974432684
                ],
                [
                  1.274668816,
                  52.929185289
                ],
                [
                  1.396006707,
                  52.891424872
                ],
                [
                  1.644216342,
                  52.775824286
                ],
                [
                  1.673350457,
                  52.755682684
                ],
                [
                  1.697032097,
                  52.731024481
                ],
                [
                  1.715830925,
                  52.68374258
                ],
                [
                  1.734141472,
                  52.654608466
                ],
                [
                  1.747243686,
                  52.62518952
                ],
                [
                  1.740733269,
                  52.603908596
                ],
                [
                  1.746836785,
                  52.588527736
                ],
                [
                  1.74870853,
                  52.568793036
                ],
                [
                  1.747569207,
                  52.532782294
                ],
                [
                  1.771169467,
                  52.485907294
                ],
                [
                  1.767100457,
                  52.476955471
                ],
                [
                  1.754405144,
                  52.467352606
                ],
                [
                  1.72925866,
                  52.415594794
                ],
                [
                  1.730153842,
                  52.405910549
                ],
                [
                  1.727875196,
                  52.396307684
                ],
                [
                  1.683604363,
                  52.324530341
                ],
                [
                  1.651866082,
                  52.28912995
                ],
                [
                  1.641123894,
                  52.281805731
                ],
                [
                  1.630544467,
                  52.270453192
                ],
                [
                  1.628265821,
                  52.244818427
                ],
                [
                  1.630869988,
                  52.199774481
                ],
                [
                  1.625498894,
                  52.180365302
                ],
                [
                  1.607432488,
                  52.145941473
                ],
                [
                  1.603526238,
                  52.127834377
                ],
                [
                  1.589203321,
                  52.100816148
                ],
                [
                  1.587575717,
                  52.086981512
                ],
                [
                  1.582286004,
                  52.081488348
                ],
                [
                  1.503672722,
                  52.060980536
                ],
                [
                  1.486827019,
                  52.049017645
                ],
                [
                  1.472015821,
                  52.056219794
                ],
                [
                  1.466807488,
                  52.048000393
                ],
                [
                  1.4638778,
                  52.03514232
                ],
                [
                  1.45582116,
                  52.028509833
                ],
                [
                  1.448985222,
                  52.024969794
                ],
                [
                  1.4248153,
                  52.001857815
                ],
                [
                  1.354828321,
                  51.954046942
                ],
                [
                  1.343516472,
                  51.942857164
                ],
                [
                  1.332286004,
                  51.940090236
                ],
                [
                  1.26441491,
                  51.994370835
                ],
                [
                  1.234873894,
                  52.000311591
                ],
                [
                  1.185231967,
                  52.025091864
                ],
                [
                  1.157888217,
                  52.028509833
                ],
                [
                  1.157888217,
                  52.021673895
                ],
                [
                  1.193532748,
                  52.000799872
                ],
                [
                  1.214366082,
                  51.991441148
                ],
                [
                  1.260264519,
                  51.984808661
                ],
                [
                  1.270762566,
                  51.981512762
                ],
                [
                  1.275157097,
                  51.976996161
                ],
                [
                  1.274424675,
                  51.96088288
                ],
                [
                  1.271006707,
                  51.956447658
                ],
                [
                  1.250743035,
                  51.959621486
                ],
                [
                  1.238942905,
                  51.958644924
                ],
                [
                  1.21762129,
                  51.954331773
                ],
                [
                  1.20573978,
                  51.953436591
                ],
                [
                  1.193207227,
                  51.955511786
                ],
                [
                  1.165293816,
                  51.967027085
                ],
                [
                  1.143077019,
                  51.966050523
                ],
                [
                  1.094493035,
                  51.955959377
                ],
                [
                  1.06910241,
                  51.953436591
                ],
                [
                  1.095469597,
                  51.945746161
                ],
                [
                  1.262054884,
                  51.939154364
                ],
                [
                  1.281993035,
                  51.946600653
                ],
                [
                  1.278493686,
                  51.927923895
                ],
                [
                  1.199554884,
                  51.877671617
                ],
                [
                  1.212250196,
                  51.871649481
                ],
                [
                  1.227875196,
                  51.86737702
                ],
                [
                  1.26441491,
                  51.863999742
                ],
                [
                  1.274750196,
                  51.870306708
                ],
                [
                  1.282237175,
                  51.880560614
                ],
                [
                  1.286631707,
                  51.881659247
                ],
                [
                  1.288259311,
                  51.860581773
                ],
                [
                  1.2763778,
                  51.844794012
                ],
                [
                  1.219248894,
                  51.811835028
                ],
                [
                  1.167816602,
                  51.790228583
                ],
                [
                  1.13542728,
                  51.781724351
                ],
                [
                  1.0654403,
                  51.775295315
                ],
                [
                  1.046641472,
                  51.777044989
                ],
                [
                  1.037282748,
                  51.782171942
                ],
                [
                  1.021332227,
                  51.802557684
                ],
                [
                  0.988780144,
                  51.830267645
                ],
                [
                  0.979828321,
                  51.843573309
                ],
                [
                  0.977061394,
                  51.824611721
                ],
                [
                  0.962087436,
                  51.813788153
                ],
                [
                  0.925140821,
                  51.802557684
                ],
                [
                  0.894297722,
                  51.784613348
                ],
                [
                  0.886973504,
                  51.782131252
                ],
                [
                  0.886403842,
                  51.776678778
                ],
                [
                  0.883474155,
                  51.764715887
                ],
                [
                  0.878916863,
                  51.752752997
                ],
                [
                  0.87370853,
                  51.747300523
                ],
                [
                  0.86198978,
                  51.745550848
                ],
                [
                  0.845957879,
                  51.736761786
                ],
                [
                  0.835703972,
                  51.733710028
                ],
                [
                  0.823496941,
                  51.733832098
                ],
                [
                  0.801442905,
                  51.739691473
                ],
                [
                  0.79175866,
                  51.741156317
                ],
                [
                  0.767100457,
                  51.739447333
                ],
                [
                  0.720876498,
                  51.728176174
                ],
                [
                  0.698578321,
                  51.720038153
                ],
                [
                  0.714203321,
                  51.715277411
                ],
                [
                  0.732432488,
                  51.713771877
                ],
                [
                  0.749278191,
                  51.708482164
                ],
                [
                  0.7607528,
                  51.692694403
                ],
                [
                  0.789073113,
                  51.710150458
                ],
                [
                  0.853037957,
                  51.71889883
                ],
                [
                  0.883555535,
                  51.726874091
                ],
                [
                  0.912364129,
                  51.741522528
                ],
                [
                  0.930023634,
                  51.743597723
                ],
                [
                  0.945567254,
                  51.733710028
                ],
                [
                  0.947438998,
                  51.725246486
                ],
                [
                  0.944590691,
                  51.715480861
                ],
                [
                  0.9404403,
                  51.707993882
                ],
                [
                  0.938161655,
                  51.706366278
                ],
                [
                  0.94019616,
                  51.698431708
                ],
                [
                  0.94402103,
                  51.690578518
                ],
                [
                  0.95183353,
                  51.678412177
                ],
                [
                  0.941742384,
                  51.673041083
                ],
                [
                  0.937998894,
                  51.664496161
                ],
                [
                  0.938161655,
                  51.641262111
                ],
                [
                  0.934743686,
                  51.635891018
                ],
                [
                  0.926768425,
                  51.630926825
                ],
                [
                  0.911468946,
                  51.623846747
                ],
                [
                  0.938487175,
                  51.62498607
                ],
                [
                  0.94809004,
                  51.621527411
                ],
                [
                  0.95183353,
                  51.617010809
                ],
                [
                  0.92448978,
                  51.588324286
                ],
                [
                  0.873301629,
                  51.559475002
                ],
                [
                  0.828298373,
                  51.541856187
                ],
                [
                  0.816254102,
                  51.537176825
                ],
                [
                  0.771250847,
                  51.528265692
                ],
                [
                  0.692067905,
                  51.536322333
                ],
                [
                  0.664398634,
                  51.53506094
                ],
                [
                  0.663747592,
                  51.535549221
                ],
                [
                  0.650563998,
                  51.535793361
                ],
                [
                  0.646657748,
                  51.53534577
                ],
                [
                  0.644053582,
                  51.53506094
                ],
                [
                  0.642751498,
                  51.533514716
                ],
                [
                  0.623383009,
                  51.522040106
                ],
                [
                  0.608653191,
                  51.518988348
                ],
                [
                  0.595225457,
                  51.518622137
                ],
                [
                  0.582286004,
                  51.516546942
                ],
                [
                  0.568858269,
                  51.508368231
                ],
                [
                  0.552744988,
                  51.517971096
                ],
                [
                  0.547211134,
                  51.517726955
                ],
                [
                  0.525401238,
                  51.516913153
                ],
                [
                  0.4560653,
                  51.505560614
                ],
                [
                  0.450856967,
                  51.498277085
                ],
                [
                  0.44800866,
                  51.48822663
                ],
                [
                  0.441661004,
                  51.477036851
                ],
                [
                  0.42847741,
                  51.467108466
                ],
                [
                  0.414073113,
                  51.461900132
                ],
                [
                  0.399180535,
                  51.458400783
                ],
                [
                  0.384532097,
                  51.45311107
                ],
                [
                  0.448415561,
                  51.459947007
                ],
                [
                  0.456797722,
                  51.463120835
                ],
                [
                  0.461436394,
                  51.470160223
                ],
                [
                  0.464854363,
                  51.477240302
                ],
                [
                  0.469574415,
                  51.48041413
                ],
                [
                  0.534841342,
                  51.491685289
                ],
                [
                  0.694834832,
                  51.477036851
                ],
                [
                  0.709483269,
                  51.470526434
                ],
                [
                  0.721934441,
                  51.456284898
                ],
                [
                  0.723155144,
                  51.446722723
                ],
                [
                  0.713145379,
                  51.441229559
                ],
                [
                  0.692393425,
                  51.439520575
                ],
                [
                  0.656504754,
                  51.444525458
                ],
                [
                  0.640961134,
                  51.444159247
                ],
                [
                  0.609385613,
                  51.425116278
                ],
                [
                  0.572764519,
                  51.419582424
                ],
                [
                  0.554535352,
                  51.412176825
                ],
                [
                  0.562266472,
                  51.406561591
                ],
                [
                  0.56910241,
                  51.399603583
                ],
                [
                  0.576508009,
                  51.393622137
                ],
                [
                  0.585948113,
                  51.391058661
                ],
                [
                  0.671885613,
                  51.391058661
                ],
                [
                  0.712901238,
                  51.384222723
                ],
                [
                  0.704925977,
                  51.395982164
                ],
                [
                  0.700368686,
                  51.409816799
                ],
                [
                  0.705332879,
                  51.419501044
                ],
                [
                  0.726410352,
                  51.419012762
                ],
                [
                  0.728363477,
                  51.40623607
                ],
                [
                  0.739268425,
                  51.387925523
                ],
                [
                  0.753428582,
                  51.371527411
                ],
                [
                  0.76441491,
                  51.364406643
                ],
                [
                  0.977224155,
                  51.349188544
                ],
                [
                  1.100922071,
                  51.373236395
                ],
                [
                  1.423838738,
                  51.392075914
                ],
                [
                  1.4482528,
                  51.38287995
                ],
                [
                  1.439138217,
                  51.350083726
                ],
                [
                  1.435557488,
                  51.34373607
                ],
                [
                  1.430837436,
                  51.337795315
                ],
                [
                  1.425140821,
                  51.332953192
                ],
                [
                  1.418630405,
                  51.329657294
                ],
                [
                  1.382985873,
                  51.329779364
                ],
                [
                  1.37761478,
                  51.326239325
                ],
                [
                  1.380625847,
                  51.30475495
                ],
                [
                  1.387868686,
                  51.287909247
                ],
                [
                  1.404307488,
                  51.261379299
                ],
                [
                  1.41309655,
                  51.221747137
                ],
                [
                  1.404795769,
                  51.18353913
                ],
                [
                  1.384450717,
                  51.151678778
                ],
                [
                  1.357188347,
                  51.131008205
                ],
                [
                  1.290375196,
                  51.116522528
                ],
                [
                  1.262950066,
                  51.103257554
                ],
                [
                  1.251638217,
                  51.102525132
                ],
                [
                  1.229991082,
                  51.103705145
                ],
                [
                  1.218109571,
                  51.100978908
                ],
                [
                  1.208262566,
                  51.094671942
                ],
                [
                  1.199717644,
                  51.087591864
                ],
                [
                  1.192067905,
                  51.082586981
                ],
                [
                  1.172211134,
                  51.077378648
                ],
                [
                  1.106700066,
                  51.076361395
                ],
                [
                  1.087168816,
                  51.072984117
                ],
                [
                  1.066905144,
                  51.064398505
                ],
                [
                  1.027598504,
                  51.041652736
                ],
                [
                  0.976410352,
                  50.994452216
                ],
                [
                  0.966481967,
                  50.982733466
                ],
                [
                  0.969086134,
                  50.956854559
                ],
                [
                  0.979828321,
                  50.91815827
                ],
                [
                  0.945160352,
                  50.909369208
                ],
                [
                  0.86980228,
                  50.925116278
                ],
                [
                  0.802256707,
                  50.939195054
                ],
                [
                  0.762461785,
                  50.930894273
                ],
                [
                  0.664398634,
                  50.870306708
                ],
                [
                  0.624196811,
                  50.858710028
                ],
                [
                  0.407481316,
                  50.829331773
                ],
                [
                  0.370290561,
                  50.818793036
                ],
                [
                  0.365244988,
                  50.818996486
                ],
                [
                  0.35425866,
                  50.809637762
                ],
                [
                  0.344411655,
                  50.799058335
                ],
                [
                  0.342295769,
                  50.795152085
                ],
                [
                  0.308116082,
                  50.780951239
                ],
                [
                  0.271006707,
                  50.747381903
                ],
                [
                  0.233897332,
                  50.747015692
                ],
                [
                  0.214121941,
                  50.748928127
                ],
                [
                  0.168304884,
                  50.759833075
                ],
                [
                  0.157399936,
                  50.761053778
                ],
                [
                  0.122080925,
                  50.760809637
                ],
                [
                  0.113047722,
                  50.764146226
                ],
                [
                  0.095550977,
                  50.775051174
                ],
                [
                  0.07703698,
                  50.778998114
                ],
                [
                  0.034515821,
                  50.780951239
                ],
                [
                  0.017548048,
                  50.784857489
                ],
                [
                  0,
                  50.7889214534
                ],
                [
                  0,
                  53.5354147933
                ]
              ]
            ],
            [
              [
                [
                  5.427012566,
                  53.40643952
                ],
                [
                  5.382497592,
                  53.39468008
                ],
                [
                  5.346934441,
                  53.389227606
                ],
                [
                  5.208343946,
                  53.352687893
                ],
                [
                  5.179860873,
                  53.353094794
                ],
                [
                  5.167653842,
                  53.368231512
                ],
                [
                  5.178884311,
                  53.385443427
                ],
                [
                  5.232432488,
                  53.396714585
                ],
                [
                  5.250173373,
                  53.40643952
                ],
                [
                  5.272959832,
                  53.406073309
                ],
                [
                  5.407237175,
                  53.422552802
                ],
                [
                  5.423594597,
                  53.430365302
                ],
                [
                  5.437022332,
                  53.436468817
                ],
                [
                  5.585297071,
                  53.453599351
                ],
                [
                  5.562022332,
                  53.434312242
                ],
                [
                  5.533702019,
                  53.428371486
                ],
                [
                  5.47543379,
                  53.426947333
                ],
                [
                  5.477386915,
                  53.423529364
                ],
                [
                  5.479746941,
                  53.416205145
                ],
                [
                  5.481700066,
                  53.412665106
                ],
                [
                  5.468597852,
                  53.408514716
                ],
                [
                  5.427012566,
                  53.40643952
                ]
              ]
            ],
            [
              [
                [
                  5.913828972,
                  53.473863023
                ],
                [
                  5.954600457,
                  53.46108633
                ],
                [
                  5.855642123,
                  53.447414455
                ],
                [
                  5.75277754,
                  53.447414455
                ],
                [
                  5.727061394,
                  53.443345445
                ],
                [
                  5.678965691,
                  53.430121161
                ],
                [
                  5.653575066,
                  53.43374258
                ],
                [
                  5.636078321,
                  53.448675848
                ],
                [
                  5.641937696,
                  53.463364976
                ],
                [
                  5.65886478,
                  53.471869208
                ],
                [
                  5.674001498,
                  53.467922268
                ],
                [
                  5.913828972,
                  53.473863023
                ]
              ]
            ],
            [
              [
                [
                  6.153168165,
                  53.46881745
                ],
                [
                  6.133311394,
                  53.453599351
                ],
                [
                  6.127452019,
                  53.459906317
                ],
                [
                  6.127126498,
                  53.463080145
                ],
                [
                  6.133311394,
                  53.467922268
                ],
                [
                  6.122813347,
                  53.481634833
                ],
                [
                  6.147959832,
                  53.494859117
                ],
                [
                  6.185394727,
                  53.504868882
                ],
                [
                  6.211761915,
                  53.508856512
                ],
                [
                  6.310801629,
                  53.514146226
                ],
                [
                  6.33871504,
                  53.508856512
                ],
                [
                  6.33871504,
                  53.502020575
                ],
                [
                  6.325043165,
                  53.502020575
                ],
                [
                  6.153168165,
                  53.46881745
                ]
              ]
            ],
            [
              [
                [
                  0,
                  53.7611869504
                ],
                [
                  0.133474155,
                  53.642645575
                ],
                [
                  0.149261915,
                  53.60960521
                ],
                [
                  0.136892123,
                  53.577134507
                ],
                [
                  0.131195509,
                  53.573431708
                ],
                [
                  0.109629754,
                  53.562892971
                ],
                [
                  0.131358269,
                  53.59369538
                ],
                [
                  0.135996941,
                  53.610663153
                ],
                [
                  0.120209181,
                  53.618109442
                ],
                [
                  0.099457227,
                  53.622300523
                ],
                [
                  0.056162957,
                  53.641262111
                ],
                [
                  0.034515821,
                  53.646063544
                ],
                [
                  0.014821811,
                  53.643255927
                ],
                [
                  0,
                  53.6377450361
                ],
                [
                  0,
                  53.7611869504
                ]
              ]
            ],
            [
              [
                [
                  7.085459832,
                  53.686997789
                ],
                [
                  6.87378991,
                  53.672756252
                ],
                [
                  6.910817905,
                  53.6836612
                ],
                [
                  7.047048373,
                  53.694159247
                ],
                [
                  7.085459832,
                  53.686997789
                ]
              ]
            ],
            [
              [
                [
                  6.742198113,
                  53.57835521
                ],
                [
                  6.749522332,
                  53.572414455
                ],
                [
                  6.75652103,
                  53.562892971
                ],
                [
                  6.747569207,
                  53.565985419
                ],
                [
                  6.734629754,
                  53.575181382
                ],
                [
                  6.726084832,
                  53.577134507
                ],
                [
                  6.715993686,
                  53.576076565
                ],
                [
                  6.701182488,
                  53.571437893
                ],
                [
                  6.695078972,
                  53.57029857
                ],
                [
                  6.677093946,
                  53.575628973
                ],
                [
                  6.663340691,
                  53.587347723
                ],
                [
                  6.659515821,
                  53.599107164
                ],
                [
                  6.671153191,
                  53.604437567
                ],
                [
                  6.747325066,
                  53.618353583
                ],
                [
                  6.784678582,
                  53.620062567
                ],
                [
                  6.798106316,
                  53.604437567
                ],
                [
                  6.775645379,
                  53.602484442
                ],
                [
                  6.74089603,
                  53.593451239
                ],
                [
                  6.722422722,
                  53.590765692
                ],
                [
                  6.722422722,
                  53.584621486
                ],
                [
                  6.733571811,
                  53.58201732
                ],
                [
                  6.742198113,
                  53.57835521
                ]
              ]
            ],
            [
              [
                [
                  7.3466903,
                  53.723211981
                ],
                [
                  7.345062696,
                  53.722072658
                ],
                [
                  7.342295769,
                  53.722113348
                ],
                [
                  7.29574629,
                  53.71100495
                ],
                [
                  7.173594597,
                  53.701402085
                ],
                [
                  7.133148634,
                  53.708075262
                ],
                [
                  7.178965691,
                  53.724066473
                ],
                [
                  7.232920769,
                  53.729437567
                ],
                [
                  7.346202019,
                  53.727972723
                ],
                [
                  7.3466903,
                  53.723211981
                ]
              ]
            ],
            [
              [
                [
                  7.627207879,
                  53.750921942
                ],
                [
                  7.625743035,
                  53.74994538
                ],
                [
                  7.623301629,
                  53.74998607
                ],
                [
                  7.620616082,
                  53.749090887
                ],
                [
                  7.547699415,
                  53.750433661
                ],
                [
                  7.513926629,
                  53.745510158
                ],
                [
                  7.511241082,
                  53.727972723
                ],
                [
                  7.481944207,
                  53.727118231
                ],
                [
                  7.472992384,
                  53.731878973
                ],
                [
                  7.469574415,
                  53.745347398
                ],
                [
                  7.474619988,
                  53.756822007
                ],
                [
                  7.48698978,
                  53.761419989
                ],
                [
                  7.517425977,
                  53.762111721
                ],
                [
                  7.606618686,
                  53.762600002
                ],
                [
                  7.626719597,
                  53.755275783
                ],
                [
                  7.627207879,
                  53.750921942
                ]
              ]
            ],
            [
              [
                [
                  7.798594597,
                  53.776353257
                ],
                [
                  7.77621504,
                  53.767971096
                ],
                [
                  7.748220248,
                  53.760931708
                ],
                [
                  7.719493035,
                  53.759914455
                ],
                [
                  7.694997592,
                  53.76951732
                ],
                [
                  7.685883009,
                  53.7617862
                ],
                [
                  7.677093946,
                  53.75779857
                ],
                [
                  7.668630405,
                  53.75787995
                ],
                [
                  7.660899285,
                  53.762111721
                ],
                [
                  7.68628991,
                  53.780991929
                ],
                [
                  7.728282097,
                  53.786566473
                ],
                [
                  7.812836134,
                  53.783148505
                ],
                [
                  7.812836134,
                  53.776353257
                ],
                [
                  7.798594597,
                  53.776353257
                ]
              ]
            ],
            [
              [
                [
                  10.349619988,
                  54.896714585
                ],
                [
                  10.364268425,
                  54.893011786
                ],
                [
                  10.379405144,
                  54.893052476
                ],
                [
                  10.391368035,
                  54.895453192
                ],
                [
                  10.395843946,
                  54.903469143
                ],
                [
                  10.388845248,
                  54.920314846
                ],
                [
                  10.403086785,
                  54.908392645
                ],
                [
                  10.415212436,
                  54.878485419
                ],
                [
                  10.426036004,
                  54.872503973
                ],
                [
                  10.446787957,
                  54.872381903
                ],
                [
                  10.460948113,
                  54.874497789
                ],
                [
                  10.46363366,
                  54.882473049
                ],
                [
                  10.450205925,
                  54.899807033
                ],
                [
                  10.466644727,
                  54.89057038
                ],
                [
                  10.485687696,
                  54.883693752
                ],
                [
                  10.499196811,
                  54.874579169
                ],
                [
                  10.49870853,
                  54.858872789
                ],
                [
                  10.508148634,
                  54.854925848
                ],
                [
                  10.5185653,
                  54.851996161
                ],
                [
                  10.44011478,
                  54.841498114
                ],
                [
                  10.418630405,
                  54.827826239
                ],
                [
                  10.406260613,
                  54.824693101
                ],
                [
                  10.383474155,
                  54.830755927
                ],
                [
                  10.211436394,
                  54.939357815
                ],
                [
                  10.195160352,
                  54.961859442
                ],
                [
                  10.189219597,
                  54.977484442
                ],
                [
                  10.203868035,
                  54.968085028
                ],
                [
                  10.288747592,
                  54.940741278
                ],
                [
                  10.313731316,
                  54.927720445
                ],
                [
                  10.337250196,
                  54.905910549
                ],
                [
                  10.349619988,
                  54.896714585
                ]
              ]
            ],
            [
              [
                [
                  11.25,
                  54.4201229401
                ],
                [
                  11.188487175,
                  54.426174221
                ],
                [
                  11.170176629,
                  54.420070705
                ],
                [
                  11.17465254,
                  54.416001695
                ],
                [
                  11.179047071,
                  54.41421133
                ],
                [
                  11.138845248,
                  54.412665106
                ],
                [
                  11.112640821,
                  54.415228583
                ],
                [
                  11.101328972,
                  54.423488674
                ],
                [
                  11.103282097,
                  54.443833726
                ],
                [
                  11.098643425,
                  54.451646226
                ],
                [
                  11.084320509,
                  54.454779364
                ],
                [
                  11.058116082,
                  54.455267645
                ],
                [
                  11.047373894,
                  54.45327383
                ],
                [
                  11.039886915,
                  54.447333075
                ],
                [
                  11.032481316,
                  54.447333075
                ],
                [
                  11.029144727,
                  54.454657294
                ],
                [
                  11.025726759,
                  54.458807684
                ],
                [
                  11.020355665,
                  54.458970445
                ],
                [
                  11.008474155,
                  54.454657294
                ],
                [
                  11.005707227,
                  54.468451239
                ],
                [
                  11.033702019,
                  54.508856512
                ],
                [
                  11.07292728,
                  54.53119538
                ],
                [
                  11.121267123,
                  54.535956122
                ],
                [
                  11.206553582,
                  54.514471747
                ],
                [
                  11.232106967,
                  54.501654364
                ],
                [
                  11.240000847,
                  54.495550848
                ],
                [
                  11.25,
                  54.4847713108
                ],
                [
                  11.25,
                  54.4201229401
                ]
              ]
            ],
            [
              [
                [
                  8.360687696,
                  54.710028387
                ],
                [
                  8.359141472,
                  54.708929755
                ],
                [
                  8.356293165,
                  54.709173895
                ],
                [
                  8.353526238,
                  54.707993882
                ],
                [
                  8.34245853,
                  54.701402085
                ],
                [
                  8.332367384,
                  54.693793036
                ],
                [
                  8.382334832,
                  54.639146226
                ],
                [
                  8.4013778,
                  54.63296133
                ],
                [
                  8.387705925,
                  54.626125393
                ],
                [
                  8.353688998,
                  54.618963934
                ],
                [
                  8.330251498,
                  54.631415106
                ],
                [
                  8.31137129,
                  54.651353257
                ],
                [
                  8.291514519,
                  54.667059637
                ],
                [
                  8.320485873,
                  54.698716539
                ],
                [
                  8.338389519,
                  54.710150458
                ],
                [
                  8.360362175,
                  54.71482982
                ],
                [
                  8.360687696,
                  54.710028387
                ]
              ]
            ],
            [
              [
                [
                  8.574066602,
                  54.694403387
                ],
                [
                  8.565765821,
                  54.68756745
                ],
                [
                  8.552093946,
                  54.685003973
                ],
                [
                  8.535166863,
                  54.686183986
                ],
                [
                  8.519867384,
                  54.689601955
                ],
                [
                  8.511241082,
                  54.693793036
                ],
                [
                  8.485199415,
                  54.688055731
                ],
                [
                  8.452810092,
                  54.693833726
                ],
                [
                  8.394541863,
                  54.71482982
                ],
                [
                  8.414235873,
                  54.735785223
                ],
                [
                  8.436778191,
                  54.748480536
                ],
                [
                  8.464121941,
                  54.754787502
                ],
                [
                  8.497569207,
                  54.756415106
                ],
                [
                  8.553233269,
                  54.754461981
                ],
                [
                  8.575938347,
                  54.746405341
                ],
                [
                  8.593760613,
                  54.728501695
                ],
                [
                  8.593760613,
                  54.721665757
                ],
                [
                  8.585459832,
                  54.713609117
                ],
                [
                  8.574066602,
                  54.694403387
                ]
              ]
            ],
            [
              [
                [
                  8.887950066,
                  54.468451239
                ],
                [
                  8.844493035,
                  54.466498114
                ],
                [
                  8.823903842,
                  54.470851955
                ],
                [
                  8.812836134,
                  54.482123114
                ],
                [
                  8.823741082,
                  54.485541083
                ],
                [
                  8.825531446,
                  54.491197007
                ],
                [
                  8.820974155,
                  54.497259833
                ],
                [
                  8.812836134,
                  54.501939195
                ],
                [
                  8.844493035,
                  54.51972077
                ],
                [
                  8.879649285,
                  54.529120184
                ],
                [
                  8.919200066,
                  54.530462958
                ],
                [
                  8.963145379,
                  54.52366771
                ],
                [
                  8.958506707,
                  54.522447007
                ],
                [
                  8.956309441,
                  54.51943594
                ],
                [
                  8.95582116,
                  54.514960028
                ],
                [
                  8.956879102,
                  54.509426174
                ],
                [
                  8.938487175,
                  54.499090887
                ],
                [
                  8.925791863,
                  54.486761786
                ],
                [
                  8.911306186,
                  54.475490627
                ],
                [
                  8.887950066,
                  54.468451239
                ]
              ]
            ],
            [
              [
                [
                  8.669769727,
                  54.501898505
                ],
                [
                  8.641286655,
                  54.49237702
                ],
                [
                  8.618825717,
                  54.492621161
                ],
                [
                  8.606130405,
                  54.499212958
                ],
                [
                  8.595876498,
                  54.513657945
                ],
                [
                  8.602061394,
                  54.529771226
                ],
                [
                  8.6201278,
                  54.537909247
                ],
                [
                  8.627452019,
                  54.539943752
                ],
                [
                  8.634532097,
                  54.542629299
                ],
                [
                  8.698903842,
                  54.55857982
                ],
                [
                  8.700938347,
                  54.547756252
                ],
                [
                  8.692881707,
                  54.523260809
                ],
                [
                  8.669769727,
                  54.501898505
                ]
              ]
            ],
            [
              [
                [
                  11.25,
                  54.709213468
                ],
                [
                  11.187754754,
                  54.732245184
                ],
                [
                  11.138194207,
                  54.738592841
                ],
                [
                  11.08464603,
                  54.753119208
                ],
                [
                  11.030528191,
                  54.760646877
                ],
                [
                  11.009287957,
                  54.771633205
                ],
                [
                  10.999196811,
                  54.786769924
                ],
                [
                  11.005707227,
                  54.803656317
                ],
                [
                  11.030772332,
                  54.812160549
                ],
                [
                  11.06128991,
                  54.809312242
                ],
                [
                  11.089691602,
                  54.810614325
                ],
                [
                  11.10816491,
                  54.831529039
                ],
                [
                  11.091970248,
                  54.835028387
                ],
                [
                  11.078379754,
                  54.841131903
                ],
                [
                  11.025238477,
                  54.879461981
                ],
                [
                  11.018809441,
                  54.886175848
                ],
                [
                  11.018809441,
                  54.903387762
                ],
                [
                  11.032399936,
                  54.919256903
                ],
                [
                  11.073985222,
                  54.948187567
                ],
                [
                  11.088145379,
                  54.944159247
                ],
                [
                  11.231700066,
                  54.961249091
                ],
                [
                  11.25,
                  54.9562304833
                ],
                [
                  11.25,
                  54.709213468
                ]
              ]
            ],
            [
              [
                [
                  9.793467644,
                  55.080755927
                ],
                [
                  9.853037957,
                  55.040106512
                ],
                [
                  9.884776238,
                  55.030218817
                ],
                [
                  9.929047071,
                  55.026190497
                ],
                [
                  9.960948113,
                  55.015041408
                ],
                [
                  9.986582879,
                  54.997748114
                ],
                [
                  10.011403842,
                  54.975531317
                ],
                [
                  10.025889519,
                  54.959784247
                ],
                [
                  10.06511478,
                  54.89081452
                ],
                [
                  10.064463738,
                  54.881008205
                ],
                [
                  10.050466342,
                  54.87885163
                ],
                [
                  10.021983269,
                  54.879339911
                ],
                [
                  10.007090691,
                  54.874823309
                ],
                [
                  9.987559441,
                  54.865912177
                ],
                [
                  9.968028191,
                  54.85952383
                ],
                [
                  9.953623894,
                  54.862616278
                ],
                [
                  9.937185092,
                  54.870917059
                ],
                [
                  9.891123894,
                  54.879299221
                ],
                [
                  9.874278191,
                  54.886175848
                ],
                [
                  9.874278191,
                  54.893011786
                ],
                [
                  9.900889519,
                  54.900702216
                ],
                [
                  9.93230228,
                  54.892808335
                ],
                [
                  9.9638778,
                  54.879950262
                ],
                [
                  9.991547071,
                  54.872503973
                ],
                [
                  9.991547071,
                  54.879339911
                ],
                [
                  9.943695509,
                  54.903631903
                ],
                [
                  9.898285352,
                  54.912990627
                ],
                [
                  9.887950066,
                  54.913519598
                ],
                [
                  9.8779403,
                  54.911322333
                ],
                [
                  9.863536004,
                  54.903062242
                ],
                [
                  9.853770379,
                  54.899807033
                ],
                [
                  9.814707879,
                  54.901068427
                ],
                [
                  9.780935092,
                  54.916815497
                ],
                [
                  9.761241082,
                  54.943060614
                ],
                [
                  9.76441491,
                  54.975531317
                ],
                [
                  9.758148634,
                  54.975531317
                ],
                [
                  9.758148634,
                  54.981756903
                ],
                [
                  9.78028405,
                  54.97284577
                ],
                [
                  9.804047071,
                  54.95718008
                ],
                [
                  9.827403191,
                  54.94546133
                ],
                [
                  9.847504102,
                  54.948187567
                ],
                [
                  9.843272332,
                  54.951727606
                ],
                [
                  9.836680535,
                  54.958563544
                ],
                [
                  9.832774285,
                  54.965155341
                ],
                [
                  9.836680535,
                  54.968085028
                ],
                [
                  9.842133009,
                  54.970282294
                ],
                [
                  9.835215691,
                  54.975165106
                ],
                [
                  9.793711785,
                  54.99217357
                ],
                [
                  9.786794467,
                  55.00014883
                ],
                [
                  9.799082879,
                  55.009711005
                ],
                [
                  9.799082879,
                  55.016546942
                ],
                [
                  9.720550977,
                  55.012274481
                ],
                [
                  9.706879102,
                  55.013128973
                ],
                [
                  9.696950717,
                  55.017523505
                ],
                [
                  9.684825066,
                  55.018540757
                ],
                [
                  9.674164259,
                  55.021063544
                ],
                [
                  9.668793165,
                  55.030218817
                ],
                [
                  9.672373894,
                  55.034654039
                ],
                [
                  9.691254102,
                  55.042792059
                ],
                [
                  9.696625196,
                  55.05068594
                ],
                [
                  9.678233269,
                  55.050197658
                ],
                [
                  9.661631707,
                  55.046535549
                ],
                [
                  9.645518425,
                  55.044867255
                ],
                [
                  9.628428582,
                  55.05068594
                ],
                [
                  9.628428582,
                  55.058050848
                ],
                [
                  9.716644727,
                  55.08222077
                ],
                [
                  9.751963738,
                  55.085394598
                ],
                [
                  9.793467644,
                  55.080755927
                ]
              ]
            ],
            [
              [
                [
                  8.388356967,
                  54.894232489
                ],
                [
                  8.43653405,
                  54.887274481
                ],
                [
                  8.654470248,
                  54.893622137
                ],
                [
                  8.629405144,
                  54.882147528
                ],
                [
                  8.504405144,
                  54.886175848
                ],
                [
                  8.488780144,
                  54.881293036
                ],
                [
                  8.461192254,
                  54.868801174
                ],
                [
                  8.446055535,
                  54.866278387
                ],
                [
                  8.377126498,
                  54.866278387
                ],
                [
                  8.370616082,
                  54.868231512
                ],
                [
                  8.36198978,
                  54.876939195
                ],
                [
                  8.353526238,
                  54.879339911
                ],
                [
                  8.343923373,
                  54.87909577
                ],
                [
                  8.337412957,
                  54.877590236
                ],
                [
                  8.307139519,
                  54.865383205
                ],
                [
                  8.302012566,
                  54.862616278
                ],
                [
                  8.299327019,
                  54.855292059
                ],
                [
                  8.297862175,
                  54.835598049
                ],
                [
                  8.294932488,
                  54.831529039
                ],
                [
                  8.298350457,
                  54.776922919
                ],
                [
                  8.29574629,
                  54.759100653
                ],
                [
                  8.290700717,
                  54.745306708
                ],
                [
                  8.284434441,
                  54.74237702
                ],
                [
                  8.277842644,
                  54.756415106
                ],
                [
                  8.277028842,
                  54.782782294
                ],
                [
                  8.288584832,
                  54.891302802
                ],
                [
                  8.298024936,
                  54.912543036
                ],
                [
                  8.37370853,
                  55.034979559
                ],
                [
                  8.415782097,
                  55.065334377
                ],
                [
                  8.463389519,
                  55.05068594
                ],
                [
                  8.402354363,
                  55.048773505
                ],
                [
                  8.394541863,
                  55.043850002
                ],
                [
                  8.422211134,
                  55.042181708
                ],
                [
                  8.430430535,
                  55.030015367
                ],
                [
                  8.421560092,
                  55.016262111
                ],
                [
                  8.380869988,
                  55.003078518
                ],
                [
                  8.36198978,
                  54.986802476
                ],
                [
                  8.351573113,
                  54.966742255
                ],
                [
                  8.360362175,
                  54.948187567
                ],
                [
                  8.3545028,
                  54.912746486
                ],
                [
                  8.388356967,
                  54.894232489
                ]
              ]
            ],
            [
              [
                [
                  10.837738477,
                  54.937241929
                ],
                [
                  10.74105879,
                  54.752386786
                ],
                [
                  10.731293165,
                  54.740057684
                ],
                [
                  10.71753991,
                  54.735785223
                ],
                [
                  10.693858269,
                  54.735296942
                ],
                [
                  10.681895379,
                  54.744818427
                ],
                [
                  10.656423373,
                  54.803656317
                ],
                [
                  10.645518425,
                  54.814601955
                ],
                [
                  10.632090691,
                  54.823431708
                ],
                [
                  10.601084832,
                  54.838324286
                ],
                [
                  10.625336134,
                  54.839300848
                ],
                [
                  10.640879754,
                  54.843207098
                ],
                [
                  10.653493686,
                  54.85162995
                ],
                [
                  10.669281446,
                  54.866278387
                ],
                [
                  10.67855879,
                  54.88304271
                ],
                [
                  10.684418165,
                  54.887844143
                ],
                [
                  10.693858269,
                  54.88275788
                ],
                [
                  10.698903842,
                  54.881170966
                ],
                [
                  10.724457227,
                  54.886175848
                ],
                [
                  10.722178582,
                  54.896063544
                ],
                [
                  10.71778405,
                  54.907294012
                ],
                [
                  10.708994988,
                  54.902980861
                ],
                [
                  10.700368686,
                  54.901556708
                ],
                [
                  10.691905144,
                  54.902980861
                ],
                [
                  10.682953321,
                  54.907294012
                ],
                [
                  10.697032097,
                  54.931341864
                ],
                [
                  10.718272332,
                  54.94916413
                ],
                [
                  10.774099155,
                  54.986558335
                ],
                [
                  10.798187696,
                  54.996568101
                ],
                [
                  10.854991082,
                  55.043850002
                ],
                [
                  10.86198978,
                  55.072088934
                ],
                [
                  10.895518425,
                  55.121527411
                ],
                [
                  10.934255405,
                  55.159654039
                ],
                [
                  10.956716342,
                  55.153713283
                ],
                [
                  10.90894616,
                  55.030218817
                ],
                [
                  10.889903191,
                  54.997381903
                ],
                [
                  10.837738477,
                  54.937241929
                ]
              ]
            ],
            [
              [
                [
                  8.411957227,
                  55.438706773
                ],
                [
                  8.42855879,
                  55.43353913
                ],
                [
                  8.448903842,
                  55.435532945
                ],
                [
                  8.463389519,
                  55.427435614
                ],
                [
                  8.463063998,
                  55.415716864
                ],
                [
                  8.450205925,
                  55.393377997
                ],
                [
                  8.452891472,
                  55.383368231
                ],
                [
                  8.460459832,
                  55.372381903
                ],
                [
                  8.46745853,
                  55.353705145
                ],
                [
                  8.476410352,
                  55.345445054
                ],
                [
                  8.451670769,
                  55.33974844
                ],
                [
                  8.425303582,
                  55.3555362
                ],
                [
                  8.402354363,
                  55.380031643
                ],
                [
                  8.370941602,
                  55.427435614
                ],
                [
                  8.364268425,
                  55.449042059
                ],
                [
                  8.374359571,
                  55.463283596
                ],
                [
                  8.408213738,
                  55.468410549
                ],
                [
                  8.411957227,
                  55.438706773
                ]
              ]
            ],
            [
              [
                [
                  10.338389519,
                  55.610093492
                ],
                [
                  10.407399936,
                  55.582953192
                ],
                [
                  10.423024936,
                  55.572007554
                ],
                [
                  10.435394727,
                  55.559719143
                ],
                [
                  10.44418379,
                  55.553168036
                ],
                [
                  10.453623894,
                  55.550279039
                ],
                [
                  10.471934441,
                  55.549017645
                ],
                [
                  10.488536004,
                  55.545477606
                ],
                [
                  10.518809441,
                  55.533433335
                ],
                [
                  10.502452019,
                  55.537176825
                ],
                [
                  10.486827019,
                  55.537176825
                ],
                [
                  10.47527103,
                  55.531968492
                ],
                [
                  10.470713738,
                  55.520209052
                ],
                [
                  10.474375847,
                  55.51581452
                ],
                [
                  10.489105665,
                  55.509100653
                ],
                [
                  10.49122155,
                  55.503119208
                ],
                [
                  10.486013217,
                  55.494777736
                ],
                [
                  10.477793816,
                  55.492499091
                ],
                [
                  10.46778405,
                  55.49213288
                ],
                [
                  10.457041863,
                  55.489447333
                ],
                [
                  10.419606967,
                  55.458807684
                ],
                [
                  10.436045769,
                  55.442124742
                ],
                [
                  10.47152754,
                  55.443060614
                ],
                [
                  10.49122155,
                  55.465277411
                ],
                [
                  10.502452019,
                  55.463568427
                ],
                [
                  10.566905144,
                  55.482652085
                ],
                [
                  10.604746941,
                  55.489447333
                ],
                [
                  10.609141472,
                  55.492580471
                ],
                [
                  10.607188347,
                  55.499416408
                ],
                [
                  10.602305535,
                  55.506252346
                ],
                [
                  10.597666863,
                  55.509344794
                ],
                [
                  10.58871504,
                  55.510687567
                ],
                [
                  10.579112175,
                  55.514105536
                ],
                [
                  10.571055535,
                  55.518703518
                ],
                [
                  10.566905144,
                  55.52362702
                ],
                [
                  10.569834832,
                  55.532416083
                ],
                [
                  10.582286004,
                  55.529120184
                ],
                [
                  10.595550977,
                  55.521389065
                ],
                [
                  10.601084832,
                  55.516791083
                ],
                [
                  10.613780144,
                  55.527899481
                ],
                [
                  10.610524936,
                  55.543646552
                ],
                [
                  10.600840691,
                  55.561224677
                ],
                [
                  10.594248894,
                  55.57827383
                ],
                [
                  10.599131707,
                  55.573675848
                ],
                [
                  10.614593946,
                  55.564601955
                ],
                [
                  10.615000847,
                  55.581447658
                ],
                [
                  10.60840905,
                  55.606268622
                ],
                [
                  10.608571811,
                  55.612982489
                ],
                [
                  10.62761478,
                  55.613592841
                ],
                [
                  10.656911655,
                  55.594875393
                ],
                [
                  10.704112175,
                  55.550279039
                ],
                [
                  10.7060653,
                  55.543890692
                ],
                [
                  10.707041863,
                  55.534979559
                ],
                [
                  10.709239129,
                  55.527044989
                ],
                [
                  10.714366082,
                  55.52362702
                ],
                [
                  10.716807488,
                  55.521429755
                ],
                [
                  10.738129102,
                  55.509344794
                ],
                [
                  10.744476759,
                  55.495550848
                ],
                [
                  10.742360873,
                  55.487494208
                ],
                [
                  10.73308353,
                  55.481878973
                ],
                [
                  10.703949415,
                  55.471136786
                ],
                [
                  10.657481316,
                  55.459702867
                ],
                [
                  10.588389519,
                  55.463364976
                ],
                [
                  10.571299675,
                  55.461249091
                ],
                [
                  10.559418165,
                  55.455308335
                ],
                [
                  10.554047071,
                  55.442572333
                ],
                [
                  10.563324415,
                  55.436224677
                ],
                [
                  10.579437696,
                  55.435858466
                ],
                [
                  10.594248894,
                  55.441066799
                ],
                [
                  10.589610222,
                  55.446234442
                ],
                [
                  10.58855228,
                  55.44940827
                ],
                [
                  10.595957879,
                  55.459662177
                ],
                [
                  10.615733269,
                  55.456854559
                ],
                [
                  10.682953321,
                  55.447902736
                ],
                [
                  10.69792728,
                  55.440252997
                ],
                [
                  10.796641472,
                  55.358547268
                ],
                [
                  10.803070509,
                  55.349758205
                ],
                [
                  10.828379754,
                  55.306586005
                ],
                [
                  10.834320509,
                  55.290269273
                ],
                [
                  10.82691491,
                  55.290269273
                ],
                [
                  10.81511478,
                  55.3008487
                ],
                [
                  10.796885613,
                  55.307684637
                ],
                [
                  10.78028405,
                  55.30491771
                ],
                [
                  10.772959832,
                  55.287095445
                ],
                [
                  10.778656446,
                  55.274847723
                ],
                [
                  10.805349155,
                  55.250433661
                ],
                [
                  10.813324415,
                  55.235581773
                ],
                [
                  10.81519616,
                  55.214056708
                ],
                [
                  10.812673373,
                  55.194281317
                ],
                [
                  10.806000196,
                  55.177394924
                ],
                [
                  10.790782097,
                  55.156927802
                ],
                [
                  10.78785241,
                  55.149481512
                ],
                [
                  10.786631707,
                  55.129461981
                ],
                [
                  10.783376498,
                  55.124212958
                ],
                [
                  10.758799675,
                  55.105292059
                ],
                [
                  10.749359571,
                  55.093085028
                ],
                [
                  10.742686394,
                  55.081691799
                ],
                [
                  10.733653191,
                  55.071844794
                ],
                [
                  10.71778405,
                  55.064276434
                ],
                [
                  10.705577019,
                  55.06256745
                ],
                [
                  10.666270379,
                  55.064276434
                ],
                [
                  10.621429884,
                  55.064276434
                ],
                [
                  10.604746941,
                  55.06256745
                ],
                [
                  10.586110873,
                  55.057521877
                ],
                [
                  10.568858269,
                  55.049872137
                ],
                [
                  10.556407097,
                  55.040106512
                ],
                [
                  10.538259311,
                  55.029730536
                ],
                [
                  10.516856316,
                  55.03131745
                ],
                [
                  10.477549675,
                  55.043850002
                ],
                [
                  10.410655144,
                  55.04694245
                ],
                [
                  10.388845248,
                  55.05068594
                ],
                [
                  10.379161004,
                  55.054510809
                ],
                [
                  10.371348504,
                  55.059027411
                ],
                [
                  10.362559441,
                  55.06273021
                ],
                [
                  10.350922071,
                  55.064276434
                ],
                [
                  10.325938347,
                  55.062892971
                ],
                [
                  10.312754754,
                  55.063666083
                ],
                [
                  10.234222852,
                  55.092230536
                ],
                [
                  10.205251498,
                  55.09369538
                ],
                [
                  10.197601759,
                  55.08608633
                ],
                [
                  10.197032097,
                  55.064276434
                ],
                [
                  10.181895379,
                  55.070868231
                ],
                [
                  10.158376498,
                  55.086655992
                ],
                [
                  10.141774936,
                  55.092230536
                ],
                [
                  10.121267123,
                  55.092474677
                ],
                [
                  10.083506707,
                  55.086981512
                ],
                [
                  10.065928582,
                  55.092230536
                ],
                [
                  10.142588738,
                  55.125799872
                ],
                [
                  10.156016472,
                  55.140082098
                ],
                [
                  10.138682488,
                  55.154282945
                ],
                [
                  10.126149936,
                  55.170640367
                ],
                [
                  10.112966342,
                  55.18378327
                ],
                [
                  10.094004754,
                  55.188421942
                ],
                [
                  10.078949415,
                  55.185939846
                ],
                [
                  10.067556186,
                  55.182277736
                ],
                [
                  10.055837436,
                  55.17975495
                ],
                [
                  10.039317254,
                  55.180975653
                ],
                [
                  10.016612175,
                  55.194281317
                ],
                [
                  10.003591342,
                  55.197333075
                ],
                [
                  9.991547071,
                  55.188421942
                ],
                [
                  9.994476759,
                  55.172796942
                ],
                [
                  10.029144727,
                  55.142401434
                ],
                [
                  10.025645379,
                  55.125718492
                ],
                [
                  10.020681186,
                  55.124457098
                ],
                [
                  9.985524936,
                  55.127752997
                ],
                [
                  9.982920769,
                  55.130601304
                ],
                [
                  9.984385613,
                  55.134670315
                ],
                [
                  9.984141472,
                  55.140082098
                ],
                [
                  9.98698978,
                  55.139349677
                ],
                [
                  9.989756707,
                  55.143377997
                ],
                [
                  9.988780144,
                  55.151841539
                ],
                [
                  9.974294467,
                  55.174017645
                ],
                [
                  9.972015821,
                  55.184719143
                ],
                [
                  9.974294467,
                  55.19525788
                ],
                [
                  9.980723504,
                  55.204901434
                ],
                [
                  9.9795028,
                  55.212836005
                ],
                [
                  9.964121941,
                  55.218166408
                ],
                [
                  9.924001498,
                  55.223944403
                ],
                [
                  9.911387566,
                  55.228501695
                ],
                [
                  9.900157097,
                  55.234116929
                ],
                [
                  9.895355665,
                  55.238999742
                ],
                [
                  9.89323978,
                  55.244452216
                ],
                [
                  9.883962436,
                  55.253485419
                ],
                [
                  9.88168379,
                  55.259507554
                ],
                [
                  9.883962436,
                  55.26561107
                ],
                [
                  9.89323978,
                  55.274644273
                ],
                [
                  9.895355665,
                  55.280259507
                ],
                [
                  9.89323978,
                  55.291245835
                ],
                [
                  9.883962436,
                  55.30878327
                ],
                [
                  9.88168379,
                  55.314439195
                ],
                [
                  9.884776238,
                  55.348863023
                ],
                [
                  9.874522332,
                  55.353338934
                ],
                [
                  9.858897332,
                  55.354071356
                ],
                [
                  9.829844597,
                  55.352280992
                ],
                [
                  9.816579623,
                  55.355210679
                ],
                [
                  9.802419467,
                  55.362372137
                ],
                [
                  9.778086785,
                  55.380275783
                ],
                [
                  9.794932488,
                  55.383856512
                ],
                [
                  9.813649936,
                  55.385158596
                ],
                [
                  9.830088738,
                  55.388902085
                ],
                [
                  9.840098504,
                  55.400091864
                ],
                [
                  9.785492384,
                  55.413763739
                ],
                [
                  9.793711785,
                  55.412787177
                ],
                [
                  9.819590691,
                  55.413763739
                ],
                [
                  9.809255405,
                  55.425482489
                ],
                [
                  9.791026238,
                  55.431830145
                ],
                [
                  9.751312696,
                  55.434881903
                ],
                [
                  9.7373153,
                  55.438177802
                ],
                [
                  9.703461134,
                  55.462144273
                ],
                [
                  9.703461134,
                  55.468410549
                ],
                [
                  9.730235222,
                  55.461493231
                ],
                [
                  9.758474155,
                  55.447495835
                ],
                [
                  9.786306186,
                  55.437201239
                ],
                [
                  9.812185092,
                  55.441066799
                ],
                [
                  9.713389519,
                  55.491034247
                ],
                [
                  9.676280144,
                  55.495672919
                ],
                [
                  9.683929884,
                  55.506048895
                ],
                [
                  9.693532748,
                  55.510199286
                ],
                [
                  9.704763217,
                  55.512396552
                ],
                [
                  9.71778405,
                  55.516791083
                ],
                [
                  9.755137566,
                  55.544134833
                ],
                [
                  9.809092644,
                  55.550279039
                ],
                [
                  9.827403191,
                  55.548407294
                ],
                [
                  9.83082116,
                  55.54311758
                ],
                [
                  9.831309441,
                  55.534735419
                ],
                [
                  9.840098504,
                  55.52362702
                ],
                [
                  9.888194207,
                  55.508693752
                ],
                [
                  9.94027754,
                  55.519232489
                ],
                [
                  10.039317254,
                  55.557766018
                ],
                [
                  10.168630405,
                  55.58226146
                ],
                [
                  10.212657097,
                  55.600653387
                ],
                [
                  10.2373153,
                  55.6055362
                ],
                [
                  10.264170769,
                  55.606634833
                ],
                [
                  10.27214603,
                  55.6055362
                ],
                [
                  10.272797071,
                  55.602525132
                ],
                [
                  10.279063347,
                  55.588324286
                ],
                [
                  10.279551629,
                  55.585109768
                ],
                [
                  10.293630405,
                  55.588080145
                ],
                [
                  10.297129754,
                  55.595648505
                ],
                [
                  10.293793165,
                  55.616115627
                ],
                [
                  10.3076278,
                  55.618231512
                ],
                [
                  10.338389519,
                  55.610093492
                ]
              ]
            ],
            [
              [
                [
                  11.25,
                  55.2489493949
                ],
                [
                  11.241953972,
                  55.248683986
                ],
                [
                  11.238780144,
                  55.25413646
                ],
                [
                  11.241547071,
                  55.278509833
                ],
                [
                  11.235118035,
                  55.284002997
                ],
                [
                  11.217133009,
                  55.290228583
                ],
                [
                  11.162119988,
                  55.319159247
                ],
                [
                  11.152842644,
                  55.328436591
                ],
                [
                  11.161957227,
                  55.330877997
                ],
                [
                  11.176442905,
                  55.331854559
                ],
                [
                  11.188243035,
                  55.335272528
                ],
                [
                  11.19011478,
                  55.345445054
                ],
                [
                  11.18230228,
                  55.350409247
                ],
                [
                  11.167979363,
                  55.352769273
                ],
                [
                  11.152598504,
                  55.353216864
                ],
                [
                  11.142344597,
                  55.352280992
                ],
                [
                  11.13542728,
                  55.346869208
                ],
                [
                  11.130869988,
                  55.338446356
                ],
                [
                  11.123545769,
                  55.331854559
                ],
                [
                  11.10816491,
                  55.331854559
                ],
                [
                  11.101898634,
                  55.336330471
                ],
                [
                  11.087738477,
                  55.358547268
                ],
                [
                  11.087738477,
                  55.365952867
                ],
                [
                  11.114593946,
                  55.364406643
                ],
                [
                  11.128916863,
                  55.365179755
                ],
                [
                  11.138926629,
                  55.369370835
                ],
                [
                  11.147715691,
                  55.375921942
                ],
                [
                  11.1591903,
                  55.381293036
                ],
                [
                  11.171722852,
                  55.385077216
                ],
                [
                  11.183278842,
                  55.386419989
                ],
                [
                  11.204356316,
                  55.391831773
                ],
                [
                  11.214203321,
                  55.403794664
                ],
                [
                  11.213145379,
                  55.415757554
                ],
                [
                  11.200938347,
                  55.421210028
                ],
                [
                  11.204844597,
                  55.431341864
                ],
                [
                  11.196462436,
                  55.453843492
                ],
                [
                  11.176442905,
                  55.489447333
                ],
                [
                  11.163910352,
                  55.501898505
                ],
                [
                  11.15113366,
                  55.510321356
                ],
                [
                  11.13559004,
                  55.515122789
                ],
                [
                  11.115000847,
                  55.516791083
                ],
                [
                  11.097178582,
                  55.509507554
                ],
                [
                  11.085785352,
                  55.507554429
                ],
                [
                  11.08090254,
                  55.513088283
                ],
                [
                  11.082774285,
                  55.526556708
                ],
                [
                  11.08855228,
                  55.533840236
                ],
                [
                  11.098155144,
                  55.536688544
                ],
                [
                  11.111582879,
                  55.537298895
                ],
                [
                  11.137950066,
                  55.54291413
                ],
                [
                  11.148448113,
                  55.557318427
                ],
                [
                  11.145681186,
                  55.576117255
                ],
                [
                  11.132090691,
                  55.595282294
                ],
                [
                  11.087901238,
                  55.626939195
                ],
                [
                  11.039235873,
                  55.643459377
                ],
                [
                  10.929942254,
                  55.66014232
                ],
                [
                  10.929942254,
                  55.667629299
                ],
                [
                  11.087738477,
                  55.66014232
                ],
                [
                  11.071055535,
                  55.676947333
                ],
                [
                  11.008636915,
                  55.692287502
                ],
                [
                  10.984629754,
                  55.701117255
                ],
                [
                  10.974294467,
                  55.71084219
                ],
                [
                  10.968272332,
                  55.718410549
                ],
                [
                  10.960215691,
                  55.724351304
                ],
                [
                  10.943614129,
                  55.729071356
                ],
                [
                  10.891449415,
                  55.731268622
                ],
                [
                  10.875498894,
                  55.736517645
                ],
                [
                  10.875498894,
                  55.742743231
                ],
                [
                  11.033050977,
                  55.729071356
                ],
                [
                  11.065684441,
                  55.732245184
                ],
                [
                  11.128184441,
                  55.74632396
                ],
                [
                  11.16277103,
                  55.749497789
                ],
                [
                  11.16277103,
                  55.742743231
                ],
                [
                  11.151703321,
                  55.743638414
                ],
                [
                  11.141123894,
                  55.743231512
                ],
                [
                  11.130869988,
                  55.741034247
                ],
                [
                  11.121836785,
                  55.736517645
                ],
                [
                  11.137543165,
                  55.719061591
                ],
                [
                  11.163422071,
                  55.705389716
                ],
                [
                  11.192637566,
                  55.700344143
                ],
                [
                  11.218028191,
                  55.708563544
                ],
                [
                  11.176442905,
                  55.729071356
                ],
                [
                  11.19011478,
                  55.736517645
                ],
                [
                  11.199473504,
                  55.731105861
                ],
                [
                  11.216156446,
                  55.728745835
                ],
                [
                  11.25,
                  55.7290514204
                ],
                [
                  11.25,
                  55.2489493949
                ]
              ]
            ],
            [
              [
                [
                  0,
                  49.3306084327
                ],
                [
                  0.012868686,
                  49.334621486
                ],
                [
                  0.040293816,
                  49.350409247
                ],
                [
                  0.063080274,
                  49.354478257
                ],
                [
                  0.071950717,
                  49.35927969
                ],
                [
                  0.095957879,
                  49.383734442
                ],
                [
                  0.162364129,
                  49.415187893
                ],
                [
                  0.286875847,
                  49.43362051
                ],
                [
                  0.411306186,
                  49.452053127
                ],
                [
                  0.457286004,
                  49.467433986
                ],
                [
                  0.476573113,
                  49.478664455
                ],
                [
                  0.493174675,
                  49.493597723
                ],
                [
                  0.422129754,
                  49.464422919
                ],
                [
                  0.339610222,
                  49.456732489
                ],
                [
                  0.25684655,
                  49.464056708
                ],
                [
                  0.185313347,
                  49.479966539
                ],
                [
                  0.164805535,
                  49.479966539
                ],
                [
                  0.14730879,
                  49.480943101
                ],
                [
                  0.124359571,
                  49.485785223
                ],
                [
                  0.10442142,
                  49.493597723
                ],
                [
                  0.095957879,
                  49.503241278
                ],
                [
                  0.09278405,
                  49.509263414
                ],
                [
                  0.078623894,
                  49.51552969
                ],
                [
                  0.075368686,
                  49.524074611
                ],
                [
                  0.076589389,
                  49.534979559
                ],
                [
                  0.079681837,
                  49.542181708
                ],
                [
                  0.130869988,
                  49.603501695
                ],
                [
                  0.17090905,
                  49.69163646
                ],
                [
                  0.185883009,
                  49.70319245
                ],
                [
                  0.235850457,
                  49.729315497
                ],
                [
                  0.246755405,
                  49.729437567
                ],
                [
                  0.25684655,
                  49.735907294
                ],
                [
                  0.387461785,
                  49.775051174
                ],
                [
                  0.397634311,
                  49.784369208
                ],
                [
                  0.522797071,
                  49.832953192
                ],
                [
                  0.55738366,
                  49.83978913
                ],
                [
                  0.5966903,
                  49.857245184
                ],
                [
                  0.6748153,
                  49.875799872
                ],
                [
                  0.760915561,
                  49.87506745
                ],
                [
                  1.172618035,
                  49.96100495
                ],
                [
                  1.196950717,
                  49.973578192
                ],
                [
                  1.221202019,
                  49.978989976
                ],
                [
                  1.260996941,
                  50.007513739
                ],
                [
                  1.391286655,
                  50.075181382
                ],
                [
                  1.44410241,
                  50.11725495
                ],
                [
                  1.45582116,
                  50.123602606
                ],
                [
                  1.464528842,
                  50.132147528
                ],
                [
                  1.486827019,
                  50.185044664
                ],
                [
                  1.521006707,
                  50.214667059
                ],
                [
                  1.555349155,
                  50.217718817
                ],
                [
                  1.654307488,
                  50.186590887
                ],
                [
                  1.664073113,
                  50.187079169
                ],
                [
                  1.672536655,
                  50.192531643
                ],
                [
                  1.672536655,
                  50.19936758
                ],
                [
                  1.661957227,
                  50.198919989
                ],
                [
                  1.65528405,
                  50.200506903
                ],
                [
                  1.650075717,
                  50.204779364
                ],
                [
                  1.644541863,
                  50.212388414
                ],
                [
                  1.665049675,
                  50.212388414
                ],
                [
                  1.665049675,
                  50.219794012
                ],
                [
                  1.645681186,
                  50.220038153
                ],
                [
                  1.625498894,
                  50.224310614
                ],
                [
                  1.610036655,
                  50.232245184
                ],
                [
                  1.603526238,
                  50.243475653
                ],
                [
                  1.593923373,
                  50.256293036
                ],
                [
                  1.551117384,
                  50.26968008
                ],
                [
                  1.541514519,
                  50.277899481
                ],
                [
                  1.543142123,
                  50.310003973
                ],
                [
                  1.551524285,
                  50.349066473
                ],
                [
                  1.572032097,
                  50.375677802
                ],
                [
                  1.594981316,
                  50.372666734
                ],
                [
                  1.610362175,
                  50.370672919
                ],
                [
                  1.610362175,
                  50.376898505
                ],
                [
                  1.555186394,
                  50.404771226
                ],
                [
                  1.555186394,
                  50.411566473
                ],
                [
                  1.573496941,
                  50.44537995
                ],
                [
                  1.574229363,
                  50.49237702
                ],
                [
                  1.579274936,
                  50.533148505
                ],
                [
                  1.610362175,
                  50.548163153
                ],
                [
                  1.583343946,
                  50.574693101
                ],
                [
                  1.577891472,
                  50.588609117
                ],
                [
                  1.573578321,
                  50.635565497
                ],
                [
                  1.563161655,
                  50.678290106
                ],
                [
                  1.562673373,
                  50.698960679
                ],
                [
                  1.567637566,
                  50.716742255
                ],
                [
                  1.58871504,
                  50.756293036
                ],
                [
                  1.600108269,
                  50.770982164
                ],
                [
                  1.605642123,
                  50.790025132
                ],
                [
                  1.599294467,
                  50.812933661
                ],
                [
                  1.583181186,
                  50.849798895
                ],
                [
                  1.58082116,
                  50.863714911
                ],
                [
                  1.580577019,
                  50.868801174
                ],
                [
                  1.604828321,
                  50.881048895
                ],
                [
                  1.613454623,
                  50.883368231
                ],
                [
                  1.634287957,
                  50.884588934
                ],
                [
                  1.653330925,
                  50.889105536
                ],
                [
                  1.670176629,
                  50.900091864
                ],
                [
                  1.699066602,
                  50.925604559
                ],
                [
                  1.729828321,
                  50.943915106
                ],
                [
                  1.921397332,
                  50.996771552
                ],
                [
                  1.939300977,
                  50.994452216
                ],
                [
                  1.973480665,
                  51.007147528
                ],
                [
                  2.134043816,
                  51.019964911
                ],
                [
                  2.305511915,
                  51.055405992
                ],
                [
                  2.316091342,
                  51.059027411
                ],
                [
                  2.324473504,
                  51.059881903
                ],
                [
                  2.384450717,
                  51.055324611
                ],
                [
                  2.466075066,
                  51.068793036
                ],
                [
                  2.50668379,
                  51.080755927
                ],
                [
                  2.521494988,
                  51.087388414
                ],
                [
                  2.521820509,
                  51.087551174
                ],
                [
                  2.5420028,
                  51.096869208
                ],
                [
                  2.579925977,
                  51.104803778
                ],
                [
                  2.715668165,
                  51.169501044
                ],
                [
                  2.923594597,
                  51.246486721
                ],
                [
                  3.124847852,
                  51.329657294
                ],
                [
                  3.348968946,
                  51.37514883
                ],
                [
                  3.349457227,
                  51.37523021
                ],
                [
                  3.510915561,
                  51.407945054
                ],
                [
                  3.525726759,
                  51.415594794
                ],
                [
                  3.541351759,
                  51.416734117
                ],
                [
                  3.604665561,
                  51.391058661
                ],
                [
                  3.70215905,
                  51.373602606
                ],
                [
                  3.734222852,
                  51.355780341
                ],
                [
                  3.755544467,
                  51.350083726
                ],
                [
                  3.79590905,
                  51.350083726
                ],
                [
                  3.833994988,
                  51.343247789
                ],
                [
                  3.85816491,
                  51.345445054
                ],
                [
                  3.95582116,
                  51.371771552
                ],
                [
                  3.969248894,
                  51.381659247
                ],
                [
                  3.974619988,
                  51.401597398
                ],
                [
                  3.984141472,
                  51.410467841
                ],
                [
                  4.005707227,
                  51.409816799
                ],
                [
                  4.029063347,
                  51.404201565
                ],
                [
                  4.043467644,
                  51.39850495
                ],
                [
                  4.050059441,
                  51.392238674
                ],
                [
                  4.06128991,
                  51.376654364
                ],
                [
                  4.070160352,
                  51.370550848
                ],
                [
                  4.081309441,
                  51.368150132
                ],
                [
                  4.105479363,
                  51.366115627
                ],
                [
                  4.115489129,
                  51.360988674
                ],
                [
                  4.121918165,
                  51.35936107
                ],
                [
                  4.156504754,
                  51.357570705
                ],
                [
                  4.173675977,
                  51.373724677
                ],
                [
                  4.180023634,
                  51.377427476
                ],
                [
                  4.199554884,
                  51.376044012
                ],
                [
                  4.22152754,
                  51.367987372
                ],
                [
                  4.222178582,
                  51.367743231
                ],
                [
                  4.24105879,
                  51.356594143
                ],
                [
                  4.24903405,
                  51.346665757
                ],
                [
                  4.256114129,
                  51.328436591
                ],
                [
                  4.272634311,
                  51.315822658
                ],
                [
                  4.290782097,
                  51.305894273
                ],
                [
                  4.302989129,
                  51.296087958
                ],
                [
                  4.306651238,
                  51.289740302
                ],
                [
                  4.308116082,
                  51.283636786
                ],
                [
                  4.305430535,
                  51.276597398
                ],
                [
                  4.298675977,
                  51.2695987
                ],
                [
                  4.296722852,
                  51.267564195
                ],
                [
                  4.308360222,
                  51.271226304
                ],
                [
                  4.316416863,
                  51.276841539
                ],
                [
                  4.33082116,
                  51.296087958
                ],
                [
                  4.297129754,
                  51.305161851
                ],
                [
                  4.289317254,
                  51.309149481
                ],
                [
                  4.285411004,
                  51.318019924
                ],
                [
                  4.286143425,
                  51.339667059
                ],
                [
                  4.283050977,
                  51.350083726
                ],
                [
                  4.275645379,
                  51.358099677
                ],
                [
                  4.261078321,
                  51.369370835
                ],
                [
                  4.257090691,
                  51.372503973
                ],
                [
                  4.24903405,
                  51.384222723
                ],
                [
                  4.246348504,
                  51.396429755
                ],
                [
                  4.246836785,
                  51.406724351
                ],
                [
                  4.24488366,
                  51.414496161
                ],
                [
                  4.234711134,
                  51.419012762
                ],
                [
                  4.222992384,
                  51.409491278
                ],
                [
                  4.201019727,
                  51.405340887
                ],
                [
                  4.111094597,
                  51.406968492
                ],
                [
                  4.090342644,
                  51.411281643
                ],
                [
                  4.070160352,
                  51.419012762
                ],
                [
                  4.015147332,
                  51.448919989
                ],
                [
                  3.99878991,
                  51.45311107
                ],
                [
                  3.957041863,
                  51.455796617
                ],
                [
                  3.943125847,
                  51.450384833
                ],
                [
                  3.913422071,
                  51.415269273
                ],
                [
                  3.902110222,
                  51.404933986
                ],
                [
                  3.886729363,
                  51.399807033
                ],
                [
                  3.850759311,
                  51.397365627
                ],
                [
                  3.837901238,
                  51.392238674
                ],
                [
                  3.82715905,
                  51.391058661
                ],
                [
                  3.816416863,
                  51.394110419
                ],
                [
                  3.789073113,
                  51.412176825
                ],
                [
                  3.728770379,
                  51.430812893
                ],
                [
                  3.689707879,
                  51.454291083
                ],
                [
                  3.674001498,
                  51.455389716
                ],
                [
                  3.632578972,
                  51.445705471
                ],
                [
                  3.610036655,
                  51.445054429
                ],
                [
                  3.55339603,
                  51.45311107
                ],
                [
                  3.535411004,
                  51.459214585
                ],
                [
                  3.520192905,
                  51.473374742
                ],
                [
                  3.50684655,
                  51.489325262
                ],
                [
                  3.49480228,
                  51.500921942
                ],
                [
                  3.461924675,
                  51.518988348
                ],
                [
                  3.451019727,
                  51.529730536
                ],
                [
                  3.447032097,
                  51.545965887
                ],
                [
                  3.457530144,
                  51.555080471
                ],
                [
                  3.560394727,
                  51.594631252
                ],
                [
                  3.828868035,
                  51.612738348
                ],
                [
                  3.851084832,
                  51.610785223
                ],
                [
                  3.86605879,
                  51.60541413
                ],
                [
                  3.882172071,
                  51.596096096
                ],
                [
                  3.896494988,
                  51.583807684
                ],
                [
                  3.905772332,
                  51.569240627
                ],
                [
                  3.895274285,
                  51.56659577
                ],
                [
                  3.878265821,
                  51.559393622
                ],
                [
                  3.871592644,
                  51.555568752
                ],
                [
                  3.871592644,
                  51.549383856
                ],
                [
                  3.967295769,
                  51.54311758
                ],
                [
                  4.015879754,
                  51.530829169
                ],
                [
                  4.057139519,
                  51.508368231
                ],
                [
                  4.070323113,
                  51.492743231
                ],
                [
                  4.090017123,
                  51.458238023
                ],
                [
                  4.104828321,
                  51.445705471
                ],
                [
                  4.128754102,
                  51.44135163
                ],
                [
                  4.180837436,
                  51.445868231
                ],
                [
                  4.200450066,
                  51.439520575
                ],
                [
                  4.220225457,
                  51.443548895
                ],
                [
                  4.25277754,
                  51.442531643
                ],
                [
                  4.263845248,
                  51.444403387
                ],
                [
                  4.283213738,
                  51.447699286
                ],
                [
                  4.296722852,
                  51.470526434
                ],
                [
                  4.288584832,
                  51.49213288
                ],
                [
                  4.267751498,
                  51.508286851
                ],
                [
                  4.239756707,
                  51.518500067
                ],
                [
                  4.230479363,
                  51.51955801
                ],
                [
                  4.194672071,
                  51.52358633
                ],
                [
                  4.153330925,
                  51.53506094
                ],
                [
                  4.137950066,
                  51.535874742
                ],
                [
                  4.106293165,
                  51.533514716
                ],
                [
                  4.091319207,
                  51.53506094
                ],
                [
                  4.067230665,
                  51.544012762
                ],
                [
                  3.988129102,
                  51.590277411
                ],
                [
                  4.041188998,
                  51.606024481
                ],
                [
                  4.067718946,
                  51.610663153
                ],
                [
                  4.157237175,
                  51.607896226
                ],
                [
                  4.183360222,
                  51.602932033
                ],
                [
                  4.206879102,
                  51.590521552
                ],
                [
                  4.207286004,
                  51.590277411
                ],
                [
                  4.202647332,
                  51.609116929
                ],
                [
                  4.189952019,
                  51.616685289
                ],
                [
                  4.186127149,
                  51.616807359
                ],
                [
                  4.146657748,
                  51.617865302
                ],
                [
                  4.135996941,
                  51.620428778
                ],
                [
                  4.125987175,
                  51.624701239
                ],
                [
                  4.118011915,
                  51.630682684
                ],
                [
                  4.112966342,
                  51.639390367
                ],
                [
                  4.109873894,
                  51.650864976
                ],
                [
                  4.109629754,
                  51.662298895
                ],
                [
                  4.112640821,
                  51.670803127
                ],
                [
                  4.125661655,
                  51.67963288
                ],
                [
                  4.142914259,
                  51.684149481
                ],
                [
                  4.176931186,
                  51.685858466
                ],
                [
                  4.166351759,
                  51.692694403
                ],
                [
                  4.141123894,
                  51.703924872
                ],
                [
                  4.071543816,
                  51.717189846
                ],
                [
                  4.057139519,
                  51.730292059
                ],
                [
                  4.050791863,
                  51.763495184
                ],
                [
                  4.03394616,
                  51.784247137
                ],
                [
                  4.009776238,
                  51.797919012
                ],
                [
                  3.981455925,
                  51.810003973
                ],
                [
                  3.962575717,
                  51.801214911
                ],
                [
                  3.937185092,
                  51.796332098
                ],
                [
                  3.911387566,
                  51.796372789
                ],
                [
                  3.891856316,
                  51.79295482
                ],
                [
                  3.888194207,
                  51.788885809
                ],
                [
                  3.881114129,
                  51.788072007
                ],
                [
                  3.871592644,
                  51.788275458
                ],
                [
                  3.8623153,
                  51.816066799
                ],
                [
                  3.891368035,
                  51.82827383
                ],
                [
                  3.954112175,
                  51.840155341
                ],
                [
                  3.962657097,
                  51.847357489
                ],
                [
                  3.982188347,
                  51.848293361
                ],
                [
                  4.015635613,
                  51.843573309
                ],
                [
                  4.043467644,
                  51.834214585
                ],
                [
                  4.047618035,
                  51.833685614
                ],
                [
                  4.055023634,
                  51.834214585
                ],
                [
                  4.0654403,
                  51.837103583
                ],
                [
                  4.077647332,
                  51.843573309
                ],
                [
                  4.070078972,
                  51.852728583
                ],
                [
                  4.044606967,
                  51.874497789
                ],
                [
                  4.03785241,
                  51.877915757
                ],
                [
                  4.032074415,
                  51.882025458
                ],
                [
                  4.029795769,
                  51.888251044
                ],
                [
                  4.031993035,
                  51.896063544
                ],
                [
                  4.036631707,
                  51.901556708
                ],
                [
                  4.041270379,
                  51.905503648
                ],
                [
                  4.043467644,
                  51.908677476
                ],
                [
                  4.040212436,
                  51.924058335
                ],
                [
                  4.021169467,
                  51.963324286
                ],
                [
                  4.010020379,
                  51.980129299
                ],
                [
                  4.015635613,
                  51.987697658
                ],
                [
                  4.02247155,
                  51.994370835
                ],
                [
                  4.06902103,
                  51.987941799
                ],
                [
                  4.107676629,
                  51.991888739
                ],
                [
                  4.141856316,
                  52.005601304
                ],
                [
                  4.284678582,
                  52.112941799
                ],
                [
                  4.406911655,
                  52.223456122
                ],
                [
                  4.508148634,
                  52.336371161
                ],
                [
                  4.568614129,
                  52.44525788
                ],
                [
                  4.577321811,
                  52.473578192
                ],
                [
                  4.577321811,
                  52.480943101
                ],
                [
                  4.596934441,
                  52.506577867
                ],
                [
                  4.63933353,
                  52.700669664
                ],
                [
                  4.657074415,
                  52.75018952
                ],
                [
                  4.659841342,
                  52.765285549
                ],
                [
                  4.669444207,
                  52.796576239
                ],
                [
                  4.711680535,
                  52.863104559
                ],
                [
                  4.72136478,
                  52.895941473
                ],
                [
                  4.722422722,
                  52.914496161
                ],
                [
                  4.726410352,
                  52.938299872
                ],
                [
                  4.733897332,
                  52.958889065
                ],
                [
                  4.745453321,
                  52.967596747
                ],
                [
                  4.806976759,
                  52.961818752
                ],
                [
                  4.816905144,
                  52.967596747
                ],
                [
                  4.824392123,
                  52.960150458
                ],
                [
                  4.809418165,
                  52.92959219
                ],
                [
                  4.832774285,
                  52.911322333
                ],
                [
                  4.87378991,
                  52.903957424
                ],
                [
                  4.91309655,
                  52.905585028
                ],
                [
                  4.935801629,
                  52.913397528
                ],
                [
                  4.9639543045,
                  52.9281762697
                ],
                [
                  4.978282097,
                  52.935695705
                ],
                [
                  4.99903405,
                  52.940334377
                ],
                [
                  5.038910352,
                  52.943508205
                ],
                [
                  5.078135613,
                  52.954006252
                ],
                [
                  5.279470248,
                  53.062933661
                ],
                [
                  5.294200066,
                  53.073431708
                ],
                [
                  5.312754754,
                  53.082831122
                ],
                [
                  5.358897332,
                  53.089341539
                ],
                [
                  5.379242384,
                  53.097357489
                ],
                [
                  5.399750196,
                  53.122056382
                ],
                [
                  5.427093946,
                  53.190334377
                ],
                [
                  5.447438998,
                  53.220892645
                ],
                [
                  5.482595248,
                  53.245550848
                ],
                [
                  5.504242384,
                  53.257025458
                ],
                [
                  5.541026238,
                  53.266587632
                ],
                [
                  5.557871941,
                  53.278021552
                ],
                [
                  5.573496941,
                  53.291652736
                ],
                [
                  5.591563347,
                  53.302801825
                ],
                [
                  5.611827019,
                  53.307114976
                ],
                [
                  5.659678582,
                  53.311957098
                ],
                [
                  5.694590691,
                  53.330064195
                ],
                [
                  5.854746941,
                  53.368801174
                ],
                [
                  5.890798373,
                  53.384263414
                ],
                [
                  5.913747592,
                  53.385402736
                ],
                [
                  5.980804884,
                  53.406073309
                ],
                [
                  6.077321811,
                  53.408921617
                ],
                [
                  6.186045769,
                  53.410996812
                ],
                [
                  6.273936394,
                  53.412665106
                ],
                [
                  6.284353061,
                  53.410549221
                ],
                [
                  6.301931186,
                  53.401109117
                ],
                [
                  6.31153405,
                  53.398993231
                ],
                [
                  6.320078972,
                  53.400702216
                ],
                [
                  6.345550977,
                  53.412665106
                ],
                [
                  6.494395379,
                  53.438706773
                ],
                [
                  6.730235222,
                  53.460638739
                ],
                [
                  6.829112175,
                  53.450588283
                ],
                [
                  6.849782748,
                  53.444891669
                ],
                [
                  6.866872592,
                  53.434271552
                ],
                [
                  6.900563998,
                  53.35179271
                ],
                [
                  6.905772332,
                  53.350490627
                ],
                [
                  6.930023634,
                  53.34007396
                ],
                [
                  6.931895379,
                  53.337591864
                ],
                [
                  6.936696811,
                  53.335394598
                ],
                [
                  6.941661004,
                  53.330715236
                ],
                [
                  6.948578321,
                  53.326076565
                ],
                [
                  6.980153842,
                  53.319769598
                ],
                [
                  7.020030144,
                  53.306138414
                ],
                [
                  7.03777103,
                  53.309637762
                ],
                [
                  7.046234571,
                  53.303859768
                ],
                [
                  7.058278842,
                  53.301947333
                ],
                [
                  7.070078972,
                  53.303941148
                ],
                [
                  7.078623894,
                  53.309637762
                ],
                [
                  7.085459832,
                  53.309637762
                ],
                [
                  7.085459832,
                  53.302801825
                ],
                [
                  7.077484571,
                  53.298651434
                ],
                [
                  7.073496941,
                  53.295640367
                ],
                [
                  7.073741082,
                  53.291327216
                ],
                [
                  7.078623894,
                  53.282945054
                ],
                [
                  7.08073978,
                  53.266791083
                ],
                [
                  7.111094597,
                  53.256333726
                ],
                [
                  7.183360222,
                  53.245103257
                ],
                [
                  7.194590691,
                  53.245021877
                ],
                [
                  7.204437696,
                  53.248277085
                ],
                [
                  7.215830925,
                  53.255601304
                ],
                [
                  7.224619988,
                  53.262925523
                ],
                [
                  7.233571811,
                  53.27362702
                ],
                [
                  7.23698978,
                  53.285549221
                ],
                [
                  7.2295028,
                  53.296576239
                ],
                [
                  7.254730665,
                  53.319525458
                ],
                [
                  7.26832116,
                  53.323675848
                ],
                [
                  7.291514519,
                  53.323919989
                ],
                [
                  7.313161655,
                  53.32050202
                ],
                [
                  7.347666863,
                  53.307359117
                ],
                [
                  7.366547071,
                  53.302801825
                ],
                [
                  7.34253991,
                  53.324042059
                ],
                [
                  7.302907748,
                  53.332749742
                ],
                [
                  7.075205925,
                  53.337591864
                ],
                [
                  7.038259311,
                  53.348578192
                ],
                [
                  7.023610873,
                  53.376410223
                ],
                [
                  7.023285352,
                  53.450506903
                ],
                [
                  7.027679884,
                  53.467352606
                ],
                [
                  7.047048373,
                  53.497707424
                ],
                [
                  7.051442905,
                  53.512600002
                ],
                [
                  7.059743686,
                  53.521714585
                ],
                [
                  7.079356316,
                  53.521551825
                ],
                [
                  7.119639519,
                  53.516302802
                ],
                [
                  7.125010613,
                  53.524359442
                ],
                [
                  7.134532097,
                  53.5274112
                ],
                [
                  7.141774936,
                  53.537176825
                ],
                [
                  7.139984571,
                  53.549790757
                ],
                [
                  7.131114129,
                  53.556952216
                ],
                [
                  7.101898634,
                  53.565741278
                ],
                [
                  7.0888778,
                  53.573716539
                ],
                [
                  7.086761915,
                  53.586859442
                ],
                [
                  7.100922071,
                  53.59788646
                ],
                [
                  7.133148634,
                  53.611273505
                ],
                [
                  7.169444207,
                  53.635484117
                ],
                [
                  7.188975457,
                  53.643500067
                ],
                [
                  7.226084832,
                  53.666489976
                ],
                [
                  7.305023634,
                  53.684800523
                ],
                [
                  7.458832227,
                  53.695135809
                ],
                [
                  7.469574415,
                  53.690741278
                ],
                [
                  7.480235222,
                  53.682033596
                ],
                [
                  7.503916863,
                  53.678656317
                ],
                [
                  7.6513778,
                  53.696966864
                ],
                [
                  7.951426629,
                  53.721909898
                ],
                [
                  8.031423373,
                  53.708075262
                ],
                [
                  8.031423373,
                  53.700628973
                ],
                [
                  8.024912957,
                  53.672552802
                ],
                [
                  8.052907748,
                  53.636297919
                ],
                [
                  8.094086134,
                  53.604722398
                ],
                [
                  8.12761478,
                  53.590765692
                ],
                [
                  8.12761478,
                  53.584621486
                ],
                [
                  8.119151238,
                  53.571926174
                ],
                [
                  8.134613477,
                  53.567450262
                ],
                [
                  8.156748894,
                  53.563666083
                ],
                [
                  8.167979363,
                  53.553208726
                ],
                [
                  8.164886915,
                  53.5352237
                ],
                [
                  8.155446811,
                  53.526027736
                ],
                [
                  8.133799675,
                  53.516302802
                ],
                [
                  8.115733269,
                  53.510728257
                ],
                [
                  8.076345248,
                  53.508612372
                ],
                [
                  8.058767123,
                  53.502020575
                ],
                [
                  8.07699629,
                  53.46869538
                ],
                [
                  8.086192254,
                  53.456122137
                ],
                [
                  8.099782748,
                  53.447414455
                ],
                [
                  8.112478061,
                  53.451076565
                ],
                [
                  8.12387129,
                  53.454006252
                ],
                [
                  8.140635613,
                  53.453599351
                ],
                [
                  8.152354363,
                  53.449774481
                ],
                [
                  8.171397332,
                  53.436590887
                ],
                [
                  8.17855879,
                  53.43374258
                ],
                [
                  8.186696811,
                  53.429510809
                ],
                [
                  8.194834832,
                  53.420111395
                ],
                [
                  8.205332879,
                  53.410711981
                ],
                [
                  8.219737175,
                  53.40643952
                ],
                [
                  8.236501498,
                  53.406724351
                ],
                [
                  8.24870853,
                  53.408392645
                ],
                [
                  8.259450717,
                  53.412298895
                ],
                [
                  8.271739129,
                  53.419501044
                ],
                [
                  8.292816602,
                  53.440497137
                ],
                [
                  8.31511478,
                  53.474920966
                ],
                [
                  8.320485873,
                  53.509222723
                ],
                [
                  8.291514519,
                  53.529364325
                ],
                [
                  8.252207879,
                  53.523098049
                ],
                [
                  8.231211785,
                  53.525213934
                ],
                [
                  8.23316491,
                  53.539862372
                ],
                [
                  8.241709832,
                  53.556301174
                ],
                [
                  8.24887129,
                  53.590277411
                ],
                [
                  8.257334832,
                  53.604437567
                ],
                [
                  8.270681186,
                  53.612860419
                ],
                [
                  8.287608269,
                  53.616888739
                ],
                [
                  8.329356316,
                  53.618109442
                ],
                [
                  8.348480665,
                  53.612860419
                ],
                [
                  8.363291863,
                  53.600572007
                ],
                [
                  8.375498894,
                  53.586900132
                ],
                [
                  8.387705925,
                  53.577134507
                ],
                [
                  8.428070509,
                  53.564764716
                ],
                [
                  8.513438347,
                  53.55475495
                ],
                [
                  8.552093946,
                  53.543605861
                ],
                [
                  8.552093946,
                  53.536200262
                ],
                [
                  8.528168165,
                  53.523911851
                ],
                [
                  8.506195509,
                  53.50796133
                ],
                [
                  8.490000847,
                  53.486395575
                ],
                [
                  8.483897332,
                  53.457342841
                ],
                [
                  8.485036655,
                  53.401190497
                ],
                [
                  8.49089603,
                  53.376450914
                ],
                [
                  8.504405144,
                  53.358058986
                ],
                [
                  8.507334832,
                  53.38279857
                ],
                [
                  8.496755405,
                  53.44525788
                ],
                [
                  8.497569207,
                  53.474758205
                ],
                [
                  8.512868686,
                  53.496486721
                ],
                [
                  8.535817905,
                  53.506170966
                ],
                [
                  8.556651238,
                  53.518215236
                ],
                [
                  8.565765821,
                  53.546698309
                ],
                [
                  8.560801629,
                  53.551703192
                ],
                [
                  8.535166863,
                  53.590765692
                ],
                [
                  8.527517123,
                  53.596625067
                ],
                [
                  8.517100457,
                  53.610174872
                ],
                [
                  8.508311394,
                  53.62514883
                ],
                [
                  8.501231316,
                  53.644191799
                ],
                [
                  8.48707116,
                  53.666937567
                ],
                [
                  8.483897332,
                  53.68357982
                ],
                [
                  8.486094597,
                  53.700425523
                ],
                [
                  8.492198113,
                  53.715155341
                ],
                [
                  8.529633009,
                  53.770697333
                ],
                [
                  8.540227991,
                  53.7947739289
                ],
                [
                  8.556162957,
                  53.830959377
                ],
                [
                  8.5732528,
                  53.857652085
                ],
                [
                  8.587575717,
                  53.870428778
                ],
                [
                  8.607106967,
                  53.881537177
                ],
                [
                  8.629242384,
                  53.889390367
                ],
                [
                  8.651866082,
                  53.892482815
                ],
                [
                  8.672699415,
                  53.891587632
                ],
                [
                  8.684580925,
                  53.888495184
                ],
                [
                  8.709157748,
                  53.871975002
                ],
                [
                  8.744639519,
                  53.854152736
                ],
                [
                  8.782481316,
                  53.842474677
                ],
                [
                  8.860687696,
                  53.831000067
                ],
                [
                  8.903575066,
                  53.831732489
                ],
                [
                  8.976247592,
                  53.842433986
                ],
                [
                  9.016286655,
                  53.840521552
                ],
                [
                  9.035004102,
                  53.853583075
                ],
                [
                  9.114512566,
                  53.865139065
                ],
                [
                  9.193614129,
                  53.864691473
                ],
                [
                  9.210703972,
                  53.871975002
                ],
                [
                  9.224294467,
                  53.865912177
                ],
                [
                  9.240733269,
                  53.864162502
                ],
                [
                  9.274668816,
                  53.865139065
                ],
                [
                  9.283376498,
                  53.861639716
                ],
                [
                  9.305349155,
                  53.844549872
                ],
                [
                  9.3528146399,
                  53.7947739289
                ],
                [
                  9.402679884,
                  53.74241771
                ],
                [
                  9.442881707,
                  53.714300848
                ],
                [
                  9.470957879,
                  53.700628973
                ],
                [
                  9.484711134,
                  53.690090236
                ],
                [
                  9.498383009,
                  53.659857489
                ],
                [
                  9.567067905,
                  53.599595445
                ],
                [
                  9.582367384,
                  53.591294664
                ],
                [
                  9.600922071,
                  53.586330471
                ],
                [
                  9.624766472,
                  53.584621486
                ],
                [
                  9.637217644,
                  53.581000067
                ],
                [
                  9.696625196,
                  53.556626695
                ],
                [
                  9.764008009,
                  53.547674872
                ],
                [
                  9.81902103,
                  53.540350653
                ],
                [
                  9.832041863,
                  53.543605861
                ],
                [
                  9.819590691,
                  53.556626695
                ],
                [
                  9.782074415,
                  53.569728908
                ],
                [
                  9.692393425,
                  53.575913804
                ],
                [
                  9.655772332,
                  53.584621486
                ],
                [
                  9.583669467,
                  53.612453518
                ],
                [
                  9.550791863,
                  53.634588934
                ],
                [
                  9.539073113,
                  53.666489976
                ],
                [
                  9.536143425,
                  53.693752346
                ],
                [
                  9.532237175,
                  53.71116771
                ],
                [
                  9.52222741,
                  53.716620184
                ],
                [
                  9.47527103,
                  53.732163804
                ],
                [
                  9.460215691,
                  53.735419012
                ],
                [
                  9.435801629,
                  53.748683986
                ],
                [
                  9.412445509,
                  53.778753973
                ],
                [
                  9.4046087636,
                  53.7947739289
                ],
                [
                  9.396657748,
                  53.811021226
                ],
                [
                  9.395192905,
                  53.831000067
                ],
                [
                  9.358734571,
                  53.839544989
                ],
                [
                  9.29558353,
                  53.871893622
                ],
                [
                  9.257823113,
                  53.885565497
                ],
                [
                  9.220469597,
                  53.89077383
                ],
                [
                  9.093435092,
                  53.892482815
                ],
                [
                  9.055430535,
                  53.902899481
                ],
                [
                  9.02995853,
                  53.907131252
                ],
                [
                  9.01832116,
                  53.902736721
                ],
                [
                  9.007823113,
                  53.892482815
                ],
                [
                  8.984629754,
                  53.897040106
                ],
                [
                  8.949473504,
                  53.912909247
                ],
                [
                  8.916026238,
                  53.93740469
                ],
                [
                  8.833343946,
                  54.036444403
                ],
                [
                  8.871836785,
                  54.04694245
                ],
                [
                  8.890635613,
                  54.047796942
                ],
                [
                  8.914561394,
                  54.043890692
                ],
                [
                  8.953868035,
                  54.028306382
                ],
                [
                  8.97535241,
                  54.024074611
                ],
                [
                  8.997243686,
                  54.030218817
                ],
                [
                  9.004893425,
                  54.041164455
                ],
                [
                  9.013031446,
                  54.060980536
                ],
                [
                  9.0185653,
                  54.082424221
                ],
                [
                  9.01832116,
                  54.09788646
                ],
                [
                  9.00668379,
                  54.108140367
                ],
                [
                  8.988129102,
                  54.117865302
                ],
                [
                  8.974457227,
                  54.128078518
                ],
                [
                  8.977305535,
                  54.139471747
                ],
                [
                  8.977305535,
                  54.145697333
                ],
                [
                  8.952891472,
                  54.150091864
                ],
                [
                  8.917979363,
                  54.146307684
                ],
                [
                  8.88542728,
                  54.137030341
                ],
                [
                  8.867442254,
                  54.12518952
                ],
                [
                  8.860687696,
                  54.12518952
                ],
                [
                  8.833343946,
                  54.153143622
                ],
                [
                  8.815684441,
                  54.175604559
                ],
                [
                  8.812836134,
                  54.180487372
                ],
                [
                  8.820974155,
                  54.200506903
                ],
                [
                  8.836273634,
                  54.217759507
                ],
                [
                  8.8466903,
                  54.233547268
                ],
                [
                  8.839610222,
                  54.248724677
                ],
                [
                  8.839610222,
                  54.255560614
                ],
                [
                  8.851898634,
                  54.261053778
                ],
                [
                  8.894216342,
                  54.268215236
                ],
                [
                  8.911468946,
                  54.269191799
                ],
                [
                  8.922048373,
                  54.274237372
                ],
                [
                  8.937510613,
                  54.286688544
                ],
                [
                  8.953135613,
                  54.302557684
                ],
                [
                  8.963145379,
                  54.317613023
                ],
                [
                  8.94027754,
                  54.315008856
                ],
                [
                  8.902598504,
                  54.295843817
                ],
                [
                  8.881114129,
                  54.290269273
                ],
                [
                  8.883067254,
                  54.293605861
                ],
                [
                  8.885915561,
                  54.30072663
                ],
                [
                  8.887950066,
                  54.303941148
                ],
                [
                  8.857595248,
                  54.301825262
                ],
                [
                  8.805430535,
                  54.292425848
                ],
                [
                  8.774668816,
                  54.290269273
                ],
                [
                  8.738942905,
                  54.293890692
                ],
                [
                  8.723480665,
                  54.290269273
                ],
                [
                  8.69019616,
                  54.271470445
                ],
                [
                  8.67847741,
                  54.269191799
                ],
                [
                  8.651866082,
                  54.274847723
                ],
                [
                  8.623383009,
                  54.290106512
                ],
                [
                  8.602712436,
                  54.312079169
                ],
                [
                  8.599864129,
                  54.338080145
                ],
                [
                  8.614024285,
                  54.348374742
                ],
                [
                  8.641368035,
                  54.35565827
                ],
                [
                  8.672048373,
                  54.35927969
                ],
                [
                  8.695567254,
                  54.358587958
                ],
                [
                  8.695567254,
                  54.365423895
                ],
                [
                  8.677582227,
                  54.367905992
                ],
                [
                  8.663828972,
                  54.375555731
                ],
                [
                  8.650645379,
                  54.377997137
                ],
                [
                  8.634776238,
                  54.365423895
                ],
                [
                  8.626231316,
                  54.376410223
                ],
                [
                  8.629161004,
                  54.387681382
                ],
                [
                  8.638438347,
                  54.398138739
                ],
                [
                  8.648448113,
                  54.40639883
                ],
                [
                  8.669769727,
                  54.400824286
                ],
                [
                  8.750824415,
                  54.413804429
                ],
                [
                  8.860687696,
                  54.413804429
                ],
                [
                  8.886078321,
                  54.417792059
                ],
                [
                  8.907237175,
                  54.425523179
                ],
                [
                  8.949473504,
                  54.447333075
                ],
                [
                  8.988047722,
                  54.458441473
                ],
                [
                  9.004730665,
                  54.465887762
                ],
                [
                  9.011485222,
                  54.482123114
                ],
                [
                  9.011566602,
                  54.506333726
                ],
                [
                  8.986094597,
                  54.529282945
                ],
                [
                  8.904470248,
                  54.580633856
                ],
                [
                  8.892832879,
                  54.591253973
                ],
                [
                  8.887950066,
                  54.601874091
                ],
                [
                  8.878754102,
                  54.606512762
                ],
                [
                  8.85816491,
                  54.606146552
                ],
                [
                  8.837087436,
                  54.602687893
                ],
                [
                  8.825856967,
                  54.598130601
                ],
                [
                  8.81902103,
                  54.60561758
                ],
                [
                  8.853282097,
                  54.619289455
                ],
                [
                  8.818369988,
                  54.673651434
                ],
                [
                  8.805430535,
                  54.68756745
                ],
                [
                  8.776703321,
                  54.697984117
                ],
                [
                  8.722666863,
                  54.725531317
                ],
                [
                  8.688731316,
                  54.735296942
                ],
                [
                  8.688731316,
                  54.74217357
                ],
                [
                  8.69434655,
                  54.760239976
                ],
                [
                  8.681325717,
                  54.780585028
                ],
                [
                  8.661875847,
                  54.800604559
                ],
                [
                  8.648448113,
                  54.817857164
                ],
                [
                  8.642751498,
                  54.844183661
                ],
                [
                  8.64722741,
                  54.86737702
                ],
                [
                  8.660817905,
                  54.896307684
                ],
                [
                  8.668793165,
                  54.913519598
                ],
                [
                  8.661387566,
                  54.920314846
                ],
                [
                  8.6748153,
                  54.947943427
                ],
                [
                  8.666351759,
                  54.973334052
                ],
                [
                  8.650401238,
                  54.997992255
                ],
                [
                  8.640961134,
                  55.02338288
                ],
                [
                  8.644786004,
                  55.055731512
                ],
                [
                  8.656504754,
                  55.082505601
                ],
                [
                  8.67090905,
                  55.107123114
                ],
                [
                  8.681895379,
                  55.133205471
                ],
                [
                  8.575531446,
                  55.144110419
                ],
                [
                  8.563649936,
                  55.143377997
                ],
                [
                  8.559906446,
                  55.135077216
                ],
                [
                  8.55738366,
                  55.096380927
                ],
                [
                  8.551117384,
                  55.091376044
                ],
                [
                  8.541351759,
                  55.090277411
                ],
                [
                  8.528575066,
                  55.08197663
                ],
                [
                  8.514821811,
                  55.070786851
                ],
                [
                  8.499359571,
                  55.065578518
                ],
                [
                  8.483897332,
                  55.067613023
                ],
                [
                  8.470225457,
                  55.078599351
                ],
                [
                  8.458832227,
                  55.103461005
                ],
                [
                  8.460215691,
                  55.127386786
                ],
                [
                  8.466481967,
                  55.151597398
                ],
                [
                  8.470225457,
                  55.177557684
                ],
                [
                  8.488942905,
                  55.197170315
                ],
                [
                  8.530528191,
                  55.200751044
                ],
                [
                  8.572601759,
                  55.193670966
                ],
                [
                  8.593760613,
                  55.180975653
                ],
                [
                  8.580332879,
                  55.178941148
                ],
                [
                  8.569509311,
                  55.173773505
                ],
                [
                  8.552093946,
                  55.160549221
                ],
                [
                  8.555186394,
                  55.149359442
                ],
                [
                  8.614756707,
                  55.144354559
                ],
                [
                  8.669281446,
                  55.13690827
                ],
                [
                  8.689463738,
                  55.141587632
                ],
                [
                  8.687185092,
                  55.160589911
                ],
                [
                  8.668793165,
                  55.194647528
                ],
                [
                  8.655935092,
                  55.237494208
                ],
                [
                  8.648448113,
                  55.280259507
                ],
                [
                  8.650401238,
                  55.291734117
                ],
                [
                  8.659353061,
                  55.305812893
                ],
                [
                  8.661387566,
                  55.314439195
                ],
                [
                  8.659678582,
                  55.327215887
                ],
                [
                  8.648448113,
                  55.352280992
                ],
                [
                  8.63941491,
                  55.397406317
                ],
                [
                  8.632090691,
                  55.418768622
                ],
                [
                  8.617686394,
                  55.437933661
                ],
                [
                  8.59253991,
                  55.4492862
                ],
                [
                  8.556651238,
                  55.454291083
                ],
                [
                  8.490000847,
                  55.455308335
                ],
                [
                  8.441905144,
                  55.463934637
                ],
                [
                  8.40113366,
                  55.485663153
                ],
                [
                  8.310394727,
                  55.56268952
                ],
                [
                  8.31120853,
                  55.569769598
                ],
                [
                  8.332367384,
                  55.572007554
                ],
                [
                  8.332367384,
                  55.57827383
                ],
                [
                  8.313161655,
                  55.582709052
                ],
                [
                  8.290212436,
                  55.583807684
                ],
                [
                  8.267832879,
                  55.580511786
                ],
                [
                  8.250498894,
                  55.572007554
                ],
                [
                  8.239024285,
                  55.557928778
                ],
                [
                  8.242035352,
                  55.548529364
                ],
                [
                  8.271739129,
                  55.530462958
                ],
                [
                  8.262461785,
                  55.529201565
                ],
                [
                  8.256358269,
                  55.526800848
                ],
                [
                  8.243662957,
                  55.516791083
                ],
                [
                  8.266774936,
                  55.514390367
                ],
                [
                  8.293955925,
                  55.504339911
                ],
                [
                  8.316742384,
                  55.489406643
                ],
                [
                  8.326182488,
                  55.472113348
                ],
                [
                  8.313324415,
                  55.469305731
                ],
                [
                  8.193614129,
                  55.525946356
                ],
                [
                  8.169200066,
                  55.534084377
                ],
                [
                  8.110606316,
                  55.540228583
                ],
                [
                  8.095225457,
                  55.549058335
                ],
                [
                  8.094004754,
                  55.563910223
                ],
                [
                  8.150238477,
                  55.649237372
                ],
                [
                  8.169118686,
                  55.687933661
                ],
                [
                  8.181651238,
                  55.729071356
                ],
                [
                  8.183360222,
                  55.7695987
                ],
                [
                  8.1816680902,
                  55.7765730187
                ],
                [
                  10.0225761885,
                  55.7765730187
                ],
                [
                  10.017344597,
                  55.76557038
                ],
                [
                  10.019786004,
                  55.75787995
                ],
                [
                  10.033702019,
                  55.756048895
                ],
                [
                  10.059825066,
                  55.756415106
                ],
                [
                  10.059825066,
                  55.749497789
                ],
                [
                  10.018809441,
                  55.736273505
                ],
                [
                  10.00684655,
                  55.725043036
                ],
                [
                  10.01823978,
                  55.708563544
                ],
                [
                  10.01449629,
                  55.706854559
                ],
                [
                  10.005218946,
                  55.701117255
                ],
                [
                  9.981700066,
                  55.709418036
                ],
                [
                  9.871836785,
                  55.691229559
                ],
                [
                  9.821787957,
                  55.67597077
                ],
                [
                  9.792246941,
                  55.674465236
                ],
                [
                  9.730967644,
                  55.688137111
                ],
                [
                  9.695648634,
                  55.705796617
                ],
                [
                  9.68653405,
                  55.708563544
                ],
                [
                  9.583018425,
                  55.708889065
                ],
                [
                  9.559580925,
                  55.715399481
                ],
                [
                  9.556407097,
                  55.711574611
                ],
                [
                  9.554535352,
                  55.708807684
                ],
                [
                  9.55347741,
                  55.705796617
                ],
                [
                  9.552744988,
                  55.701117255
                ],
                [
                  9.573578321,
                  55.69546133
                ],
                [
                  9.645518425,
                  55.694891669
                ],
                [
                  9.658539259,
                  55.690375067
                ],
                [
                  9.710297071,
                  55.66014232
                ],
                [
                  9.720957879,
                  55.648260809
                ],
                [
                  9.728200717,
                  55.637518622
                ],
                [
                  9.738291863,
                  55.629706122
                ],
                [
                  9.758148634,
                  55.626654364
                ],
                [
                  9.853770379,
                  55.626654364
                ],
                [
                  9.837412957,
                  55.615220445
                ],
                [
                  9.785492384,
                  55.591945705
                ],
                [
                  9.757660352,
                  55.571600653
                ],
                [
                  9.744151238,
                  55.56635163
                ],
                [
                  9.720876498,
                  55.564601955
                ],
                [
                  9.712412957,
                  55.560288804
                ],
                [
                  9.710622592,
                  55.55093008
                ],
                [
                  9.710297071,
                  55.541571356
                ],
                [
                  9.706879102,
                  55.537298895
                ],
                [
                  9.643890821,
                  55.528306382
                ],
                [
                  9.621104363,
                  55.518947658
                ],
                [
                  9.607269727,
                  55.516791083
                ],
                [
                  9.595225457,
                  55.518377997
                ],
                [
                  9.572764519,
                  55.523911851
                ],
                [
                  9.559580925,
                  55.52362702
                ],
                [
                  9.562185092,
                  55.51951732
                ],
                [
                  9.566416863,
                  55.516791083
                ],
                [
                  9.551931186,
                  55.505113023
                ],
                [
                  9.514903191,
                  55.498195705
                ],
                [
                  9.498057488,
                  55.489447333
                ],
                [
                  9.515635613,
                  55.483140367
                ],
                [
                  9.534434441,
                  55.483832098
                ],
                [
                  9.583669467,
                  55.491156317
                ],
                [
                  9.59278405,
                  55.494289455
                ],
                [
                  9.602386915,
                  55.495794989
                ],
                [
                  9.660166863,
                  55.477972723
                ],
                [
                  9.664235873,
                  55.466701565
                ],
                [
                  9.659922722,
                  55.45302969
                ],
                [
                  9.648936394,
                  55.441066799
                ],
                [
                  9.635264519,
                  55.435736395
                ],
                [
                  9.601410352,
                  55.431830145
                ],
                [
                  9.586761915,
                  55.427435614
                ],
                [
                  9.592051629,
                  55.416327216
                ],
                [
                  9.60434004,
                  55.401190497
                ],
                [
                  9.607920769,
                  55.393255927
                ],
                [
                  9.605153842,
                  55.382025458
                ],
                [
                  9.599294467,
                  55.373358466
                ],
                [
                  9.600840691,
                  55.365912177
                ],
                [
                  9.621104363,
                  55.358547268
                ],
                [
                  9.633474155,
                  55.351996161
                ],
                [
                  9.645274285,
                  55.342718817
                ],
                [
                  9.648285352,
                  55.332912502
                ],
                [
                  9.634613477,
                  55.325018622
                ],
                [
                  9.634613477,
                  55.317572333
                ],
                [
                  9.644867384,
                  55.310939846
                ],
                [
                  9.681895379,
                  55.274644273
                ],
                [
                  9.69418379,
                  55.271633205
                ],
                [
                  9.7060653,
                  55.265082098
                ],
                [
                  9.710297071,
                  55.248683986
                ],
                [
                  9.706553582,
                  55.237005927
                ],
                [
                  9.699473504,
                  55.229803778
                ],
                [
                  9.692881707,
                  55.221014716
                ],
                [
                  9.689789259,
                  55.204901434
                ],
                [
                  9.684418165,
                  55.197577216
                ],
                [
                  9.671560092,
                  55.192450262
                ],
                [
                  9.655772332,
                  55.189439195
                ],
                [
                  9.642100457,
                  55.188421942
                ],
                [
                  9.583343946,
                  55.194647528
                ],
                [
                  9.569834832,
                  55.192531643
                ],
                [
                  9.56153405,
                  55.187201239
                ],
                [
                  9.554942254,
                  55.180568752
                ],
                [
                  9.54590905,
                  55.174139716
                ],
                [
                  9.521820509,
                  55.165432033
                ],
                [
                  9.507172071,
                  55.161932684
                ],
                [
                  9.494395379,
                  55.160549221
                ],
                [
                  9.486338738,
                  55.15623607
                ],
                [
                  9.486338738,
                  55.147406317
                ],
                [
                  9.494639519,
                  55.140082098
                ],
                [
                  9.511892123,
                  55.140082098
                ],
                [
                  9.511892123,
                  55.133205471
                ],
                [
                  9.482432488,
                  55.133775132
                ],
                [
                  9.468760613,
                  55.131781317
                ],
                [
                  9.456553582,
                  55.125718492
                ],
                [
                  9.466644727,
                  55.121405341
                ],
                [
                  9.47917728,
                  55.119696356
                ],
                [
                  9.508067254,
                  55.119533596
                ],
                [
                  9.521332227,
                  55.115871486
                ],
                [
                  9.535817905,
                  55.106878973
                ],
                [
                  9.559580925,
                  55.085394598
                ],
                [
                  9.533702019,
                  55.065822658
                ],
                [
                  9.516612175,
                  55.056545315
                ],
                [
                  9.498057488,
                  55.05068594
                ],
                [
                  9.452403191,
                  55.045355536
                ],
                [
                  9.434336785,
                  55.037543036
                ],
                [
                  9.442881707,
                  55.02338288
                ],
                [
                  9.455251498,
                  55.023179429
                ],
                [
                  9.511892123,
                  55.036363023
                ],
                [
                  9.537364129,
                  55.03538646
                ],
                [
                  9.54590905,
                  55.036363023
                ],
                [
                  9.553233269,
                  55.039618231
                ],
                [
                  9.560231967,
                  55.044419664
                ],
                [
                  9.568532748,
                  55.048773505
                ],
                [
                  9.579925977,
                  55.05068594
                ],
                [
                  9.601573113,
                  55.045396226
                ],
                [
                  9.641856316,
                  55.01972077
                ],
                [
                  9.662608269,
                  55.009711005
                ],
                [
                  9.71753991,
                  55.001166083
                ],
                [
                  9.730967644,
                  54.995428778
                ],
                [
                  9.738617384,
                  54.980861721
                ],
                [
                  9.7607528,
                  54.904974677
                ],
                [
                  9.763194207,
                  54.900458075
                ],
                [
                  9.761566602,
                  54.897406317
                ],
                [
                  9.751963738,
                  54.893011786
                ],
                [
                  9.73707116,
                  54.892767645
                ],
                [
                  9.722992384,
                  54.897650458
                ],
                [
                  9.711436394,
                  54.89858633
                ],
                [
                  9.703461134,
                  54.886175848
                ],
                [
                  9.715993686,
                  54.883775132
                ],
                [
                  9.727875196,
                  54.879461981
                ],
                [
                  9.737803582,
                  54.873521226
                ],
                [
                  9.744476759,
                  54.866278387
                ],
                [
                  9.748301629,
                  54.857855536
                ],
                [
                  9.750254754,
                  54.846258856
                ],
                [
                  9.745941602,
                  54.83600495
                ],
                [
                  9.731211785,
                  54.831529039
                ],
                [
                  9.719574415,
                  54.83584219
                ],
                [
                  9.705332879,
                  54.854559637
                ],
                [
                  9.696625196,
                  54.858872789
                ],
                [
                  9.65503991,
                  54.857082424
                ],
                [
                  9.642100457,
                  54.858872789
                ],
                [
                  9.623301629,
                  54.865301825
                ],
                [
                  9.624685092,
                  54.869289455
                ],
                [
                  9.632823113,
                  54.873114325
                ],
                [
                  9.634613477,
                  54.879339911
                ],
                [
                  9.616953972,
                  54.894232489
                ],
                [
                  9.610362175,
                  54.903225002
                ],
                [
                  9.617523634,
                  54.907294012
                ],
                [
                  9.644216342,
                  54.913275458
                ],
                [
                  9.638845248,
                  54.924750067
                ],
                [
                  9.615000847,
                  54.932684637
                ],
                [
                  9.586761915,
                  54.927720445
                ],
                [
                  9.581228061,
                  54.92177969
                ],
                [
                  9.568044467,
                  54.901434637
                ],
                [
                  9.556813998,
                  54.890326239
                ],
                [
                  9.550547722,
                  54.88271719
                ],
                [
                  9.54590905,
                  54.879339911
                ],
                [
                  9.538340691,
                  54.877915757
                ],
                [
                  9.52214603,
                  54.879299221
                ],
                [
                  9.515147332,
                  54.875921942
                ],
                [
                  9.498057488,
                  54.864325262
                ],
                [
                  9.456390821,
                  54.84381745
                ],
                [
                  9.442881707,
                  54.831529039
                ],
                [
                  9.43628991,
                  54.810451565
                ],
                [
                  9.437510613,
                  54.810410874
                ],
                [
                  9.451426629,
                  54.810370184
                ],
                [
                  9.510996941,
                  54.827826239
                ],
                [
                  9.52995853,
                  54.841498114
                ],
                [
                  9.554372592,
                  54.847113348
                ],
                [
                  9.566905144,
                  54.860174872
                ],
                [
                  9.579925977,
                  54.866278387
                ],
                [
                  9.583181186,
                  54.830267645
                ],
                [
                  9.63160241,
                  54.819891669
                ],
                [
                  9.693044467,
                  54.818019924
                ],
                [
                  9.734629754,
                  54.807318427
                ],
                [
                  9.752126498,
                  54.799627997
                ],
                [
                  9.778086785,
                  54.79315827
                ],
                [
                  9.801768425,
                  54.783392645
                ],
                [
                  9.812185092,
                  54.766058661
                ],
                [
                  9.823741082,
                  54.756740627
                ],
                [
                  9.849864129,
                  54.759344794
                ],
                [
                  9.895355665,
                  54.76947663
                ],
                [
                  9.891449415,
                  54.790269273
                ],
                [
                  9.915049675,
                  54.791205145
                ],
                [
                  9.947520379,
                  54.779527085
                ],
                [
                  9.970469597,
                  54.762640692
                ],
                [
                  9.984141472,
                  54.728501695
                ],
                [
                  9.990489129,
                  54.720526434
                ],
                [
                  9.999522332,
                  54.712958075
                ],
                [
                  10.01823978,
                  54.701239325
                ],
                [
                  10.005381707,
                  54.69550202
                ],
                [
                  9.992198113,
                  54.696478583
                ],
                [
                  9.979828321,
                  54.699774481
                ],
                [
                  9.970469597,
                  54.701239325
                ],
                [
                  9.971039259,
                  54.699042059
                ],
                [
                  9.946299675,
                  54.68764883
                ],
                [
                  9.943125847,
                  54.68756745
                ],
                [
                  9.936696811,
                  54.685003973
                ],
                [
                  9.93238366,
                  54.685248114
                ],
                [
                  9.929942254,
                  54.683091539
                ],
                [
                  9.929453972,
                  54.673895575
                ],
                [
                  9.94410241,
                  54.673325914
                ],
                [
                  9.970225457,
                  54.677923895
                ],
                [
                  9.996348504,
                  54.678778387
                ],
                [
                  10.011403842,
                  54.667059637
                ],
                [
                  10.02214603,
                  54.672430731
                ],
                [
                  10.033539259,
                  54.672919012
                ],
                [
                  10.039073113,
                  54.666815497
                ],
                [
                  10.031911655,
                  54.652777411
                ],
                [
                  10.036957227,
                  54.638902085
                ],
                [
                  10.037608269,
                  54.619086005
                ],
                [
                  10.031911655,
                  54.577704169
                ],
                [
                  10.026866082,
                  54.559963283
                ],
                [
                  10.020030144,
                  54.545843817
                ],
                [
                  10.01042728,
                  54.534328518
                ],
                [
                  9.997813347,
                  54.52366771
                ],
                [
                  9.965586785,
                  54.506170966
                ],
                [
                  9.925303582,
                  54.493109442
                ],
                [
                  9.882009311,
                  54.484849351
                ],
                [
                  9.840098504,
                  54.482123114
                ],
                [
                  9.840098504,
                  54.475287177
                ],
                [
                  9.883311394,
                  54.462103583
                ],
                [
                  10.124685092,
                  54.495754299
                ],
                [
                  10.14340254,
                  54.491848049
                ],
                [
                  10.203868035,
                  54.46100495
                ],
                [
                  10.183929884,
                  54.44936758
                ],
                [
                  10.183848504,
                  54.438421942
                ],
                [
                  10.191742384,
                  54.426174221
                ],
                [
                  10.197032097,
                  54.41010163
                ],
                [
                  10.191254102,
                  54.396714585
                ],
                [
                  10.177093946,
                  54.384263414
                ],
                [
                  10.15902754,
                  54.375311591
                ],
                [
                  10.141774936,
                  54.372259833
                ],
                [
                  10.144379102,
                  54.370021877
                ],
                [
                  10.147797071,
                  54.368312893
                ],
                [
                  10.148285352,
                  54.365179755
                ],
                [
                  10.141774936,
                  54.358587958
                ],
                [
                  10.152517123,
                  54.35179271
                ],
                [
                  10.155528191,
                  54.343410549
                ],
                [
                  10.151621941,
                  54.333970445
                ],
                [
                  10.141774936,
                  54.32440827
                ],
                [
                  10.163747592,
                  54.329169012
                ],
                [
                  10.180349155,
                  54.341131903
                ],
                [
                  10.203868035,
                  54.372259833
                ],
                [
                  10.217133009,
                  54.405422268
                ],
                [
                  10.224375847,
                  54.413804429
                ],
                [
                  10.234385613,
                  54.417710679
                ],
                [
                  10.27214603,
                  54.420070705
                ],
                [
                  10.285817905,
                  54.424750067
                ],
                [
                  10.292491082,
                  54.430161851
                ],
                [
                  10.297618035,
                  54.435736395
                ],
                [
                  10.306895379,
                  54.441107489
                ],
                [
                  10.318369988,
                  54.443304755
                ],
                [
                  10.360850457,
                  54.441107489
                ],
                [
                  10.382823113,
                  54.434759833
                ],
                [
                  10.443369988,
                  54.40639883
                ],
                [
                  10.601084832,
                  54.365423895
                ],
                [
                  10.69019616,
                  54.316229559
                ],
                [
                  10.731293165,
                  54.310207424
                ],
                [
                  10.777110222,
                  54.315130927
                ],
                [
                  10.810801629,
                  54.327378648
                ],
                [
                  10.867930535,
                  54.358587958
                ],
                [
                  10.900889519,
                  54.37103913
                ],
                [
                  10.935313347,
                  54.379543361
                ],
                [
                  11.018809441,
                  54.385891018
                ],
                [
                  11.018809441,
                  54.37909577
                ],
                [
                  11.000824415,
                  54.378566799
                ],
                [
                  10.975840691,
                  54.378404039
                ],
                [
                  10.993174675,
                  54.373846747
                ],
                [
                  11.01050866,
                  54.377183335
                ],
                [
                  11.03394616,
                  54.367621161
                ],
                [
                  11.10417728,
                  54.392889716
                ],
                [
                  11.13550866,
                  54.385891018
                ],
                [
                  11.098399285,
                  54.361517645
                ],
                [
                  11.087738477,
                  54.35175202
                ],
                [
                  11.081797722,
                  54.354641018
                ],
                [
                  11.066579623,
                  54.358587958
                ],
                [
                  11.077403191,
                  54.342230536
                ],
                [
                  11.086599155,
                  54.302435614
                ],
                [
                  11.094493035,
                  54.283514716
                ],
                [
                  11.087087436,
                  54.270900783
                ],
                [
                  11.087738477,
                  54.25389232
                ],
                [
                  11.094493035,
                  54.225083726
                ],
                [
                  11.090179884,
                  54.207993882
                ],
                [
                  11.080577019,
                  54.198879299
                ],
                [
                  11.070974155,
                  54.192572333
                ],
                [
                  11.066579623,
                  54.183905341
                ],
                [
                  10.950450066,
                  54.139471747
                ],
                [
                  10.910329623,
                  54.109198309
                ],
                [
                  10.892832879,
                  54.102525132
                ],
                [
                  10.852386915,
                  54.094305731
                ],
                [
                  10.844574415,
                  54.094468492
                ],
                [
                  10.836110873,
                  54.08999258
                ],
                [
                  10.829356316,
                  54.092840887
                ],
                [
                  10.822276238,
                  54.097357489
                ],
                [
                  10.813324415,
                  54.09788646
                ],
                [
                  10.805430535,
                  54.094875393
                ],
                [
                  10.801442905,
                  54.092230536
                ],
                [
                  10.762868686,
                  54.056830145
                ],
                [
                  10.75261478,
                  54.050116278
                ],
                [
                  10.75261478,
                  54.043890692
                ],
                [
                  10.765879754,
                  54.024359442
                ],
                [
                  10.780446811,
                  54.009955145
                ],
                [
                  10.79965254,
                  54.000555731
                ],
                [
                  10.82691491,
                  53.995428778
                ],
                [
                  10.865570509,
                  53.997788804
                ],
                [
                  10.875498894,
                  53.995428778
                ],
                [
                  10.882578972,
                  53.985052802
                ],
                [
                  10.883555535,
                  53.973130601
                ],
                [
                  10.887380405,
                  53.963934637
                ],
                [
                  10.902110222,
                  53.961371161
                ],
                [
                  10.906016472,
                  53.961208401
                ],
                [
                  10.917653842,
                  53.960760809
                ],
                [
                  10.922618035,
                  53.961371161
                ],
                [
                  10.935394727,
                  53.967271226
                ],
                [
                  10.964691602,
                  53.985419012
                ],
                [
                  10.981211785,
                  53.989243882
                ],
                [
                  11.000254754,
                  53.991603908
                ],
                [
                  11.05347741,
                  54.008490302
                ],
                [
                  11.175059441,
                  54.018011786
                ],
                [
                  11.183848504,
                  54.016017971
                ],
                [
                  11.190765821,
                  54.010321356
                ],
                [
                  11.197276238,
                  53.99624258
                ],
                [
                  11.204356316,
                  53.989243882
                ],
                [
                  11.239919467,
                  53.983465887
                ],
                [
                  11.245371941,
                  53.978420315
                ],
                [
                  11.240733269,
                  53.955633856
                ],
                [
                  11.242930535,
                  53.94521719
                ],
                [
                  11.25,
                  53.9427927815
                ],
                [
                  11.25,
                  53.7947739289
                ],
                [
                  11.25,
                  48.9224992638
                ],
                [
                  4.9639543045,
                  48.9224992638
                ],
                [
                  0,
                  48.9224992638
                ],
                [
                  0,
                  49.3306084327
                ]
              ]
            ]
          ]
        },
        "type": "Feature",
        "properties": {
          "sort_rank": 10,
          "source": "naturalearthdata.com",
          "min_zoom": 0,
          "kind": "earth",
          "area": 920838431833
        }
      },
      {
        "geometry": {
          "type": "Point",
          "coordinates": [
            10,
            51
          ]
        },
        "type": "Feature",
        "properties": {
          "name:ia": "Europa",
          "label_placement": true,
          "name:pt": "Europa",
          "name:ro": "Europa",
          "name:uk": "Європа",
          "name:ms": "Eropah",
          "name:tr": "Avrupa",
          "name:kn": "ಯುರೋಪ್",
          "name:ar": "أوروبا",
          "name:cs": "Evropa",
          "name:io": "Europa",
          "min_zoom": 0,
          "name:it": "Europa",
          "name:tl": "Europa",
          "name:vi": "Châu Âu",
          "name:ru": "Европа",
          "name:pl": "Europa",
          "name:ta": "ஐரோப்பா",
          "name:mi": "Ūropi",
          "id": 25871341,
          "name:ca": "Europa",
          "name:vo": "Yurop",
          "name:li": "Europa",
          "name:nn": "Europa",
          "alt_name:vi": "Âu Châu",
          "name:fi": "Eurooppa",
          "name:da": "Europa",
          "name:de": "Europa",
          "source": "openstreetmap.org",
          "name:hi": "यूरोप",
          "name:fy": "Jeropa",
          "name:zh": "欧洲",
          "name:ga": "Eoraip",
          "name:ku": "Ewropa",
          "name:sl": "Evropa",
          "name:nl": "Europa",
          "name:lt": "Europa",
          "name:nb": "Europa",
          "name:eo": "Eŭropo",
          "name:la": "Europa",
          "name:sk": "Európa",
          "name:no": "Europa",
          "name:be": "Еўропа",
          "name:hu": "Európa",
          "name:hr": "Europa",
          "name:sr": "Европа",
          "name:el": "Ευρώπη",
          "kind": "continent",
          "name": "Europe",
          "name:is": "Evrópa",
          "name:sv": "Europa",
          "name:eu": "Europa",
          "name:es": "Europa"
        }
      }
    ]
  }
}"""


