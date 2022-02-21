module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Html.Attributes



-- model


type alias Model =
    { page : Page
    , dropDown1Config : DropDownConfig
    , mode : Attribute Msg
    }


type alias DropDownConfig =
    { state : DropDownState
    , id : String
    }


type DropDownState
    = Open
    | Closed


type Page
    = Top
    | About


init : () -> ( Model, Cmd Msg )
init _ =
    ( { page = Top
      , dropDown1Config =
            { state = Closed
            , id = "dropDown1"
            }
      , mode = Background.color (rgb255 255 240 245)
      }
    , Cmd.none
    )



-- update


type Msg
    = NoOp
    | SelMode (Attribute Msg)
    | SetState DropDownState
    | ToAbout
    | ToTop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SelMode item ->
            { model
                | mode = item
            }
                |> update (SetState Closed)

        SetState state ->
            let
                config =
                    model.dropDown1Config

                newConfig =
                    { config | state = state }
            in
            ( { model | dropDown1Config = newConfig }, Cmd.none )

        ToAbout ->
            ( { model | page = About }, Cmd.none )

        ToTop ->
            ( { model | page = Top }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- view


view : Model -> Browser.Document Msg
view model =
    { title = "Sample"
    , body =
        [ case model.page of
            Top ->
                mainLayout top model

            About ->
                mainLayout about model
        ]
    }


mainLayout : List (Element Msg) -> Model -> Html Msg
mainLayout page model =
    layout
        [ Font.size 20 ]
    <|
        column
            [ width fill, height fill ]
            [ header model
            , bodyLayout page model
            , footer
            ]


dropDown : Model -> Element Msg
dropDown model =
    column
        [ paddingXY 0 1
        , alignRight
        , Background.color (rgb255 255 240 245)
        ]
        [ el
            [ width fill
            , paddingXY 10 10
            , Events.onClick <| SelMode (Background.color (rgb255 255 240 245))
            ]
          <|
            text "White"
        , el
            [ width fill
            , paddingXY 10 10
            , Events.onClick <| SelMode (Background.color (rgb255 51 51 0))
            ]
          <|
            text "Drak"
        ]


header : Model -> Element Msg
header model =
    column [ width fill ]
        [ el [ width fill, height (px 70) ] <| none
        , row
            [ width fill
            , height (px 70)
            , spacing 10
            , padding 10
            , Background.color (rgb255 255 182 193)
            , style "position" "fixed"
            , style "z-index" "100"
            , alignTop
            ]
            [ el
                [ Font.color <| rgba 0 0 0 0.4
                , Font.bold
                , alignLeft
                ]
                (text "Header")
            , el [ alignRight, Events.onClick ToTop ] <| text "Top"
            , el [ Events.onClick ToAbout ] <| text "About"
            , el
                ([]
                    ++ (case model.dropDown1Config.state of
                            Closed ->
                                [ Events.onClick <| SetState Open
                                ]

                            Open ->
                                [ below <| dropDown model
                                , Events.onClick <| SetState Closed
                                ]
                       )
                )
              <|
                text "Mode"
            ]
        ]


footer : Element msg
footer =
    row
        [ width fill
        , padding 10
        , height (px 70)
        , Font.color <| rgba 0 0 0 0.4
        , Font.bold
        , Background.color (rgb255 255 182 193)
        ]
        [ el [ alignRight ] (text "Footer") ]


style : String -> String -> Attribute msg
style a b =
    htmlAttribute (Html.Attributes.style a b)


about : List (Element msg)
about =
    [ el [ centerX ] <| text "About Page"
    , paragraph []
        [ text "This paragraph is wrapped into multiple lines. You can check how this paragraph be displayed."
        ]
    ]


top : List (Element msg)
top =
    [ el [ centerX ] <| text "Top Page"
    , image
        [ Border.rounded 10
        , Border.width 1
        , width fill
        ]
        { src = "https://pages.middenii.com/static/f05aea1811889ccd474b872c9d97a730/47286/thanks.webp"
        , description = "description..."
        }
    , el [ Region.heading 1, Font.size 36 ] <| text "h1"
    , el [ Region.heading 2, Font.size 32 ] <| text "h2"
    , el [ Region.heading 3, Font.size 28 ] <| text "h3"
    , el [ Region.heading 4, Font.size 24 ] <| text "h4"
    , el [ Region.heading 5, Font.size 20 ] <| text "h5"
    , el [ Region.heading 6, Font.size 16 ] <| text "h6"
    , el [ Region.heading 1, Font.size 36 ] <| text "h1"
    , el [ Region.heading 2, Font.size 32 ] <| text "h2"
    , el [ Region.heading 3, Font.size 28 ] <| text "h3"
    , el [ Region.heading 4, Font.size 24 ] <| text "h4"
    , el [ Region.heading 5, Font.size 20 ] <| text "h5"
    , el [ Region.heading 6, Font.size 16 ] <| text "h6"
    ]


bodyLayout : List (Element Msg) -> Model -> Element Msg
bodyLayout content model =
    row [ width fill, height fill, spacing 16, model.mode ]
        [ el [ width (fillPortion 10) ] <| none
        , column [ width (fillPortion 50), height fill, spacing 16, padding 16, Background.color (rgb255 250 240 230) ]
            content
        , column [ width (fillPortion 30), height fill, spacing 16, padding 16, Background.color (rgb255 176 224 230) ]
            [ el [ centerX ] <| text "Sidebar"
            ]
        , el [ width (fillPortion 10) ] <| none
        ]



-- main


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
