module TestSafariGame.Main exposing (..)
import SafariGame.Main exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)


suite : Test
suite =
    describe "SafariGame"
        [ describe "updatePlayer"
            [ test "1" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, w = 0, h = 0, step = 0, counter=25, img=""} True
                        |> Expect.equal { x = 0, y = 20, w = 0, h = 0, step = 0, counter=0, img=""}
            , test "2" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, w = 0, h = 0, step = 1, counter=25, img=""} True
                        |> Expect.equal { x = 0, y = 220, w = 0, h = 0, step = 1, counter=0, img=""}
            , test "3" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, w = 0, h = 0, step = 2, counter=25, img=""} True
                        |> Expect.equal { x = 0, y = 420, w = 0, h = 0, step = 2, counter=26, img=""}
            , test "4" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, w = 0, h = 0, step = 0, counter=100, img=""} True
                        |> Expect.equal { x = 0, y = 20, w = 0, h = 0, step = 0, counter=0, img=""}
            , test "5" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, w = 0, h = 0, step = 1, counter=100, img=""} True
                        |> Expect.equal { x = 0, y = 220, w = 0, h = 0, step = 0, counter=0, img=""}
            , test "6" <|
                \_ ->
                    updatePlayer { x = 0, y = 0, w = 0, h = 0, step = 2, counter=100, img=""} True
                        |> Expect.equal { x = 0, y = 420, w = 0, h = 0, step = 0, counter=101, img=""}
            , test "7" <|
                \_ ->
                    updatePlayer { x = 0, y = 20, w = 0, h = 0, step = 0, counter=25, img=""} False
                        |> Expect.equal { x = 0, y = 20, w = 0, h = 0, step = 0, counter=26, img=""}
            , test "8" <|
                \_ ->
                    updatePlayer { x = 0, y = 220, w = 0, h = 0, step = 1, counter=25, img=""} False
                        |> Expect.equal { x = 0, y = 220, w = 0, h = 0, step = 1, counter=26, img=""}
            , test "9" <|
                \_ ->
                    updatePlayer { x = 0, y = 420, w = 0, h = 0, step = 2, counter=25, img=""} False
                        |> Expect.equal { x = 0, y = 420, w = 0, h = 0, step = 2, counter=26, img=""}
            , test "10" <|
                \_ ->
                    updatePlayer { x = 0, y = 20, w = 0, h = 0, step = 0, counter=100, img=""} False
                        |> Expect.equal { x = 0, y = 20, w = 0, h = 0, step = 0, counter=101, img=""}
            , test "11" <|
                \_ ->
                    updatePlayer { x = 0, y = 220, w = 0, h = 0, step = 1, counter=100, img=""} False
                        |> Expect.equal { x = 0, y = 220, w = 0, h = 0, step = 0, counter=101, img=""}
            , test "12" <|
                \_ ->
                    updatePlayer { x = 0, y = 420, w = 0, h = 0, step = 2, counter=100, img=""} False
                        |> Expect.equal { x = 0, y = 420, w = 0, h = 0, step = 0, counter=101, img=""}
            ]
        , describe "updateEnemy"
            [ test "1" <|
                \_ ->
                    updateEnemy { x = 0, y = 0, w = 0, h = 0, img="" }
                        |> Expect.equal { x = -5, y = 0, w = 0, h = 0, img=""}
            , test "2" <|
                \_ ->
                    updateEnemy { x = 123, y = 0, w = 0, h = 0, img="" }
                        |> Expect.equal { x = 118, y = 0, w = 0, h = 0, img=""}
            ]
        , describe "updateColliding"
            [ test "1" <|
                \_ ->
                    updateColliding { x = 0, y = 0, w = 100, h = 100, step = 0, counter=0, img=""} [{ x = 0, y = 0, w = 100, h = 100, img="lion" }]
                        |> Expect.equal "GAMEOVER"
            , test "2" <|
                \_ ->
                    updateColliding { x = 0, y = 0, w = 100, h = 100, step = 0, counter=0, img=""} [{ x = 0, y = 0, w = 100, h = 100, img="elephant" }]
                        |> Expect.equal "GAMEOVER"
            , test "3" <|
                \_ ->
                    updateColliding { x = 0, y = 0, w = 100, h = 100, step = 1, counter=0, img=""} [{ x = 0, y = 0, w = 100, h = 100, img="giraffe" }]
                        |> Expect.equal "GAMEOVER"
            , test "4" <|
                \_ ->
                    updateColliding { x = 0, y = 0, w = 100, h = 100, step = 0, counter=0, img=""} [{ x = 0, y = 0, w = 100, h = 100, img="goal" }]
                        |> Expect.equal "GOAL"
            ]
        , describe "isCollidingWithEnemy"
            [ test "1" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 0, counter=0, img=""} { x = 0, y = 0, w = 100, h = 10, img="lion" }
                        |> Expect.equal True
            , test "2" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 0, counter=0, img=""} { x = 100, y = 0, w = 100, h = 10, img="lion" }
                        |> Expect.equal False
            , test "3" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 0, counter=0, img=""} { x = 0, y = 0, w = 10, h = 100, img="lion" }
                        |> Expect.equal True
            , test "4" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 0, counter=0, img=""} { x = 0, y = 100, w = 10, h = 100, img="lion" }
                        |> Expect.equal False
            , test "5" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 0, counter=0, img=""} { x = 0, y = 0, w = 100, h = 10, img="elephant" }
                        |> Expect.equal True
            , test "6" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 0, counter=0, img=""} { x = 100, y = 0, w = 100, h = 10, img="elephant" }
                        |> Expect.equal False
            , test "7" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 0, counter=0, img=""} { x = 0, y = 0, w = 10, h = 100, img="elephant" }
                        |> Expect.equal True
            , test "8" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 0, counter=0, img=""} { x = 0, y = 100, w = 10, h = 100, img="elephant" }
                        |> Expect.equal False
            , test "9" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 0, counter=0, img=""} { x = 0, y = 0, w = 100, h = 10, img="giraffe" }
                        |> Expect.equal False
            , test "10" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 0, counter=0, img=""} { x = 50, y = 0, w = 100, h = 10, img="giraffe" }
                        |> Expect.equal False
            , test "11" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 0, counter=0, img=""} { x = 0, y = 0, w = 10, h = 100, img="giraffe" }
                        |> Expect.equal False
            , test "12" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 0, counter=0, img=""} { x = 0, y = 50, w = 10, h = 100, img="giraffe" }
                        |> Expect.equal False
            , test "13" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 1, counter=0, img=""} { x = 0, y = 0, w = 100, h = 10, img="giraffe" }
                        |> Expect.equal True
            , test "14" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 1, counter=0, img=""} { x = 100, y = 0, w = 100, h = 10, img="giraffe" }
                        |> Expect.equal False
            , test "15" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 1, counter=0, img=""} { x = 0, y = 0, w = 10, h = 100, img="giraffe" }
                        |> Expect.equal True
            , test "16" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 1, counter=0, img=""} { x = 0, y = 100, w = 10, h = 100, img="giraffe" }
                        |> Expect.equal False
            , test "17" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 2, counter=0, img=""} { x = 0, y = 0, w = 100, h = 10, img="giraffe" }
                        |> Expect.equal True
            , test "18" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 100, h = 10, step = 2, counter=0, img=""} { x = 100, y = 0, w = 100, h = 10, img="giraffe" }
                        |> Expect.equal False
            , test "19" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 2, counter=0, img=""} { x = 0, y = 0, w = 10, h = 100, img="giraffe" }
                        |> Expect.equal True
            , test "20" <|
                \_ ->
                    isCollidingWithEnemy { x = 0, y = 0, w = 10, h = 100, step = 2, counter=0, img=""} { x = 0, y = 100, w = 10, h = 100, img="giraffe" }
                        |> Expect.equal False
            ]
        ]