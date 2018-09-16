module Html.Grid exposing
    ( column
    , container
    , row
    )

{-|

    import Html.Grid as Grid
    import Html.Styled

    view : Html.Styled.Html msg
    view =
        Grid.container
            []
            [ Grid.row
                []
                [ Grid.column
                    []
                    [ Html.text "Hello from upper left column" ]
                , Grid.column
                    []
                    [ Html.text "Hello from upper right column" ]
                ]
            , Grid.row
                []
                [ Grid.column
                    []
                    [ Html.text "Hello from lower left column" ]
                , Grid.column
                    []
                    [ Html.text "Hello from lower right column" ]
                ]
            ]

-}

import Css exposing (..)
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        , node
        )
import Html.Styled.Attributes exposing (css)


{-| Just a container for grids. Its not necessary, but it will get you off to a good start.

    -- containers are styled with the css:
    --     margin: 0 auto;



-}
container : List Style -> List (Html msg) -> Html msg
container styles =
    node "container" [ css [ containerStyle, Css.batch styles ] ]


containerStyle : Style
containerStyle =
    [ margin2 zero auto ]
        |> Css.batch


{-| A row in a grid

    -- rows are styled with the css:
    --     display: flex;
    --     flex-direction: row;



-}
row : List Style -> List (Html msg) -> Html msg
row styles =
    node "row" [ css [ rowStyle, Css.batch styles ] ]


rowStyle : Style
rowStyle =
    [ displayFlex
    , flexDirection Css.row
    ]
        |> Css.batch


{-| A column in a grid

    -- columns are styled with the css:
    --     flex-basis: 100%;
    --     flex: 1;
    --     display: flex;



-}
column : List Style -> List (Html msg) -> Html msg
column styles =
    node "column" [ css [ columnStyle, Css.batch styles ] ]


columnStyle : Style
columnStyle =
    [ flexBasis (pct 100)
    , flex (int 1)
    , displayFlex
    ]
        |> Css.batch
