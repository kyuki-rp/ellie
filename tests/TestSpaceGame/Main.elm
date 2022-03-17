module TestSpaceGame.Main exposing (..)
import SpaceGame.Main exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite =
    describe "SpaceGame"
        [ describe "updatePlayer"
            [ test "1" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = 0, img="" } [(0, 1)] NoneShift
                        |> Expect.equal { x = 0, y = 0, sx = 0, sy = 1, img="" }
            , test "2" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = 0, img="" } [(1, 0)] NoneShift
                        |> Expect.equal { x = 0, y = 0, sx = 1, sy = 0, img="" }
            , test "3" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = stepSize, img="" } [] NoneShift
                        |> Expect.equal { x = -1, y = 0, sx = 2*stepSize+1, sy = stepSize, img="" }
            , test "4" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 2*stepSize, sy = stepSize, img="" } [] NoneShift
                        |> Expect.equal { x = 1, y = 0, sx = -1, sy = stepSize, img="" }
            , test "5" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = stepSize, sy = 0, img="" } [] NoneShift
                        |> Expect.equal { x = 0, y = -1, sx = stepSize, sy = 2*stepSize+1, img="" }
            , test "6" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = stepSize, sy = 2*stepSize, img="" } [] NoneShift
                        |> Expect.equal { x = 0, y = 1, sx = stepSize, sy = -1, img="" }
            , test "7" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = 0, img="" } [(1, 0)] (RouteAndPlayerShift 0 1)
                        |> Expect.equal { x = 0, y = 1, sx = 1, sy = 0, img="" }
            , test "8" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = 0, img="" } [(1, 0)] (RouteAndPlayerShift 0 -1)
                        |> Expect.equal { x = 0, y = -1, sx = 1, sy = 0, img="" }
            , test "9" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = 0, img="" } [(1, 0)] (RouteAndPlayerShift 1 0)
                        |> Expect.equal { x = 1, y = 0, sx = 1, sy = 0, img="" }
            , test "10" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, sx = 0, sy = 0, img="" } [(1, 0)] (RouteAndPlayerShift -1 0)
                        |> Expect.equal { x = -1, y = 0, sx = 1, sy = 0, img="" }
            ]
            , describe "updateScopes"
                [ test "1" <|
                    \_ ->
                        updateScopes { x = 0, y = 0, sx = 0, sy = 0, img="" } [(0, 1), (0, 2)] []
                            |> Expect.equal [(0, 2)]
                , test "2" <|
                    \_ ->
                        updateScopes { x = 0, y = 0, sx = 0, sy = 0, img="" } [(0, 1), (0, 2), (0,3)] []
                            |> Expect.equal [(0, 2), (0, 3)]
                , test "3" <|
                    \_ ->
                        updateScopes { x = 0, y = 0, sx = 2, sy = 2, img="" } [] [{ x = 0, y = 0, img="start" }]
                            |> Expect.equal (List.map (\i -> ((floor stepSize), (floor stepSize) - i)) (List.range 1 (floor stepSize)))
                ]
            , describe "updateRoutes"
                [ test "1" <|
                    \_ ->
                        updateRoutes [ { x = 0, y = 0, img="nan" }, { x = 0, y = 1, img="upleft" } ] (RouteAndPlayerShift 0 -1)
                            |> Expect.equal [ { x = 0, y = 0, img="upleft" }, { x = 0, y = 1, img="nan" } ]
                , test "2" <|
                    \_ ->
                        updateRoutes [ { x = 0, y = 0, img="upleft" }, { x = 0, y = 1, img="nan" } ] (RouteAndPlayerShift 0 1)
                            |> Expect.equal [ { x = 0, y = 1, img="upleft" }, { x = 0, y = 0, img="nan" }]
                , test "3" <|
                    \_ ->
                        updateRoutes [ { x = 0, y = 0, img="upleft" }, { x = 1, y = 0, img="nan" } ] (RouteAndPlayerShift 1 0)
                            |> Expect.equal [ { x = 1, y = 0, img="upleft" }, { x = 0, y = 0, img="nan" } ]
                , test "4" <|
                    \_ ->
                        updateRoutes [ { x = 0, y = 0, img="nan" }, { x = 1, y = 0, img="upleft" } ] (RouteAndPlayerShift -1 0)
                            |> Expect.equal [ { x = 0, y = 0, img="upleft" }, { x = 1, y = 0, img="nan" } ]
                ]
                , describe "updateDeadlock"
                [ test "1" <|
                    \_ ->
                        updateDeadlock { x = 0, y = 0, sx = 0, sy = 0, img="" } [(0, 1)]
                            |> Expect.equal ""
                , test "2" <|
                    \_ ->
                        updateDeadlock { x = 0, y = 0, sx = 0, sy = 0, img="" } [(2, 2)]
                            |> Expect.equal "GAMEOVER"
                , test "3" <|
                    \_ ->
                        updateDeadlock { x = 0, y = 0, sx = stepSize, sy = stepSize-1, img="" } [(floor stepSize, floor stepSize)]
                            |> Expect.equal "GOAL"
                ]
            , describe "getNextPlayer"
                [ test "1" <|
                    \_ ->
                        getNextPlayer { x = 0, y = 0, sx = 0, sy = stepSize, img="" }
                            |> Expect.equal { x = -1, y = 0, sx = 2*stepSize+1, sy = stepSize, img="" }
                , test "2" <|
                    \_ ->
                        getNextPlayer { x = 0, y = 0, sx = 2*stepSize, sy = stepSize, img="" }
                            |> Expect.equal { x = 1, y = 0, sx = -1, sy = stepSize, img="" }
                , test "3" <|
                    \_ ->
                        getNextPlayer { x = 0, y = 0, sx = stepSize, sy = 0, img="" }
                            |> Expect.equal { x = 0, y = -1, sx = stepSize, sy = 2*stepSize+1, img="" }
                , test "4" <|
                    \_ ->
                        getNextPlayer { x = 0, y = 0, sx = stepSize, sy = 2*stepSize, img="" }
                            |> Expect.equal { x = 0, y = 1, sx = stepSize, sy = -1, img="" }
                ]
            , describe "getNextScope"
                [ test "1" <|
                    \_ ->
                        getNextScope [{ x = 0, y = 0, img="start" }] 0 0
                            |> Expect.equal (List.map (\i -> ((floor stepSize), (floor stepSize) - i)) (List.range 1 (floor stepSize)))
                ]
        ]

                    