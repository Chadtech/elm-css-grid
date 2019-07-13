module Html.Grid exposing
    ( Cell, row, cell
    , column
    )

{-|

    import Html.Grid as Grid
    import Html.Styled

    view : Html.Styled.Html msg
    view =
        Html.Styled.div
            [ Grid.row
                []
                [ Grid.cell
                    []
                    [ Html.text "Hello from upper left corner" ]
                , Grid.cell
                    []
                    [ Html.text "Hello from upper right corner" ]
                ]
            , Grid.row
                []
                [ Grid.cell
                    []
                    [ Html.text "Hello from lower left corner" ]
                , Grid.cell
                    []
                    [ Html.text "Hello from lower right corner" ]
                ]
            ]

@docs Cell, row, cell, box

-}

import Css exposing (Style, displayFlex, flex, flexBasis, flexDirection, pct)
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        )
import Html.Styled.Attributes as Attr


type Cell msg
    = Cell (List Style) (List (Html msg))


{-|

    -- cells are styled with the css:
    --     flex-basis: 100%;
    --     flex: 1;
    --     display: flex;



-}
cell : List Style -> List (Html msg) -> Cell msg
cell =
    Cell


cellToHtml : Cell msg -> Html msg
cellToHtml (Cell styles children) =
    Html.node "cell"
        [ Attr.css
            [ flexBasis (pct 100)
            , flex (int 1)
            , displayFlex
            , Css.batch styles
            ]
        ]
        children


{-| A row in a grid

    -- rows are styled with the css:
    --     display: flex;
    --     flex-direction: row;



-}
row : List Style -> List (Cell msg) -> Html msg
row styles cells =
    Html.node "row"
        [ Attr.css
            [ displayFlex
            , flexDirection Css.row
            , Css.batch styles
            ]
        ]
        (List.map cellToHtml cells)
