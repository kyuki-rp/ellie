module SpaceGame.Main exposing (..)

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
    , scopes : Scopes
    , routes : List Route
    , deadlock : String
    }


type alias Player =
    { x : Number
    , y : Number
    , sx : Number
    , sy : Number
    , img :String
    }


type alias Scopes =
    List (Int, Int)


type alias Route =
    { x : Number
    , y : Number
    , img :String
    }


type ClickAction =
    RouteAndPlayerShift Int Int
        | RouteShift Int Int
        | NoneShift



-- CONSTANT


stepSize : Number
stepSize = 50


squareSize : Number
squareSize = 48



-- MAIN


main =
    game
        view
        update
        { player = 
            { x = 0
            , y = 9
            , sx=stepSize
            , sy=stepSize
            , img="player"
            }
        , scopes=[]
        , routes =
            [ { x = 8, y = -1, img="goal" }
            , { x = 0, y = 0, img="upleft" }
            , { x = 0, y = 1, img="updown" }
            , { x = 0, y = 2, img="leftright" }
            , { x = 0, y = 3, img="updown" }
            , { x = 0, y = 4, img="upleft" }
            , { x = 0, y = 5, img="updown" }
            , { x = 0, y = 6, img="leftright" }
            , { x = 0, y = 7, img="updown" }
            , { x = 0, y = 8, img="upright" }
            , { x = 1, y = 0, img="updown" }
            , { x = 1, y = 1, img="rightdown" }
            , { x = 1, y = 2, img="upright" }
            , { x = 1, y = 3, img="leftdown" }
            , { x = 1, y = 4, img="leftright" }
            , { x = 1, y = 5, img="leftdown" }
            , { x = 1, y = 6, img="upright" }
            , { x = 1, y = 7, img="nan" }
            , { x = 1, y = 8, img="leftright" }
            , { x = 2, y = 0, img="updown" }
            , { x = 2, y = 1, img="updown" }
            , { x = 2, y = 2, img="upright" }
            , { x = 2, y = 3, img="rightdown" }
            , { x = 2, y = 4, img="leftright" }
            , { x = 2, y = 5, img="upright" }
            , { x = 2, y = 6, img="leftdown" }
            , { x = 2, y = 7, img="leftright" }
            , { x = 2, y = 8, img="updown" }
            , { x = 3, y = 0, img="leftright" }
            , { x = 3, y = 1, img="upleft" }
            , { x = 3, y = 2, img="upright" }
            , { x = 3, y = 3, img="rightdown" }
            , { x = 3, y = 4, img="leftright" }
            , { x = 3, y = 5, img="leftright" }
            , { x = 3, y = 6, img="updown" }
            , { x = 3, y = 7, img="leftdown" }
            , { x = 3, y = 8, img="updown" }
            , { x = 4, y = 0, img="leftdown" }
            , { x = 4, y = 1, img="upright" }
            , { x = 4, y = 2, img="upleft" }
            , { x = 4, y = 3, img="leftdown" }
            , { x = 4, y = 4, img="updown" }
            , { x = 4, y = 5, img="leftdown" }
            , { x = 4, y = 6, img="upright" }
            , { x = 4, y = 7, img="leftright" }
            , { x = 4, y = 8, img="updown" }
            , { x = 5, y = 0, img="leftdown" }
            , { x = 5, y = 1, img="leftright" }
            , { x = 5, y = 2, img="leftright" }
            , { x = 5, y = 3, img="rightdown" }
            , { x = 5, y = 4, img="leftdown" }
            , { x = 5, y = 5, img="updown" }
            , { x = 5, y = 6, img="leftright" }
            , { x = 5, y = 7, img="leftright" }
            , { x = 5, y = 8, img="upright" }
            , { x = 6, y = 0, img="leftdown" }
            , { x = 6, y = 1, img="leftdown" }
            , { x = 6, y = 2, img="upright" }
            , { x = 6, y = 3, img="rightdown" }
            , { x = 6, y = 4, img="upright" }
            , { x = 6, y = 5, img="updown" }
            , { x = 6, y = 6, img="upright" }
            , { x = 6, y = 7, img="updown" }
            , { x = 6, y = 8, img="leftright" }
            , { x = 7, y = 0, img="updown" }
            , { x = 7, y = 1, img="updown" }
            , { x = 7, y = 2, img="leftdown" }
            , { x = 7, y = 3, img="updown" }
            , { x = 7, y = 4, img="updown" }
            , { x = 7, y = 5, img="leftright" }
            , { x = 7, y = 6, img="updown" }
            , { x = 7, y = 7, img="leftright" }
            , { x = 7, y = 8, img="updown" }
            , { x = 8, y = 0, img="updown" }
            , { x = 8, y = 1, img="updown" }
            , { x = 8, y = 2, img="leftdown" }
            , { x = 8, y = 3, img="updown" }
            , { x = 8, y = 4, img="leftright" }
            , { x = 8, y = 5, img="updown" }
            , { x = 8, y = 6, img="leftright" }
            , { x = 8, y = 7, img="updown" }
            , { x = 8, y = 8, img="upright" }
            , { x = 0, y = 9, img="start" }
            ]
        , deadlock = ""
        }



-- VIEW


view : Computer -> Memory -> List Shape
view computer memory =
    List.map (\element -> element |> move (-9*squareSize/2) (-9*squareSize/2)) (

        List.map
            (\route ->
                image squareSize squareSize ("img/" ++ route.img ++ ".png")
                    |> move ((route.x + 1/2)*squareSize) ((route.y + 1/2)*squareSize)
            )
            memory.routes
        ++ [ image squareSize squareSize ("img/" ++ memory.player.img ++ ".png")
            |> move ((memory.player.x + memory.player.sx/(stepSize*2))*squareSize) ((memory.player.y + memory.player.sy/(stepSize*2))*squareSize + 16)
        ]
    )
    ++ [ ( scale 5 <|
                words (rgb 221 160 221) <|
                    memory.deadlock
        ) |> moveY (computer.screen.top - 150)
        ]



-- UPDATE


update : Computer -> Memory -> Memory
update computer memory =
    let
        clickAction = getClickAction computer memory.routes memory.player
        player = updatePlayer memory.player memory.scopes clickAction
        scopes = updateScopes memory.player memory.scopes memory.routes
        routes = updateRoutes memory.routes clickAction
        deadlock = updateDeadlock memory.player memory.scopes
    in
        case memory.deadlock of

            "" ->
                { memory
                    | player = player
                    , scopes = scopes
                    , routes = routes
                    , deadlock = deadlock
                }

            _ ->
                memory


getClickAction : Computer -> List(Route) -> Player -> ClickAction
getClickAction computer routes player =
    let
        clickX = toFloat (floor ((computer.mouse.x+(9*squareSize/2))/squareSize))
        clickY = toFloat (floor ((computer.mouse.y+(9*squareSize/2))/squareSize))
        nanRoutes = List.head (List.filter (\route -> route.img == "nan") routes)
        touchRoutes = List.head (List.filter (\route -> route.x == clickX && route.y == clickY) routes)
    in
        case (computer.mouse.click, nanRoutes, touchRoutes) of
            (True, Just nanRoute, Just touchRoute) ->
                let
                    shiftX = floor (nanRoute.x - touchRoute.x)
                    shiftY = floor (nanRoute.y - touchRoute.y)
                in
                    if (abs (nanRoute.x - touchRoute.x) + abs (nanRoute.y - touchRoute.y) == 1) && (player.x==clickX && player.y==clickY) then
                        RouteAndPlayerShift shiftX shiftY

                    else if (abs (nanRoute.x - touchRoute.x) + abs (nanRoute.y - touchRoute.y) == 1) then
                        RouteShift shiftX shiftY

                    else
                        NoneShift

            _ ->
                NoneShift


updatePlayer : Player -> Scopes -> ClickAction -> Player
updatePlayer player scopes clickAction =
    let
        next =
            scopes
                |> List.filter (\scope -> abs (player.sx - toFloat (Tuple.first scope)) + abs (player.sy - toFloat (Tuple.second scope)) == 1 )
                |> List.head
    in
        case (clickAction, next) of

            (RouteAndPlayerShift shiftX shiftY, Just (x, y)) ->
                { player
                    | x = player.x + toFloat shiftX
                    , y = player.y + toFloat shiftY
                    , sx = toFloat x
                    , sy = toFloat y
                }

            (_, Just (x, y)) ->
                { player
                    | sx = toFloat x
                    , sy = toFloat y
                }

            (_, Nothing) ->
                getNextPlayer player


updateScopes : Player -> Scopes -> List(Route) -> Scopes
updateScopes player scopes routes =
    let
        withoutScopes =
            scopes
                |> List.filter (\scope -> abs (player.sx - toFloat (Tuple.first scope)) + abs (player.sy - toFloat (Tuple.second scope)) /= 1 )
    in
        case List.length scopes of
            0 ->
                getNextScope routes (getNextPlayer player).x (getNextPlayer player).y

            _ ->
                withoutScopes


updateRoutes : List(Route) -> ClickAction -> List(Route)
updateRoutes routes clickAction =
    let
        routeShift = 
            case clickAction of
                RouteAndPlayerShift shiftX shiftY ->
                    RouteShift shiftX shiftY
                _->
                    clickAction

        nanRoutes = List.head (List.filter (\route -> route.img == "nan") routes)
    in
        case (nanRoutes, routeShift) of

            (Just nanRoute, RouteShift shiftX shiftY) ->
                let
                    touchRoutes = List.head (List.filter (\route -> route.x == nanRoute.x - toFloat shiftX && route.y == nanRoute.y - toFloat shiftY) routes)
                    otherRoutes = List.filter (\route -> not (route.x == nanRoute.x - toFloat shiftX && route.y == nanRoute.y - toFloat shiftY) && route.img /= "nan") routes
                in
                    case touchRoutes of
                        Just touchRoute ->
                            { nanRoute | img=touchRoute.img} :: { touchRoute | img=nanRoute.img } :: otherRoutes
                        _ ->
                            routes
                
            _ ->
                routes
                

updateDeadlock : Player -> Scopes -> String
updateDeadlock player scopes = 
    let 
        next =
            scopes
                |> List.filter (\scope -> abs (player.sx - toFloat (Tuple.first scope)) + abs (player.sy - toFloat (Tuple.second scope)) == 1 )
                |> List.head
    in
        if List.length scopes /= 0 && next == Nothing then
            "GAMEOVER"
        else if List.length scopes == 1 && next == Just (floor stepSize, floor stepSize) then
            "GOAL"
        else
            ""


getNextPlayer : Player -> Player
getNextPlayer player =
    if player.sx==0 then
        { player
            | x = player.x - 1
            , sx = 2*stepSize + 1
        }

    else if player.sx==stepSize*2 then
        { player
            | x = player.x + 1
            , sx = -1
        }

    else if player.sy==0 then
        { player
            | y = player.y - 1
            , sy = 2*stepSize + 1
        }

    else if player.sy==stepSize*2 then
        { player
            | y = player.y + 1
            , sy = -1
        }

    else
        player
    

getNextScope : List(Route) -> Number -> Number -> Scopes
getNextScope routes x y =
    let
        scopeimg =
            routes
                |> List.filter (\route -> route.x == x && route.y == y )
                |> List.map (\route -> route.img)
                |> List.head

        stepSizeInt = floor stepSize
    in
        case scopeimg of
            Just "start" ->
                List.map (\i -> (stepSizeInt, stepSizeInt - i)) (List.range 1 stepSizeInt)
            Just "goal" ->
                List.map (\i -> (stepSizeInt, stepSizeInt + i)) (List.range 0 stepSizeInt)
            Just "updown" ->
                List.map (\i -> (stepSizeInt,  i)) (List.range 0 (2*stepSizeInt))
            Just "leftright" ->
                List.map (\i -> (i, stepSizeInt)) (List.range 0 (2*stepSizeInt))
            Just "upright" ->
                List.map (\i -> (stepSizeInt, stepSizeInt + i)) (List.range 0 stepSizeInt)
                    ++ List.map (\i -> (stepSizeInt + i, stepSizeInt)) (List.range 1 stepSizeInt)
            Just "rightdown" ->
                List.map (\i -> (stepSizeInt + i, stepSizeInt)) (List.range 0 stepSizeInt)
                    ++ List.map (\i -> (stepSizeInt, stepSizeInt - i)) (List.range 1 stepSizeInt)
            Just "leftdown" ->
                List.map (\i -> (stepSizeInt - i, stepSizeInt)) (List.range 0 stepSizeInt)
                    ++ List.map (\i -> (stepSizeInt, stepSizeInt - i)) (List.range 1 stepSizeInt)
            Just "upleft" ->
                List.map (\i -> (stepSizeInt, stepSizeInt + i)) (List.range 0 stepSizeInt)
                    ++ List.map (\i -> (stepSizeInt - i, stepSizeInt)) (List.range 1 stepSizeInt)
            Just "nan" ->
                List.map (\i -> (i, i)) (List.range 0 (2*stepSizeInt)) -- <- dummy
            _ ->
                []

