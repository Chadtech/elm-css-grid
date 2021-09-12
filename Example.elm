module Main exposing (main)

import Browser
import Css exposing (..)
import Html.Grid as Grid
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        , p
        )
import Html.Styled.Attributes exposing (css)


main =
    Grid.box
        []
        [ Grid.row
            []
            [ Grid.col
                []
                [ box
                    green
                    "row with two columns of even width"
                ]
            , Grid.col
                []
                [ box
                    yellow
                    "row with two columns of even width"
                ]
            ]
        , Grid.row
            [ height (px 50) ]
            [ Grid.col
                []
                [ box
                    gray
                    "row with 50px height and one full-width column"
                ]
            ]
        , Grid.row
            []
            [ Grid.col
                []
                [ box
                    blue
                    "A grid inside a grid ->"
                ]
            , Grid.col
                []
                [ Grid.box
                    [ Grid.exactWidthcol (pct 100) ]
                    [ Grid.row
                        []
                        [ Grid.col
                            []
                            [ box
                                green
                                "upper left"
                            ]
                        , Grid.col
                            []
                            [ box
                                blue
                                "upper right"
                            ]
                        ]
                    , Grid.row
                        []
                        [ Grid.col
                            []
                            [ box
                                gray
                                "center left"
                            ]
                        , Grid.col
                            []
                            [ box
                                green
                                "center right"
                            ]
                        ]
                    , Grid.row
                        []
                        [ Grid.col
                            []
                            [ box
                                yellow
                                "lower left"
                            ]
                        , Grid.col
                            []
                            [ box
                                gray
                                "lower right"
                            ]
                        ]
                    ]
                ]
            ]
        , Grid.row
            []
            [ Grid.col
                [ height (px 50) ]
                [ box
                    yellow
                    "rows with columns of differing heights are as tall as their tallest column"
                ]
            , Grid.col
                [ height (px 25) ]
                [ box
                    green
                    "this column is explicitly 25px tall"
                ]
            , Grid.col
                []
                [ box
                    blue
                    "columns without an explicit height grow to fill the available vertical space"
                ]
            ]
        , Grid.row
            []
            [ Grid.col
                [ margin (px 10) ]
                [ box
                    yellow
                    "columns with varying margins are vertically centered"
                ]
            , Grid.col
                [ margin (px 5) ]
                [ box
                    gray
                    "columns with varying margins are vertically centered"
                ]
            ]
        , Grid.row
            [ height (px 75) ]
            [ Grid.col
                []
                [ box
                    green
                    "columns with an explicit width stay that width, while the others grow to fill availabile horizontal space"
                ]
            , Grid.col
                [ Grid.exactWidthcol (px 200)
                ]
                [ box
                    blue
                    "200px width"
                ]
            , Grid.col
                []
                [ box
                    green
                    "columns with an explicit width stay that width, while the others grow to fill availabile horizontal space"
                ]
            , Grid.col
                [ Grid.exactWidthcol (px 100)
                ]
                [ box
                    blue
                    "100px width"
                ]
            ]
        , Grid.row
            [ height (px 75) ]
            [ Grid.col
                [ Grid.exactWidthcol (pct 66.67)
                ]
                [ box
                    yellow
                    "columns can be given relative widths like 66.67%"
                ]
            , Grid.col
                [ Grid.exactWidthcol (pct 33.33)
                ]
                [ box
                    gray
                    " and 33.33%"
                ]
            ]
        ]
        |> Html.toUnstyled


green : ElmColor
green =
    Green


yellow : ElmColor
yellow =
    Yellow


gray : ElmColor
gray =
    Gray


blue : ElmColor
blue =
    Blue


type ElmColor
    = Green
    | Yellow
    | Gray
    | Blue


elmColorToHex : ElmColor -> String
elmColorToHex color =
    case color of
        Green ->
            "#7fd13b"

        Yellow ->
            "#f0ad00"

        Gray ->
            "#5a6378"

        Blue ->
            "#60b5cc"


box : ElmColor -> String -> Html msg
box boxColor comment =
    let
        fontColor : Style
        fontColor =
            if boxColor == Gray then
                color <| hex "#ffffff"

            else
                color <| hex "#000000"
    in
    Html.div
        [ css
            [ backgroundColor (hex <| elmColorToHex boxColor)
            , height (pct 100)
            , width (pct 100)
            , displayFlex
            , justifyContent center
            ]
        ]
        [ p
            [ css
                [ display inline
                , margin zero
                , fontColor
                ]
            ]
            [ Html.text comment ]
        ]
