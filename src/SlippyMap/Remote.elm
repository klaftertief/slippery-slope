module SlippyMap.Remote exposing (..)

import Dict exposing (Dict)
import Geo.Location exposing (Location)
import Geo.PixelPoint as PixelPoint exposing (PixelPoint)
import Geo.Transform as Transform exposing (testState)
import GeoJson exposing (GeoJson)
import Http
import Map.Tile as Tile exposing (Tile)
import RemoteData exposing (WebData, RemoteData(..))
import Source.VectorTile
import String
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


type alias Model =
    { config : MapConfig
    , tiles : Dict Tile.Comparable (WebData String)
    }


type Msg
    = ZoomTo Float
    | RemoteTileResponse Tile.Comparable (WebData String)


getRemoteTile : Tile -> Cmd Msg
getRemoteTile ({ z, x, y } as tile) =
    let
        comparable =
            Tile.toComparable tile

        imageUrl =
            ("//a.tile.openstreetmap.org/"
                ++ toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
                ++ ".png"
            )
    in
        Http.getString imageUrl
            |> RemoteData.sendRequest
            |> Cmd.map (RemoteTileResponse comparable)


init : ( Model, Cmd Msg )
init =
    let
        transformState =
            { testState
                | width = toFloat defaultMapConfig.width
                , height = toFloat defaultMapConfig.height
                , center = defaultMapConfig.center
                , zoom = floor defaultMapConfig.zoom |> toFloat
            }

        scale =
            Transform.zoomScale
                (defaultMapConfig.zoom - transformState.zoom)

        centerPoint =
            Transform.locationToPixelPoint transformState defaultMapConfig.center
                |> (\{ x, y } -> { x = toFloat x, y = toFloat y })

        topLeftCoordinate =
            Transform.pixelPointToCoordinate transformState
                ({ x = centerPoint.x - transformState.width / 2
                 , y = centerPoint.y - transformState.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bottomRightCoordinate =
            Transform.pixelPointToCoordinate transformState
                ({ x = centerPoint.x + transformState.width / 2
                 , y = centerPoint.y + transformState.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bounds =
            { topLeft = topLeftCoordinate
            , topRight =
                { topLeftCoordinate | column = bottomRightCoordinate.column }
            , bottomRight = bottomRightCoordinate
            , bottomLeft =
                { topLeftCoordinate | row = bottomRightCoordinate.row }
            }

        tilesToLoad =
            Tile.cover bounds
    in
        ( { config = defaultMapConfig
          , tiles =
                tilesToLoad
                    |> List.map (\tile -> ( Tile.toComparable tile, RemoteData.NotAsked ))
                    |> Dict.fromList
          }
        , tilesToLoad
            |> List.map getRemoteTile
            |> Cmd.batch
        )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ZoomTo zoom ->
            let
                currentConfig =
                    model.config

                nextConfig =
                    { currentConfig | zoom = zoom }
            in
                ( { model | config = nextConfig }
                , Cmd.none
                )

        RemoteTileResponse comparable response ->
            ( { model | tiles = Dict.insert comparable response model.tiles }
            , Cmd.none
            )


view : Model -> Svg Msg
view model =
    let
        tiles =
            Dict.values model.tiles
                |> Debug.log "tiles"
    in
        Svg.svg
            [ Svg.Attributes.height (toString model.config.height)
            , Svg.Attributes.width (toString model.config.width)
            , Svg.Attributes.style "background:#eee;"
            ]
            [ Svg.g [] (List.map renderRemoteTile tiles) ]


renderRemoteTile : WebData String -> Svg msg
renderRemoteTile webdata =
    Svg.text_
        [ Svg.Attributes.x "10"
        , Svg.Attributes.y "20"
        ]
        [ case webdata of
            NotAsked ->
                Svg.text "Initialising..."

            Loading ->
                Svg.text "Loading..."

            Failure err ->
                Svg.text ("Error: " ++ toString err)

            Success url ->
                --renderStaticTile tile
                Svg.text ("Loaded: " ++ url)
        ]



-- ////// --


type Attribute
    = Size Int Int
    | Center Location
    | Zoom Float


size : ( Int, Int ) -> Attribute
size ( width, height ) =
    Size width height


center : ( Float, Float ) -> Attribute
center ( lon, lat ) =
    Center { lon = lon, lat = lat }


zoom : Float -> Attribute
zoom =
    Zoom


staticMap : List Attribute -> List (Layer msg) -> Svg msg
staticMap attributes layers =
    let
        mapConfig =
            List.foldl toMapConfig defaultMapConfig attributes

        layerElements =
            List.map (layer mapConfig) layers
    in
        viewStaticMap mapConfig layerElements


viewStaticMap : MapConfig -> List (Svg msg) -> Svg msg
viewStaticMap ({ width, height } as config) elements =
    Svg.svg
        [ Svg.Attributes.height (toString height)
        , Svg.Attributes.width (toString width)
        ]
        elements


type alias MapConfig =
    { width : Int
    , height : Int
    , center : Location
    , zoom : Float
    , bearing : Float
    }


defaultMapConfig : MapConfig
defaultMapConfig =
    { width = 600
    , height = 400
    , center = { lon = 0, lat = 0 }
    , zoom = 1
    , bearing = 0
    }


type Layer msg
    = GridLayer
    | StaticTileLayer (StaticTileLayerConfig msg)
    | RemoteTileLayer (RemoteTileLayerConfig msg)
    | VectorTileLayer


type alias StaticTileLayerConfig msg =
    { render : StaticTileRenderer msg }


type alias StaticTileRenderer msg =
    Tile -> Svg msg


type alias RemoteTileLayerConfig msg =
    { load : Tile -> WebData String
    , render : WebData String -> Svg msg
    }


staticTiles : StaticTileRenderer msg -> Layer msg
staticTiles render =
    StaticTileLayer { render = render }


remoteTiles : RemoteTileLayerConfig msg -> Layer msg
remoteTiles config =
    RemoteTileLayer config


toMapConfig : Attribute -> MapConfig -> MapConfig
toMapConfig attr config =
    case attr of
        Size width height ->
            { config | width = width, height = height }

        Center center ->
            { config | center = center }

        Zoom zoom ->
            { config | zoom = zoom }


container : MapConfig -> List (Svg msg) -> Svg msg
container ({ width, height } as config) elements =
    Svg.svg
        [ Svg.Attributes.height (toString height)
        , Svg.Attributes.width (toString width)
        , Svg.Attributes.style "background:#eee;"
        ]
        --elements
        --[ staticTileLayer config
        [ vectorTileLayer config
        , gridLayer config
        ]


layer : MapConfig -> Layer msg -> Svg msg
layer config layer =
    case layer of
        GridLayer ->
            gridLayer config

        StaticTileLayer layerConfig ->
            --Svg.g []
            --    [ staticTileLayer layerConfig
            --        { config
            --            | zoom = config.zoom - 1
            --            , width = config.width // 2
            --            , height = config.height // 2
            --        }
            --    , staticTileLayer layerConfig config
            --    ]
            staticTileLayer layerConfig config

        RemoteTileLayer layerConfig ->
            remoteTileLayer layerConfig config

        VectorTileLayer ->
            vectorTileLayer config


gridLayer : MapConfig -> Svg msg
gridLayer config =
    let
        transformState =
            { testState
                | width = toFloat config.width
                , height = toFloat config.height
                , center = config.center
                , zoom = config.zoom
            }

        centerPoint =
            Transform.locationToPixelPoint transformState config.center

        nw =
            { x = toFloat centerPoint.x - transformState.width / 2
            , y = toFloat centerPoint.y - transformState.height / 2
            }
                |> (\{ x, y } -> { x = floor x, y = floor y })
                |> Transform.pixelPointToLocation transformState

        se =
            { x = toFloat centerPoint.x + transformState.width / 2
            , y = toFloat centerPoint.y + transformState.height / 2
            }
                |> (\{ x, y } -> { x = floor x, y = floor y })
                |> Transform.pixelPointToLocation transformState

        lons =
            List.range (floor nw.lon) (ceiling se.lon)
                |> List.map toFloat
                |> List.map
                    (\lon ->
                        ( Transform.locationToPixelPoint transformState
                            { lon = lon, lat = se.lat }
                        , Transform.locationToPixelPoint transformState
                            { lon = lon, lat = nw.lat }
                        )
                    )

        lats =
            List.range (floor se.lat) (ceiling nw.lat)
                |> List.map toFloat
                |> List.map
                    (\lat ->
                        ( Transform.locationToPixelPoint transformState
                            { lon = nw.lon, lat = lat }
                        , Transform.locationToPixelPoint transformState
                            { lon = se.lon, lat = lat }
                        )
                    )
    in
        Svg.g []
            [ Svg.g
                [ Svg.Attributes.transform ("translate(" ++ toString (toFloat -centerPoint.x + transformState.width / 2 |> floor) ++ " " ++ toString (toFloat -centerPoint.y + transformState.height / 2 |> floor) ++ ")") ]
                (List.map line lons ++ List.map line lats)
            , Svg.text_
                [ Svg.Attributes.x "20"
                , Svg.Attributes.y "20"
                ]
                [ Svg.text (toString { nw = nw, se = se }) ]
            ]


line : ( PixelPoint, PixelPoint ) -> Svg msg
line ( p1, p2 ) =
    Svg.line
        [ Svg.Attributes.x1 (toString p1.x)
        , Svg.Attributes.y1 (toString p1.y)
        , Svg.Attributes.x2 (toString p2.x)
        , Svg.Attributes.y2 (toString p2.y)
        , Svg.Attributes.stroke "blue"
        , Svg.Attributes.strokeWidth "1"
        , Svg.Attributes.shapeRendering "crispEdges"
        ]
        []


type alias TileRenderer msg =
    Transform.State -> Tile -> ( String, Svg msg )


tileLayerRenderer : TileRenderer msg -> MapConfig -> Svg msg
tileLayerRenderer tileRenderer config =
    let
        transformState =
            { testState
                | width = toFloat config.width
                , height = toFloat config.height
                , center = config.center
                , zoom = floor config.zoom |> toFloat
            }

        scale =
            Transform.zoomScale
                (config.zoom - transformState.zoom)

        centerPoint =
            Transform.locationToPixelPoint transformState config.center
                |> (\{ x, y } -> { x = toFloat x, y = toFloat y })

        topLeftCoordinate =
            Transform.pixelPointToCoordinate transformState
                ({ x = centerPoint.x - transformState.width / 2
                 , y = centerPoint.y - transformState.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bottomRightCoordinate =
            Transform.pixelPointToCoordinate transformState
                ({ x = centerPoint.x + transformState.width / 2
                 , y = centerPoint.y + transformState.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bounds =
            { topLeft = topLeftCoordinate
            , topRight =
                { topLeftCoordinate | column = bottomRightCoordinate.column }
            , bottomRight = bottomRightCoordinate
            , bottomLeft =
                { topLeftCoordinate | row = bottomRightCoordinate.row }
            }

        tiles =
            Tile.cover bounds
    in
        Svg.Keyed.node "g"
            [ Svg.Attributes.transform
                (""
                    ++ " translate("
                    ++ toString centerPoint.x
                    ++ " "
                    ++ toString centerPoint.y
                    ++ ")"
                    ++ " "
                    ++ "scale("
                    ++ toString scale
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString -centerPoint.x
                    ++ " "
                    ++ toString -centerPoint.y
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString ((transformState.width / 2 - centerPoint.x) / scale)
                    ++ " "
                    ++ toString ((transformState.height / 2 - centerPoint.y) / scale)
                    ++ ")"
                )
            ]
            (List.map (tileRenderer transformState) tiles)


staticTileLayer : StaticTileLayerConfig msg -> MapConfig -> Svg msg
staticTileLayer { render } =
    tileLayerRenderer (staticTile render)


remoteTileLayer : RemoteTileLayerConfig msg -> MapConfig -> Svg msg
remoteTileLayer layerConfig config =
    let
        transformState =
            { testState
                | width = toFloat config.width
                , height = toFloat config.height
                , center = config.center
                , zoom = floor config.zoom |> toFloat
            }

        scale =
            Transform.zoomScale
                (config.zoom - transformState.zoom)

        centerPoint =
            Transform.locationToPixelPoint transformState config.center
                |> (\{ x, y } -> { x = toFloat x, y = toFloat y })

        topLeftCoordinate =
            Transform.pixelPointToCoordinate transformState
                ({ x = centerPoint.x - transformState.width / 2
                 , y = centerPoint.y - transformState.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bottomRightCoordinate =
            Transform.pixelPointToCoordinate transformState
                ({ x = centerPoint.x + transformState.width / 2
                 , y = centerPoint.y + transformState.height / 2
                 }
                    |> (\{ x, y } -> { x = floor x, y = floor y })
                )

        bounds =
            { topLeft = topLeftCoordinate
            , topRight =
                { topLeftCoordinate | column = bottomRightCoordinate.column }
            , bottomRight = bottomRightCoordinate
            , bottomLeft =
                { topLeftCoordinate | row = bottomRightCoordinate.row }
            }

        tiles =
            Tile.cover bounds
    in
        Svg.Keyed.node "g"
            [ Svg.Attributes.transform
                (""
                    ++ " translate("
                    ++ toString centerPoint.x
                    ++ " "
                    ++ toString centerPoint.y
                    ++ ")"
                    ++ " "
                    ++ "scale("
                    ++ toString scale
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString -centerPoint.x
                    ++ " "
                    ++ toString -centerPoint.y
                    ++ ")"
                    ++ " "
                    ++ "translate("
                    ++ toString ((transformState.width / 2 - centerPoint.x) / scale)
                    ++ " "
                    ++ toString ((transformState.height / 2 - centerPoint.y) / scale)
                    ++ ")"
                )
            ]
            (List.map (\tile -> remoteTile layerConfig transformState ( tile, RemoteData.NotAsked )) tiles)


remoteTile : RemoteTileLayerConfig msg -> Transform.State -> ( Tile, WebData String ) -> ( String, Svg msg )
remoteTile { render } transformState ( { z, x, y } as tile, url ) =
    let
        key =
            toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        point =
            Transform.coordinateToPixelPoint transformState tileCoordinate
    in
        ( key
        , Svg.g
            [ Svg.Attributes.transform
                ("translate("
                    ++ toString point.x
                    ++ " "
                    ++ toString point.y
                    ++ ")"
                )
            ]
            [ render url
            , Svg.rect
                [ Svg.Attributes.width (transformState.tileSize |> toString)
                , Svg.Attributes.height (transformState.tileSize |> toString)
                , Svg.Attributes.fill "none"
                , Svg.Attributes.stroke "red"
                ]
                []
            , Svg.text_
                [ Svg.Attributes.x "10"
                , Svg.Attributes.y "20"
                ]
                [ Svg.text key ]
            ]
        )


renderStaticTile : Tile -> Svg msg
renderStaticTile { z, x, y } =
    Svg.image
        [ Svg.Attributes.xlinkHref
            ("//a.tile.openstreetmap.org/"
                ++ toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))
                ++ ".png"
            )
        ]
        []


staticTile : StaticTileRenderer msg -> Transform.State -> Tile -> ( String, Svg msg )
staticTile render transformState ({ z, x, y } as tile) =
    let
        key =
            toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        point =
            Transform.coordinateToPixelPoint transformState tileCoordinate
    in
        ( key
        , Svg.g
            [ Svg.Attributes.transform
                ("translate("
                    ++ toString point.x
                    ++ " "
                    ++ toString point.y
                    ++ ")"
                )
            ]
            [ render tile
            , Svg.rect
                [ Svg.Attributes.width (transformState.tileSize |> toString)
                , Svg.Attributes.height (transformState.tileSize |> toString)
                , Svg.Attributes.fill "none"
                , Svg.Attributes.stroke "red"
                ]
                []
            , Svg.text_
                [ Svg.Attributes.x "10"
                , Svg.Attributes.y "20"
                ]
                [ Svg.text key ]
            ]
        )


vectorTileLayer : MapConfig -> Svg msg
vectorTileLayer =
    tileLayerRenderer vectorTile


vectorTile : Transform.State -> Tile -> ( String, Svg msg )
vectorTile transformState ({ z, x, y } as tile) =
    let
        key =
            toString z
                ++ "/"
                ++ toString (x % (2 ^ z))
                ++ "/"
                ++ toString (y % (2 ^ z))

        tileCoordinate =
            { column = toFloat x
            , row = toFloat y
            , zoom = toFloat z
            }

        point =
            Transform.coordinateToPixelPoint transformState tileCoordinate

        maybeGeojson =
            Dict.get key Source.VectorTile.testTiles

        project ( lon, lat, _ ) =
            Transform.locationToPixelPoint transformState { lon = lon, lat = lat }
                |> (\{ x, y } -> { x = x - point.x, y = y - point.y })
    in
        ( key
        , Svg.g
            [ Svg.Attributes.transform
                ("translate("
                    ++ toString point.x
                    ++ " "
                    ++ toString point.y
                    ++ ")"
                )
            ]
            [ Svg.rect
                [ Svg.Attributes.width (transformState.tileSize |> toString)
                , Svg.Attributes.height (transformState.tileSize |> toString)
                , Svg.Attributes.fill "none"
                , Svg.Attributes.stroke "green"
                ]
                []
            , Maybe.map (renderGeoJson project) maybeGeojson
                |> Maybe.withDefault (Svg.text "")
            ]
        )


renderGeoJson : (GeoJson.Position -> PixelPoint) -> GeoJson -> Svg msg
renderGeoJson project ( geoJsonObject, _ ) =
    Svg.g []
        [ renderGeoJsonObject project geoJsonObject ]


renderGeoJsonObject : (GeoJson.Position -> PixelPoint) -> GeoJson.GeoJsonObject -> Svg msg
renderGeoJsonObject project geoJsonObject =
    case geoJsonObject of
        GeoJson.Geometry geometry ->
            renderGeoJsonGeometry project geometry

        GeoJson.Feature featureObject ->
            renderGeoJsonFeatureObject project featureObject

        GeoJson.FeatureCollection featureCollection ->
            Svg.g []
                (List.map (renderGeoJsonFeatureObject project) featureCollection)


renderGeoJsonFeatureObject : (GeoJson.Position -> PixelPoint) -> GeoJson.FeatureObject -> Svg msg
renderGeoJsonFeatureObject project featureObject =
    Maybe.map (renderGeoJsonGeometry project) featureObject.geometry
        |> Maybe.withDefault (Svg.text "")


renderGeoJsonGeometry : (GeoJson.Position -> PixelPoint) -> GeoJson.Geometry -> Svg msg
renderGeoJsonGeometry project geometry =
    case geometry of
        GeoJson.Point position ->
            renderGeoJsonPoint project position

        GeoJson.MultiPoint positionList ->
            Svg.g []
                (List.map (renderGeoJsonPoint project) positionList)

        GeoJson.LineString positionList ->
            renderGeoJsonLineString project positionList

        GeoJson.MultiLineString positionListList ->
            Svg.g []
                (List.map (renderGeoJsonLineString project) positionListList)

        GeoJson.Polygon positionListList ->
            renderGeoJsonPolygon project positionListList

        GeoJson.MultiPolygon positionListListList ->
            Svg.g []
                (List.map (renderGeoJsonPolygon project) positionListListList)

        GeoJson.GeometryCollection geometryList ->
            Svg.g []
                (List.map (renderGeoJsonGeometry project) geometryList)


renderGeoJsonPoint : (GeoJson.Position -> PixelPoint) -> GeoJson.Position -> Svg msg
renderGeoJsonPoint project position =
    let
        { x, y } =
            project position
    in
        Svg.circle
            [ Svg.Attributes.cx (toString x)
            , Svg.Attributes.cy (toString y)
            , Svg.Attributes.r "2"
            ]
            []


renderGeoJsonLineString : (GeoJson.Position -> PixelPoint) -> List GeoJson.Position -> Svg msg
renderGeoJsonLineString project positionList =
    Svg.polyline
        [ positionList
            |> List.map project
            |> List.map (\{ x, y } -> toString x ++ "," ++ toString y)
            |> String.join " "
            |> Svg.Attributes.points
        , Svg.Attributes.fill "none"
        , Svg.Attributes.stroke "black"
        , Svg.Attributes.strokeWidth "1"
        ]
        []


renderGeoJsonPolygon : (GeoJson.Position -> PixelPoint) -> List (List GeoJson.Position) -> Svg msg
renderGeoJsonPolygon project positionListList =
    Svg.g []
        (List.map
            (\positionList ->
                Svg.polygon
                    [ positionList
                        |> List.map project
                        |> List.map (\{ x, y } -> toString x ++ "," ++ toString y)
                        |> String.join " "
                        |> Svg.Attributes.points
                    , Svg.Attributes.fill "#999"
                    , Svg.Attributes.stroke "black"
                    , Svg.Attributes.strokeWidth "1"
                    ]
                    []
            )
            positionListList
        )


zoomToAround : MapConfig -> Float -> PixelPoint -> MapConfig
zoomToAround config newZoom aroundOffset =
    let
        _ =
            Debug.log "offset" aroundOffset

        transformState =
            { testState
                | width = toFloat config.width
                , height = toFloat config.height
                , center = config.center
                , zoom = config.zoom
            }

        transformStateZoomed =
            { transformState
                | zoom = newZoom
            }

        centerPoint =
            Transform.locationToPixelPoint transformState config.center

        aroundPoint =
            { x = toFloat aroundOffset.x + toFloat centerPoint.x - transformState.width / 2
            , y = toFloat aroundOffset.y + toFloat centerPoint.y - transformState.height / 2
            }
                |> (\{ x, y } -> { x = floor x, y = floor y })

        aroundLocation =
            Transform.pixelPointToLocation transformState aroundPoint

        aroundPointZoomed =
            Transform.locationToPixelPoint transformStateZoomed aroundLocation

        aroundPointDiff =
            { x = aroundPointZoomed.x - aroundPoint.x
            , y = aroundPointZoomed.y - aroundPoint.y
            }

        newCenter =
            { x = centerPoint.x + aroundPointDiff.x
            , y = centerPoint.y + aroundPointDiff.y
            }
                |> Transform.pixelPointToLocation transformStateZoomed
    in
        { config
            | zoom = newZoom
            , center = newCenter
        }
