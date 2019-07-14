module Html.Grid exposing
    ( row
    , Column, column, mapColumn
    , columnShrink, exactWidthColumn
    , box
    , keyedRow, keyedColumn
    )

{-|

    import Css exposing (..)
    import Html.Grid as Grid
    import Html.Styled

    view : Html.Styled.Html msg
    view =
        Grid.box
            [ width (pct 100) ]
            [ Grid.row
                []
                [ Grid.column
                    []
                    [ Html.text "Hello from upper left corner" ]
                , Grid.column
                    []
                    [ Html.text "Hello from upper right corner" ]
                ]
            , Grid.row
                []
                [ Grid.column
                    []
                    [ Html.text "Hello from lower left corner" ]
                , Grid.column
                    []
                    [ Html.text "Hello from lower right corner" ]
                ]
            ]


# Row

@docs row


# Column

@docs Column, column, mapColumn


# Column Styling

@docs columnShrink, exactWidthColumn


# Extras

@docs box


# Keyed

@docs keyedRow, keyedColumn

-}

import Css exposing (..)
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        )
import Html.Styled.Attributes as Attr
import Html.Styled.Keyed



--


{-| A Column, a horizontally positioned unit inside a row
-}
type Column msg
    = Column (Html msg)


{-| A column in a row. Give `column` some html and it positions that html horizontally inside a `row`. You can also style it, overriding its default styles.

    -- columns are styled with the css:
    --     flex-basis: 100%;
    --     flex: 1;
    --     display: flex;



-}
column : List Style -> List (Html msg) -> Column msg
column styles children =
    Html.node "column"
        [ columnStyles styles ]
        children
        |> Column


{-| `Column`s naturally fill up horizontal space. Adding `columnShrink` to a column will make it do the opposite, and shrink by default.

    Grid.row
        []
        [ Grid.column
            []
            [ searchField model.searchFieldModel ]
        , Grid.column
            [ Grid.columnShrink ]
            [ searchButton "Search" SearchClicked ]
        ]

    -- Will render something like..
    -- [ --------- <Search field> --------- ] [ Search ]
    -- |           Column                    | Column  |
    -- | ---------------------- Row -------------------|

-}
columnShrink : Style
columnShrink =
    flex (int 0)


{-| `Column`s naturally fill up horizontal space. but if instead you want it to have a specific width, use this

    Grid.row
        []
        [ Grid.column
            -- This column takes up exactly 50% of the rows width
            [ Grid.exactWidthColumn (pct 50) ]
            []
        , Grid.column
            -- This column takes whatever free horizontal space is available
            []
            []
        , Grid.column
            -- This column is exactly 100 pixels wide
            [ Grid.exactWidthColumn (px 100) ]
            []
        ]

-}
exactWidthColumn : LengthOrAuto compatible -> Style
exactWidthColumn width_ =
    [ flex none
    , width width_
    ]
        |> Css.batch


{-| The same as a regular `column`, but with keyed content ( (See Html.Styled.Keyed for more info)[<https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Html-Styled-Keyed>][https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Html-Styled-Keyed] )
-}
keyedColumn : List Style -> List ( String, Html msg ) -> Column msg
keyedColumn styles children =
    Html.Styled.Keyed.node "column"
        [ columnStyles styles ]
        children
        |> Column


columnStyles : List Style -> Attribute msg
columnStyles styles =
    Attr.css
        [ flexBasis (pct 100)
        , flex (int 1)
        , displayFlex
        , Css.batch styles
        ]


{-| Just like `Html.map`, except for `Column`
-}
mapColumn : (a -> b) -> Column a -> Column b
mapColumn f (Column html) =
    Column <| Html.map f html


columnToHtml : Column msg -> Html msg
columnToHtml (Column html) =
    html


{-| A row in a grid. Sequential rows will stack vertically. A row takes a `List (Column msg)`, NOT `List (Html msg)`. `Column msg` inside the `row` are arranged horizontally.

    -- rows are styled with the css:
    --     display: flex;
    --     flex-direction: row;



-}
row : List Style -> List (Column msg) -> Html msg
row styles columns =
    Html.node "row"
        [ rowStyles styles ]
        (List.map columnToHtml columns)


{-| The same as a regular `row`, but with keyed columns ( (See Html.Styled.Keyed for more info)[<https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Html-Styled-Keyed>][https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Html-Styled-Keyed] )
-}
keyedRow : List Style -> List ( String, Column msg ) -> Html msg
keyedRow styles columns =
    Html.Styled.Keyed.node "row"
        [ rowStyles styles ]
        (List.map (Tuple.mapSecond columnToHtml) columns)


rowStyles : List Style -> Attribute msg
rowStyles extraStyles =
    Attr.css
        [ displayFlex
        , flexDirection Css.row
        , Css.batch extraStyles
        ]


{-| I find that when I write html, many html elements are just containers for other things. Containers either dont get any attributes at all, or just some styling attributes to position them or their content. This is just a helper for those simple containers. A `box` is supposed to be simple, invisible, and not interactive. It only takes a `List Style` instead of a `List (Attribute msg)`.

    Grid.box
        [ Css.width (pct 100) ]
        [ Grid.row [] [ Grid.column [] [] ]
        , Grid.row [] [ Grid.column [] [] ]
        ]

-}
box : List Style -> List (Html msg) -> Html msg
box styles =
    Html.node "box" [ Attr.css styles ]
