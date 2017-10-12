module SlippyMapTest.Layer exposing (..)

import Expect exposing (Expectation)
import Html
import SlippyMap.Layer as Layer exposing (Layer)
import Test exposing (..)


suite : Test
suite =
    describe "Attributions"
        [ test "no attributions for layer without attribution" <|
            \_ ->
                Expect.equal []
                    (Layer.attributions baseLayerWithoutAttribution)
        , test "one attribution for one layer with attribution" <|
            \_ ->
                Expect.equal [ attribution ]
                    (Layer.attributions baseLayerWithAttribution)
        , test "one attribution for layer group with one layer with attribution" <|
            \_ ->
                Expect.equal [ attribution ]
                    (Layer.attributions groupLayerWithOneLayerWithAttribution)
        , test "twoone attributions for layer group with two layers with attribution" <|
            \_ ->
                Expect.equal [ attribution, attribution ]
                    (Layer.attributions groupLayerWithTwoLayersWithAttribution)
        ]


baseLayerWithoutAttribution : Layer msg
baseLayerWithoutAttribution =
    Layer.base
        |> Layer.custom (always <| Html.text "")


baseLayerWithAttribution : Layer msg
baseLayerWithAttribution =
    Layer.withAttribution attribution
        baseLayerWithoutAttribution


groupLayerWithOneLayerWithAttribution : Layer msg
groupLayerWithOneLayerWithAttribution =
    Layer.group [ baseLayerWithAttribution ]


groupLayerWithTwoLayersWithAttribution : Layer msg
groupLayerWithTwoLayersWithAttribution =
    Layer.group [ baseLayerWithAttribution, baseLayerWithAttribution ]


attribution =
    "TestAttribution"
