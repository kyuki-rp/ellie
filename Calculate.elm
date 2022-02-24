module Main exposing (main)

import Browser
import Element.Input as Input
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Regex


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type alias Model =
    String


init : Model
init =
    ""


type Msg
    = NoOp
    | PushValue String
    | PushEval
    | PushClear
    | PushClearEntry


divReplace : String -> String
divReplace string =
    let
        pattern =
            "/[0-9.]*"

        maybeRegex =
            Regex.fromString pattern

        regex =
            Maybe.withDefault Regex.never maybeRegex
    in
    Regex.replace regex (\{ match } -> "*" ++ (match |> String.replace "/" "") ++ "^-1") string


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        PushValue value ->
            model ++ value

        PushEval ->
            eval model

        PushClear ->
            init

        PushClearEntry ->
            String.dropRight 1 model


sum : List Float -> Float
sum list =
    List.foldl (+) 0 list


multiple : List Float -> Float
multiple list =
    List.foldl (*) 1 list


power : List Float -> Float
power list =
    case list of
        [] ->
            1

        x :: xs ->
            x ^ power xs


toFloat : String -> Float
toFloat value =
    case String.toFloat value of
        Just x ->
            x

        Nothing ->
            0


eval : String -> String
eval model =
    if
        let
            digit =
                Maybe.withDefault Regex.never <|
                    Regex.fromString "[a-zA-Z]"
        in
        Regex.contains digit model
    then
        "NaN"

    else
        model
            |> String.replace "-" "+-"
            |> String.replace "^+" "^"
            |> divReplace
            |> String.split "+"
            |> List.map (String.split "*")
            |> List.map (List.map (String.split "^"))
            |> List.map (List.map (List.map toFloat))
            |> List.map (List.map power)
            |> List.map multiple
            |> sum
            |> String.fromFloat


view : Model -> Html Msg
view model =
    div []
        [ div [] [ div [ style "border-style" "solid", style "border-width" "thin", style "border-radius" "5px", style "width" "198px", style "height" "22px", style "text-align" "right" ] [ text model ] ]
        , div []
            [ button [ style "width" "40px", onClick (PushValue "1") ] [ text "1" ]
            , button [ style "width" "40px", onClick (PushValue "2") ] [ text "2" ]
            , button [ style "width" "40px", onClick (PushValue "3") ] [ text "3" ]
            , button [ style "width" "40px", onClick (PushValue "+") ] [ text "+" ]
            , button [ style "width" "40px", onClick PushEval ] [ text "=" ]
            ]
        , div []
            [ button [ style "width" "40px", onClick (PushValue "4") ] [ text "4" ]
            , button [ style "width" "40px", onClick (PushValue "5") ] [ text "5" ]
            , button [ style "width" "40px", onClick (PushValue "6") ] [ text "6" ]
            , button [ style "width" "40px", onClick (PushValue "-") ] [ text "-" ]
            , button [ style "width" "40px", onClick PushClear ] [ text "C" ]
            ]
        , div []
            [ button [ style "width" "40px", onClick (PushValue "7") ] [ text "7" ]
            , button [ style "width" "40px", onClick (PushValue "8") ] [ text "8" ]
            , button [ style "width" "40px", onClick (PushValue "9") ] [ text "9" ]
            , button [ style "width" "40px", onClick (PushValue "*") ] [ text "*" ]
            , button [ style "width" "40px", onClick PushClearEntry ] [ text "CE" ]
            ]
        , div []
            [ button [ style "width" "40px", onClick (PushValue ".") ] [ text "." ]
            , button [ style "width" "40px", onClick (PushValue "0") ] [ text "0" ]
            , button [ style "width" "40px", onClick (PushValue "^") ] [ text "^" ]
            , button [ style "width" "40px", onClick (PushValue "/") ] [ text "/" ]
            ]
        ]
