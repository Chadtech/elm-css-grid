module Html.Grid exposing
    ( row
    , Col, col, mapCol
    , colShrink, exactWidthCol, colWithAttrs
    , box
    , keyedRow, keyedCol
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

@docs Col, mapCol, colWithAttrs


# Column Styling

@docs colShrink, exactWidthCol


# Extras

@docs box


# Keyed

@docs keyedRow, keyedCol

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
type alias Col msg =
    { styles : List Css.Style 
    , attrs : List (Attribute msg)
    , body : ColBody msg 
    }


type ColBody msg 
    = ColBody  (List (Html msg))
    | KeyedCol (List (String, Html msg))


{-| A column in a row. Give `col` some html and it positions that html horizontally inside a `row`. You can also style it, overriding its default styles.

    -- columns are styled with the css:
    --     flex-basis: 100%;
    --     flex: 1;
    --     display: flex;



-}
col : List Style -> List (Html msg) -> Col msg
col styles children =
    { styles = styles 
    , attrs = [] 
    , body = ColBody children
    } 



{-| `Col`s naturally fill up horizontal space. Adding `colShrink` to a column will make it do the opposite, and shrink by default.

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
colShrink : Style
colShrink =
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
exactWidthCol : LengthOrAuto compatible -> Style
exactWidthCol width_ =
    [ flex none
    , width width_
    ]
        |> Css.batch


{-| The same as a regular `col`, but with keyed content ( (See Html.Styled.Keyed for more info)[<https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Html-Styled-Keyed>] )
-}
keyedCol : List Style -> List ( String, Html msg ) -> Col msg
keyedCol styles children =
    { styles = styles 
    , attrs = [] 
    , body = KeyedCol children
    } 



columnStyles : List Style -> Attribute msg
columnStyles styles =
    Attr.css
        [ flexBasis (pct 100)
        , flex (int 1)
        , displayFlex
        , Css.batch styles
        ]

{-| Add some `Html.Attribute msg`s to a `Col msg`. Mainly useful for adding event handlers like click events. -}
colWithAttrs : List (Attribute msg) -> Col msg -> Col msg 
colWithAttrs attrs c =
    { styles = c.styles 
    , attrs = attrs ++ c.attrs
    , body = c.body
    }

{-| Just like `Html.map`, except for `Col`
-}
mapCol : (a -> b) -> Col a -> Col b
mapCol f c =
    { styles = c.styles
    , attrs = List.map (Attr.map f) c.attrs
    , body =
        case c.body of 
            ColBody html ->
                ColBody <| List.map (Html.map f) html

            KeyedCol html ->
                KeyedCol <| List.map (Tuple.mapSecond (Html.map f)) html
    }



colToHtml : Col msg -> Html msg
colToHtml c =
    case c.body of 
        ColBody html ->
            Html.node "column"
                (columnStyles c.styles :: c.attrs)
                html 

        KeyedCol html ->
            Html.Styled.Keyed.node "column"
                (columnStyles c.styles :: c.attrs)
                html 

{-| A row in a grid. Sequential rows will stack vertically. A row takes a `List (Col msg)`, NOT `List (Html msg)`. `Col msg` inside the `row` are arranged horizontally.

    -- rows are styled with the css:
    --     display: flex;
    --     flex-direction: row;



-}
row : List Style -> List (Col msg) -> Html msg
row styles columns =
    Html.node "row"
        [ rowStyles styles ]
        (List.map colToHtml columns)


{-| The same as a regular `row`, but with keyed columns ( (See Html.Styled.Keyed for more info)[<https://package.elm-lang.org/packages/rtfeldman/elm-css/latest/Html-Styled-Keyed>] )
-}
keyedRow : List Style -> List ( String, Col msg ) -> Html msg
keyedRow styles columns =
    Html.Styled.Keyed.node "row"
        [ rowStyles styles ]
        (List.map (Tuple.mapSecond colToHtml) columns)


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
        [ Grid.row [] [ Grid.col [] [] ]
        , Grid.row [] [ Grid.col [] [] ]
        ]

-}
box : List Style -> List (Html msg) -> Html msg
box styles =
    Html.node "box" [ Attr.css styles ]
