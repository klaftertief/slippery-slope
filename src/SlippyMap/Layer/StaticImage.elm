module SlippyMap.Layer.StaticImage exposing (layer, url)

{-| A layer to display static image tiles.
-}

import Regex
import SlippyMap.Layer.LowLevel as Layer exposing (Layer)
import SlippyMap.Geo.Tile as Tile exposing (Tile)
import SlippyMap.Geo.Transform as Transform exposing (Transform)
import Svg exposing (Svg)
import Svg.Attributes


-- CONFIG


{-| Configuration for the layer.

Note: Your Config should never be held in your model. It should only appear in view code.
-}
type Config
    = Config
        { toUrl : Config -> Tile -> String
        , subDomains : List String
        }


{-| Turn an url template like `https://{s}.domain.com/{z}/{x}/{y}.png` into a `Config` by replacing placeholders with actual tile data.
-}
url : String -> Config
url template =
    let
        toUrl : Config -> Tile -> String
        toUrl (Config config) { z, x, y } =
            template
                |> replace "{z}" (toString z)
                |> replace "{x}" (toString (x % (2 ^ z)))
                |> replace "{y}" (toString (y % (2 ^ z)))
                |> replace "{s}"
                    ((abs (x + y) % (max 1 <| List.length config.subDomains))
                        |> (flip List.drop) config.subDomains
                        |> List.head
                        |> Maybe.withDefault ""
                    )
    in
        config { toUrl = toUrl }


config : { toUrl : Config -> Tile -> String } -> Config
config { toUrl } =
    Config { toUrl = toUrl, subDomains = [ "a", "b", "c" ] }



-- LAYER


layer : Config -> Layer.Config -> Layer msg
layer config layerConfig =
    Layer.tileLayer identity (tile config) layerConfig


tile : Config -> Transform -> Tile -> Svg msg
tile ((Config config) as cfg) transform ({ z, x, y } as tile) =
    Svg.image
        [ Svg.Attributes.width (toString transform.tileSize)
        , Svg.Attributes.height (toString transform.tileSize)
        , Svg.Attributes.xlinkHref (config.toUrl cfg tile)
        ]
        []



-- HELPERS


replace : String -> String -> String -> String
replace search substitution string =
    string
        |> Regex.replace Regex.All
            (Regex.regex (Regex.escape search))
            (\_ -> substitution)
