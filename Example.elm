module Main exposing (main)

import Browser
import Css exposing (..)
import Html.Grid as Grid
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        , node
        , p
        )
import Html.Styled.Attributes exposing (css)


main =
    Grid.box
        [ border3 (px 1) solid (hex "#000000")
        , display block
        ]
        [ Grid.row
            []
            [ Grid.column
                []
                [ box
                    red
                    "row with two columns of even width"
                ]
            , Grid.column
                []
                [ box
                    yellowGreen
                    "row with two columns of even width"
                ]
            ]
        , Grid.row
            [ height (px 50) ]
            [ Grid.column
                []
                [ box
                    greenBlue
                    "row with 50px height and one full-width column"
                ]
            ]
        , Grid.row
            []
            [ Grid.column
                []
                [ box
                    blue
                    "A grid inside a grid ->"
                ]
            , Grid.column
                []
                [ Grid.box
                    [ Grid.exactWidthColumn (pct 100) ]
                    [ Grid.row
                        []
                        [ Grid.column
                            []
                            [ box
                                purple
                                "upper left"
                            ]
                        , Grid.column
                            []
                            [ box
                                red
                                "upper right"
                            ]
                        ]
                    , Grid.row
                        []
                        [ Grid.column
                            []
                            [ box
                                greenBlue
                                "center left"
                            ]
                        , Grid.column
                            []
                            [ box
                                blue
                                "center right"
                            ]
                        ]
                    , Grid.row
                        []
                        [ Grid.column
                            []
                            [ box
                                yellowGreen
                                "lower left"
                            ]
                        , Grid.column
                            []
                            [ box
                                purple
                                "lower right"
                            ]
                        ]
                    ]
                ]
            ]
        , Grid.row
            []
            [ Grid.column
                [ height (px 50) ]
                [ box
                    purple
                    "rows with columns of differing heights are as tall as their tallest column"
                ]
            , Grid.column
                [ height (px 25) ]
                [ box
                    red
                    "this column is explicitly 25px tall"
                ]
            , Grid.column
                []
                [ box
                    blue
                    "columns without an explicit height grow to fill the available vertical space"
                ]
            ]
        , Grid.row
            []
            [ Grid.column
                [ margin (px 10) ]
                [ box
                    yellowGreen
                    "columns with varying margins are vertically centered"
                ]
            , Grid.column
                [ margin (px 5) ]
                [ box
                    greenBlue
                    "columns with varying margins are vertically centered"
                ]
            ]
        , Grid.row
            [ height (px 75) ]
            [ Grid.column
                []
                [ box
                    red
                    "columns with an explicit width stay that width, while the others grow to fill availabile horizontal space"
                ]
            , Grid.column
                [ Grid.exactWidthColumn (px 200)
                ]
                [ box
                    blue
                    "200px width"
                ]
            , Grid.column
                []
                [ box
                    red
                    "columns with an explicit width stay that width, while the others grow to fill availabile horizontal space"
                ]
            , Grid.column
                [ Grid.exactWidthColumn (px 100)
                ]
                [ box
                    blue
                    "100px width"
                ]
            ]
        , Grid.row
            [ height (px 75) ]
            [ Grid.column
                [ Grid.exactWidthColumn (pct 66.67)
                ]
                [ box
                    yellowGreen
                    "columns can be given relative widths like 66.67%"
                ]
            , Grid.column
                [ Grid.exactWidthColumn (pct 33.33)
                ]
                [ box
                    purple
                    " and 33.33%"
                ]
            ]
        ]
        |> Html.toUnstyled


red : String
red =
    "#ff8080"


yellowGreen : String
yellowGreen =
    "#e6ff80"


greenBlue : String
greenBlue =
    "#80ffb3"


blue : String
blue =
    "#80b3ff"


purple : String
purple =
    "#e680ff"


box : String -> String -> Html msg
box color comment =
    Html.div
        [ css
            [ backgroundColor (hex color)
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
                ]
            ]
            [ Html.text comment ]
        ]
