module SlippyMap.Layer.GeoJsonTile exposing (..)

import GeoJson exposing (GeoJson)
import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Lazy


-- CONFIG


{-| Configuration for the layer.
-}
type Config
    = Config
        { toUrl : Tile -> String
        , fromTile : Tile -> WebData (List Feature)
        }


type alias Feature =
    { properties : Maybe FeatureProperties
    , geometry : GeoJson.Geometry
    }


type alias FeatureProperties =
    { layerName : String
    , name : Maybe String
    , kind : String
    , minZoom : Float
    , sortRank : Int
    , labelPlacement : Bool
    }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
withUrl : String -> List String -> Config
withUrl template subDomains =
    let
        toUrl : Tile -> String
        toUrl { z, x, y } =
            template
                |> replace "{z}" (toString z)
                |> replace "{x}" (toString (x % (2 ^ z)))
                |> replace "{y}" (toString (y % (2 ^ z)))
                |> replace "{s}"
                    ((abs (x + y) % (max 1 <| List.length subDomains))
                        |> (flip List.drop) subDomains
                        |> List.head
                        |> Maybe.withDefault ""
                    )
    in
        Config
            { toUrl = toUrl
            , fromTile = always RemoteData.NotAsked
            }


{-| -}
withTile : (Tile -> WebData Tile) -> Config -> Config
withTile fromTile (Config config) =
    Config
        { config | fromTile = fromTile }


{-| -}
toUrl : Config -> Tile -> String
toUrl (Config { toUrl }) =
    toUrl


layer : (Tile -> ( Tile, GeoJson )) -> Transform -> Svg msg
layer tileToGeoJsonTile transform =
    TileLayer.layer tileToGeoJsonTile (Svg.Lazy.lazy (tile transform)) transform


tile : Transform -> ( Tile, GeoJson ) -> Svg msg
tile transform ( { z, x, y }, geojson ) =
    let
        ( _, scale, _, _ ) =
            LowLevel.toTransformScaleCoverCenter transform

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        coordinatePoint =
            Transform.coordinateToPoint transform tileCoordinate

        project ( lon, lat, _ ) =
            Transform.locationToPoint transform { lon = lon, lat = lat }
                |> (\{ x, y } ->
                        { x = (x - coordinatePoint.x) / scale
                        , y = (y - coordinatePoint.y) / scale
                        }
                   )
    in
        renderGeoJson project geojson
