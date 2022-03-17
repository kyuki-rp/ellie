module TestHelloWorld.Main exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)

import Html exposing (Html, text)
import HelloWorld.Main exposing (main)


suite : Test
suite =
    describe "The String module"
        [ describe "Main"
            [ test "main" <|
                \_ ->
                    Expect.equal main (text "Hell World!")
            ]
        ]