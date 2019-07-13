# Elm Css Grid

This package provides a simple css grid system for Elm projects that use `rtfeldman/elm-css`.

The example in thie Ellie app is probably the best demonstration of what this package does: https://ellie-app.com/3mNH5mn87Nba1

![elm css grid](https://i.imgur.com/22BIO5V.png)

# Whats this all about?

Ive heard whats been referred to as 'the lie of css', which is that despite obstensibly being about style sheets its not really about styling. If you didnt know anything about html or css, it would kind of seem like html is about laying out and css is about styling. But you know, thats not really true. Both html and css are necessary for both laying out and styling. The concepts dont neatly correspond to the technologies. At this point in history html and css are just a big accident with misleading names. Im sure if we started from scratch we could make something better (something like the Elm package `mdgriffith/elm-ui`).

But in practice, it helps to think about positioning as a separate task from styling. You should have separate blocks of html for laying out and styling. Css rules can get complicated and are liable to interfere with each other. Making one monster html element that both looks right and is well placed just doesnt work. To make good maintainable html you can take the simple approach of dedicating some html elements to just positioning and other html elements to just styling.

Thats where css grids come in. Css grids just position stuff in a grid, then its up to you to style the stuff in the grid how you need. 

# Whats in this package

This package exposes a `row` function and a `column` function. A sequence of `row`s will naturally be organized vertically, and a sequence of `column`s in a row will naturally be organized horizontally. They are flex elements, so if you put only one `column` in a row, it will take up the whole row horizontally. Two columns will each take up 50% of the row horizontally.

The type signatures of `row` and `column` are very similar to that of html functions in `elm/html`, with the exception that their first parameter is a `List Css.Style` instead of `List (Attribute msg)`. This is an opinionated api; layout html does not need attributes. You can however style the grid with your own `List Css.Style`, which will override the default styling of the grid components, such as in the cases where a column needs a fixed width or a row needs a margin.

`row`s and `column`s show up in the DOM as `<row></row>` and `<column></column>`.