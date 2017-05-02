module SlippyMap.Layer.LowLevel
    exposing
        ( Config
        , withAttribution
        , Layer
        , getAttribution
        , render
        , tileLayer
        )

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
                tileTransform =
                    Transform.tileTransform transform

                scale =
                    Transform.tileScale transform

                centerPoint =
                    Transform.centerPoint tileTransform

                tiles =
                    Transform.tileBounds transform
                        |> Tile.cover
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
