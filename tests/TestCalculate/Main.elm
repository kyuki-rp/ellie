module TestCalculate.Main exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)

import Html exposing (Html, text)
import Calculate.Main exposing (divReplace, sum, multiple, power, toFloat, validate, eval)


suite : Test
suite =
    describe "Main"
        [ describe "divReplace"
            [ test "divReplace-1" <|
                \_ ->
                    Expect.equal (divReplace "1+1/2") "1+1*2^-1"
            , test "divReplace-2" <|
                \_ ->
                    Expect.equal (divReplace "1+1/2+3/4") "1+1*2^-1+3*4^-1"
            , test "divReplace-3" <|
                \_ ->
                    Expect.equal (divReplace "/123") "*123^-1"
            ]
          , describe "sum"
            [ test "sum-1" <|
                \_ ->
                    Expect.equal (sum [1]) 1
            , test "sum-2" <|
                \_ ->
                    Expect.equal (sum [1,2]) 3
            , test "sum-3" <|
                \_ ->
                    Expect.equal (sum [1,2,3]) 6
            , test "sum-4" <|
                \_ ->
                    Expect.equal (sum [1,2,3,4.0]) 10.0
            , test "sum-5" <|
                \_ ->
                    Expect.equal (sum [1,2,3,4.0,5.0]) 15.0
            ]
          , describe "multiple"
            [ test "multiple-1" <|
                \_ ->
                    Expect.equal (multiple [1]) 1
            , test "multiple-2" <|
                \_ ->
                    Expect.equal (multiple [1,2]) 2
            , test "multiple-3" <|
                \_ ->
                    Expect.equal (multiple [1,2,3]) 6
            , test "multiple-4" <|
                \_ ->
                    Expect.equal (multiple [1,2,3,4.0]) 24.0
            , test "multiple-5" <|
                \_ ->
                    Expect.equal (multiple [1,2,3,4.0,5.0]) 120.0
            ]
          , describe "power"
            [ test "power-1" <|
                \_ ->
                    Expect.equal (power [1]) 1
            , test "power-2" <|
                \_ ->
                    Expect.equal (power [1,2]) 1
            , test "power-3" <|
                \_ ->
                    Expect.equal (power [2,3]) 8
            , test "power-4" <|
                \_ ->
                    Expect.equal (power [2,3,2.0]) 512
            ]
          , describe "toFloat"
            [ test "toFloat-1" <|
                \_ ->
                    Expect.equal (Calculate.Main.toFloat "1") 1
            , test "toFloat-2" <|
                \_ ->
                    Expect.equal (Calculate.Main.toFloat "123") 123
            , test "toFloat-3" <|
                \_ ->
                    Expect.equal (Calculate.Main.toFloat "x") 0
            ]
          , describe "validate"
            [ test "validate-1" <|
                \_ ->
                    Expect.equal (validate "1+1") (Just "1+1")
            , test "validate-2" <|
                \_ ->
                    Expect.equal (validate "1+2+3") (Just "1+2+3")
            , test "validate-3" <|
                \_ ->
                    Expect.equal (validate "1+2+x") (Nothing)
            ]
          , describe "eval"
            [ test "eval-1" <|
                \_ ->
                    Expect.equal (eval "1+1") "2"
            , test "eval-2" <|
                \_ ->
                    Expect.equal (eval "1+2*3") "7"
            , test "eval-3" <|
                \_ ->
                    Expect.equal (eval "1+2*3+4/2") "9"
            , test "eval-4" <|
                \_ ->
                    Expect.equal (eval "1+2*3+4/2+1/4") "9.25"
            , test "eval-5" <|
                \_ ->
                    Expect.equal (eval "1+2*3+4/2+1/4*3") "9.75"
            , test "eval-6" <|
                \_ ->
                    Expect.equal (eval "NaN+1+2*3") "NaN"
            , test "eval-7" <|
                \_ ->
                    Expect.equal (eval "Infinity+1+2*3") "NaN"
            , test "eval-8" <|
                \_ ->
                    Expect.equal (eval "1+2*3-x") "NaN"
            ]
        ]