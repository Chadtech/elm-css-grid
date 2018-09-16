module Html.Grid exposing
    ( column
    , container
    , row
    )

import Css exposing (..)
import Html.Styled as Html
    exposing
        ( Attribute
        , Html
        , node
        )
import Html.Styled.Attributes exposing (css)


{-| Just a container for grids. Its not necessary, but it will get you off to a good start.

    import Html.Grid as Grid

    view =
        Grid.container
            []
            [ Grid.row [] []
            , Grid.row [] []
            ]

-}
container : List Style -> List (Html msg) -> Html msg
container styles =
    node "container" [ css [ containerStyle, Css.batch styles ] ]


containerStyle : Style
containerStyle =
    [ margin2 zero auto ]
        |> Css.batch


row : List Style -> List (Html msg) -> Html msg
row styles =
    node "row" [ css [ rowStyle, Css.batch styles ] ]


rowStyle : Style
rowStyle =
    [ displayFlex
    , flexDirection Css.row
    , boxSizing borderBox
    ]
        |> Css.batch


column : List Style -> List (Html msg) -> Html msg
column styles =
    node "column" [ css [ columnStyle, Css.batch styles ] ]


columnStyle : Style
columnStyle =
    [ flexBasis (pct 100)
    , boxSizing borderBox
    , flex (int 1)
    , displayFlex
    ]
        |> Css.batch
