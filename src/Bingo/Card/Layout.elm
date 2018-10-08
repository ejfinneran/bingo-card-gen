module Bingo.Card.Layout exposing
    ( Layout
    , amountOfSquares
    , freeSquareUsed
    , freeSquareValid
    , gridSpace
    , gridStyles
    , headerSpace
    , padding
    , resize
    , squarePos
    , squareSpace
    , toggleFreeSquare
    )

import Bingo.Utils as Utils
import Html
import Html.Attributes as Html


type alias Layout =
    { size : Int
    , free : Bool
    }


resize : Int -> Layout -> Layout
resize size layout =
    { layout | size = Utils.bounded 1 10 size }


toggleFreeSquare : Layout -> Layout
toggleFreeSquare layout =
    { layout | free = not layout.free }


gridStyles : Layout -> List (Html.Attribute msg)
gridStyles layout =
    let
        size =
            String.fromInt layout.size

        template =
            "repeat(" ++ size ++ ", 1fr)"
    in
    [ Html.style "grid-template-columns" template
    , Html.style "grid-template-rows" template
    ]


amountOfSquares : Layout -> Int
amountOfSquares layout =
    let
        amount =
            layout.size * layout.size
    in
    case freeSquareUsed layout of
        True ->
            amount - 1

        False ->
            amount


freeSquareUsed : Layout -> Bool
freeSquareUsed layout =
    layout.free && freeSquareValid layout


freeSquareValid : Layout -> Bool
freeSquareValid layout =
    modBy 2 layout.size /= 0


headerSpace : Float
headerSpace =
    150


gridSpace : Float
gridSpace =
    1000


padding : Float
padding =
    10


squareSpace : Float -> Int -> Float
squareSpace rowSpace size =
    ((rowSpace - padding) / toFloat size) - padding


squarePos : Int -> Int -> Float -> ( Float, Float )
squarePos column row space =
    let
        spaceWithPadding =
            space + padding
    in
    ( padding + toFloat column * spaceWithPadding
    , padding + toFloat row * spaceWithPadding
    )