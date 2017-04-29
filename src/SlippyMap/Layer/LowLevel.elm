module SlippyMap.Layer.LowLevel
    exposing
        ( Config
        , withAttribution
        , Layer
        , getAttribution
        , render
        , tileLayer
        )

import SlippyMap.Geo.Point as Point exposing (Point)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes
import Svg.Keyed


{-| Base configuration for all layers.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config
    = Config
        { attribution : Maybe String
        }


withAttribution : String -> Config
withAttribution attribution =
    Config
        { attribution = Just attribution }


type Layer msg
    = Layer Config (Render msg)


type alias Render msg =
    Transform -> Svg msg


getAttribution : Layer msg -> Maybe String
getAttribution (Layer (Config config) render) =
    config.attribution


render : Layer msg -> Render msg
render (Layer (Config config) render) =
    render


tileLayer : (Tile -> a) -> (Transform -> a -> Svg msg) -> Config -> Layer msg
tileLayer fromTile renderTile config =
    Layer config
        (\transform ->
            let
                ( tileTransform, scale, tiles, centerPoint ) =
                    toTransformScaleCoverCenter transform
            in
                Svg.Keyed.node "g"
                    [ Svg.Attributes.transform
                        (""
                            ++ "translate("
                            ++ toString (round centerPoint.x)
                            ++ " "
                            ++ toString (round centerPoint.y)
                            ++ ")"
                            ++ " "
                            ++ "scale("
                            ++ toString scale
                            ++ ")"
                            ++ " "
                            ++ "translate("
                            ++ toString (round -centerPoint.x)
                            ++ " "
                            ++ toString (round -centerPoint.y)
                            ++ ")"
                            ++ " "
                            ++ "translate("
                            ++ toString (round ((tileTransform.width / 2 - centerPoint.x) / scale))
                            ++ " "
                            ++ toString (round ((tileTransform.height / 2 - centerPoint.y) / scale))
                            ++ ")"
                        )
                    ]
                    (List.map
                        (tile (fromTile >> renderTile tileTransform) tileTransform)
                        tiles
                    )
        )


tile : (Tile -> Svg msg) -> Transform -> Tile -> ( String, Svg msg )
tile render transform ({ z, x, y } as tile) =
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
            Transform.coordinateToPoint transform tileCoordinate
    in
        ( key
        , Svg.g
            [ Svg.Attributes.class "tile"
            , Svg.Attributes.transform
                ("translate("
                    ++ toString point.x
                    ++ " "
                    ++ toString point.y
                    ++ ")"
                )
            ]
            [ render tile ]
        )


{-| TODO: rename at least
-}
toTransformScaleCoverCenter : Transform -> ( Transform, Float, List Tile, Point )
toTransformScaleCoverCenter transform =
    let
        -- Change transform zoom to an integer as tile data is not available for float values in general.
        tileTransform =
            { transform | zoom = toFloat (round transform.zoom) }

        -- As the zoom in the transform is changed the tiles need to be scaled to match the actual zoom value.
        scale =
            Transform.zoomScale
                (transform.zoom - tileTransform.zoom)

        centerPoint =
            Transform.locationToPoint tileTransform tileTransform.center

        -- Scale the bounds points to take the zoom differences into account
        ( topLeftCoordinate, bottomRightCoordinate ) =
            ( Transform.pointToCoordinate tileTransform
                { x = centerPoint.x - tileTransform.width / 2 / scale
                , y = centerPoint.y - tileTransform.height / 2 / scale
                }
            , Transform.pointToCoordinate tileTransform
                { x = centerPoint.x + tileTransform.width / 2 / scale
                , y = centerPoint.y + tileTransform.height / 2 / scale
                }
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
        ( tileTransform, scale, tiles, centerPoint )
