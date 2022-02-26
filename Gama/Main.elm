module Main exposing (main)

import Playground exposing (..)


main =
    game view update init


type alias Memory =
    { g : Float
    , x : Float
    , y : Float
    , xmove : Float
    , ymove : Float
    , screenBorderWidth : Float
    , charactorWidth : Float
    , blockWidth : Float
    }


init : Memory
init =
    { g = 0.2
    , x = Tuple.first startPosition
    , y = Tuple.second startPosition
    , xmove = 0
    , ymove = 0
    , screenBorderWidth = 2
    , charactorWidth = 20
    , blockWidth = 20
    }


startPosition : ( Float, Float )
startPosition =
    ( 0, 200 )


view : Computer -> Memory -> List Shape
view computer memory =
    runningView computer memory


runningView : Computer -> Memory -> List Shape
runningView computer memory =
    [ rectangle darkGrey computer.screen.width memory.screenBorderWidth
        |> move 0 (-200 - memory.charactorWidth / 2)
    , rectangle darkGrey memory.screenBorderWidth computer.screen.height
        |> move (-140 - memory.charactorWidth / 2) 0
    , rectangle darkGrey computer.screen.width memory.screenBorderWidth
        |> move 0 (200 + memory.charactorWidth / 2)
    , rectangle darkGrey memory.screenBorderWidth computer.screen.height
        |> move (140 + memory.charactorWidth / 2) 0
    ]
        ++ [ square black memory.charactorWidth
                |> move memory.x memory.y
           ]


update : Computer -> Memory -> Memory
update computer memory =
    memory
        |> gravity
        |> moveCharactor
        |> checkGround


gravity : Memory -> Memory
gravity memory =
    { memory
        | ymove = memory.ymove - memory.g
    }


moveCharactor : Memory -> Memory
moveCharactor memory =
    { memory
        | x = memory.x + memory.xmove
        , y = memory.y + memory.ymove
    }


checkGround : Memory -> Memory
checkGround memory =
    if memory.y < Tuple.second ( -200, -200 ) then
        { memory
            | y = Tuple.second ( -200, -200 )
            , ymove = 0
        }

    else
        memory
