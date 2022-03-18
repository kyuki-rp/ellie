module SafariGame.Main exposing (..)

import Playground
    exposing
        ( Computer
        , Number
        , Screen
        , Shape
        , circle
        , game
        , move
        , moveY
        , rectangle
        , rgb
        , scale
        , words
        , image
        )



-- TYPE


type alias Memory =
    { player : Player
    , enemies : List Enemy
    , colliding : String
    }


type alias Player =
    { x : Number
    , y : Number
    , w : Number
    , h : Number
    , step : Int
    , counter : Int
    , img :String
    }


type alias Enemy =
    { x : Number
    , y : Number
    , w : Number
    , h : Number
    , img :String
    }



-- MAIN


main =
    game
        view
        update
        { player = 
            { x = 0, y = 20, w = 146, h = 68, step = 0, counter=1, img="player"}
        , enemies =
            [ { x = 1000, y = 74, w = 148, h = 148, img="lion" }
            , { x = 2000, y = 164, w = 328, h = 328, img="elephant" }
            , { x = 3000, y = 286, w = 390, h = 572, img="giraffe" }
            , { x = 4000, y = 200, w = 252, h = 252, img="goal" }
            ]
        , colliding = ""
        }



-- VIEW


view : Computer -> Memory -> List Shape
view computer memory =
    List.map (\element -> element |> move (computer.screen.left + 100)  (computer.screen.bottom + 50)) (
        List.map
            (\enemy ->
                image enemy.w enemy.h ("img/" ++ enemy.img ++ ".png")
                    |> move enemy.x enemy.y
            )
            memory.enemies
        ++ [ image memory.player.w memory.player.h ("img/" ++ memory.player.img ++ ".png")
                |> move memory.player.x memory.player.y
            , rectangle (rgb 20 20 20) 3 (memory.player.y - 20 - memory.player.h / 2)
                |> move -30 (memory.player.y / 2)
            , rectangle (rgb 20 20 20) 3 (memory.player.y - 20 - memory.player.h / 2)
                |> move 40 (memory.player.y / 2)
            , circle (rgb 20 20 20) 20
                |> move -30 20
            , circle (rgb 20 20 20) 20
                |> move 40 20
        ]
    )
    ++ [ rectangle (rgb 154 205 50) computer.screen.width 10
        |> moveY (computer.screen.bottom + 50)
    , ( scale 5 <|
            words (rgb 221 160 221) <|
                memory.colliding
    ) |> moveY (computer.screen.top - 150)
    ]



-- UPDATE


update : Computer -> Memory -> Memory
update computer memory =
    let
        player =
            updatePlayer memory.player computer.mouse.click

        enemies =
            List.map updateEnemy memory.enemies

        colliding =
            updateColliding memory.player memory.enemies
    in
        case memory.colliding of
            "" ->
                { memory
                    | player = player
                    , enemies = enemies
                    , colliding = colliding
                }

            _ ->
                memory



updatePlayer : Player -> Bool -> Player
updatePlayer player click =
    let           
       
        nextY=
            20 + player.h / 2 + (toFloat player.step) * 200

        nextStep = 
            case (player.step, player.counter) of
                (_, 100) ->
                    0
                    
                (0, 0) ->
                    player.step + 1

                (1, 0) ->
                    player.step + 1

                _ ->
                    player.step

        nextCounter =
            if click && player.step/=2 then
                0
            else
                player.counter + 1

    in
        { player
            | y = nextY
            , step = nextStep
            , counter = nextCounter
        }


updateEnemy : Enemy -> Enemy
updateEnemy enemy =
    { enemy | x = enemy.x - 5 }


updateColliding : Player -> List Enemy -> String
updateColliding player enemies =
    let
        collidingEnemies =
            enemies
                |> List.map (\enemy -> (isCollidingWithEnemy player enemy, enemy.img)) 
                |> List.filter (\enemy -> Tuple.first enemy==True)
                |> List.head
            
    in
        case collidingEnemies of
            Just (True, "lion") ->
                "GAMEOVER"

            Just (True, "elephant") ->
                "GAMEOVER"

            Just (True, "giraffe") ->
                "GAMEOVER"

            Just (True, "goal") ->
                "GOAL"

            _ ->
                ""


isCollidingWithEnemy : Player -> Enemy -> Bool
isCollidingWithEnemy player enemy =
    case enemy.img of
        "lion" ->
            abs ( player.x - enemy.x )
                < player.w / 2 + enemy.w / 2 * 3/4
            && abs ( player.y - enemy.y )
                < player.h / 2 + enemy.h/ 2

        "elephant" ->
            abs ( player.x - enemy.x )
                < player.w / 2 + enemy.w / 2 * 3/4
            && abs ( player.y - enemy.y )
                < player.h / 2 + enemy.h / 2

        "giraffe" ->
            case player.step of
                0 ->
                    False

                1 ->
                    abs ( player.x - enemy.x )
                        < player.w / 2 + enemy.w / 2 * 1/3
                    && abs ( player.y - enemy.y )
                        < player.h / 2 + enemy.h / 2

                2 ->
                    abs ( player.x - enemy.x )
                        < player.w / 2 + enemy.w / 2 * 1/2
                    && abs ( player.y - enemy.y )
                        < player.h / 2 + enemy.h / 2

                _ ->
                    False

        "goal" ->
            abs ( player.x - enemy.x )
                < player.w / 2 + enemy.w / 2

        _ ->
            False
