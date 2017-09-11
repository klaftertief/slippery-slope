module Data.Simplestyle exposing (..)

import GeoJson exposing (GeoJson)
import Json.Decode as Json


geoJson : Maybe GeoJson
geoJson =
    Json.decodeString GeoJson.decoder geoJsonString
        |> Result.toMaybe


geoJsonString : String
geoJsonString =
    """{"type":"FeatureCollection","features":[{"type":"Feature","properties":{"stroke":"#5555d6","stroke-width":4,"stroke-opacity":0.7,"fill":"#55552c","fill-opacity":0.5},"geometry":{"type":"Polygon","coordinates":[[[12.3046875,54.77534585936447],[-26.3671875,16.29905101458183],[30.937499999999996,-0.3515602939922709],[52.734375,54.367758524068385],[12.3046875,54.77534585936447]]]}},{"type":"Feature","properties":{"stroke":"#de5555","stroke-width":2,"stroke-opacity":1,"fill":"#55cc55","fill-opacity":0.5},"geometry":{"type":"Polygon","coordinates":[[[-65.7421875,31.653381399664],[-27.0703125,31.653381399664],[-27.0703125,62.59334083012024],[-65.7421875,62.59334083012024],[-65.7421875,31.653381399664]]]}},{"type":"Feature","properties":{"stroke":"#005555","stroke-width":2,"stroke-opacity":1},"geometry":{"type":"LineString","coordinates":[[26.015625,69.41124235697256],[-51.328125,-1.4061088354351594],[19.335937499999996,-39.368279149160124]]}},{"type":"Feature","properties":{},"geometry":{"type":"Point","coordinates":[37.265625,60.930432202923335]}},{"type":"Feature","properties":{"marker-color":"#7e7e05","marker-size":"medium","marker-symbol":"star"},"geometry":{"type":"Point","coordinates":[15.468749999999998,32.84267363195431]}}]}"""
