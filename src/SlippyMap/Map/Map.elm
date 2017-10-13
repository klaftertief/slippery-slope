module SlippyMap.Map.Map
    exposing
        ( Map
        , bounds
        , center
        , config
        , crs
        , locationToPoint
        , locationToPointRelativeTo
        , locationToScreenPoint
        , make
        , origin
        , pointToLocation
        , scaleT
        , scaleZ
        , screenPointToLocation
        , size
        , state
        , tileCover
        , zoom
        )

{-|

@docs Map, make, bounds, center, crs, locationToPoint, locationToPointRelativeTo, locationToScreenPoint, origin, pointToLocation, scaleT, scaleZ, screenPointToLocation, size, tileCover, zoom, config, state

-}

import SlippyMap.Geo.CRS exposing (CRS)
import SlippyMap.Geo.Location exposing (Location)
import SlippyMap.Geo.Point exposing (Point)
import SlippyMap.Geo.Tile exposing (Tile)
import SlippyMap.Map.Config as Config exposing (Config)
import SlippyMap.Map.State as State exposing (State)
import SlippyMap.Map.Transform as Transform exposing (Transformer)


{-| -}
type Map msg
    = Map
        { config : Config msg
        , state : State
        , transformer : Transformer
        }


{-| -}
make : Config msg -> State -> Map msg
make config state =
    let
        ( crs, size, scene ) =
            ( Config.crs config
            , Config.size config
            , State.getScene state
            )

        transformer =
            Transform.transformer crs size scene
    in
    Map
        { config = config
        , state = state
        , transformer = transformer
        }


{-| -}
size : Map msg -> Point
size =
    config >> Config.size


{-| -}
crs : Map msg -> CRS
crs =
    config >> Config.crs


{-| -}
config : Map msg -> Config msg
config (Map { config }) =
    config


{-| -}
state : Map msg -> State
state (Map { state }) =
    state


{-| -}
center : Map msg -> Location
center =
    state >> State.getScene >> .center


{-| -}
zoom : Map msg -> Float
zoom =
    state >> State.getScene >> .zoom


{-| -}
origin : Map msg -> Point
origin (Map { transformer }) =
    transformer.origin


{-| -}
bounds : Map msg -> ( Point, Point )
bounds (Map { transformer }) =
    transformer.bounds


{-| -}
scaleT : Map msg -> Float -> Float
scaleT (Map { transformer }) =
    transformer.scaleT


{-| -}
scaleZ : Map msg -> Float -> Float
scaleZ (Map { transformer }) =
    transformer.scaleZ


{-| -}
locationToPoint : Map msg -> Location -> Point
locationToPoint (Map { transformer }) =
    transformer.locationToPoint


{-| -}
locationToPointRelativeTo : Map msg -> Point -> Location -> Point
locationToPointRelativeTo (Map { transformer }) =
    transformer.locationToPointRelativeTo


{-| -}
locationToScreenPoint : Map msg -> Location -> Point
locationToScreenPoint (Map { transformer }) =
    transformer.locationToScreenPoint


{-| -}
pointToLocation : Map msg -> Point -> Location
pointToLocation (Map { transformer }) =
    transformer.pointToLocation


{-| -}
screenPointToLocation : Map msg -> Point -> Location
screenPointToLocation (Map { transformer }) =
    transformer.screenPointToLocation


{-| -}
tileCover : Map msg -> List Tile
tileCover (Map { transformer }) =
    transformer.tileCover
