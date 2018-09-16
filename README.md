# Elm Css Grid

This package provides a simple css grid system for Elm projects that use `rtfeldman/elm-css`.

# Whats this all about?

Ive heard whats been referred to as 'the lie of css', which is that despite obstensibly being about style sheets its not really about styling. What it would seem like, is that html is about laying stuff out on a page, and css is about styling it. But thats not really true. If you want to lay stuff out on a page you are going to have to mess around with css. The concepts of styling and laying out dont neatly correspond to the two technologies of html and css, unfortunately. At this point in web development its just a big coincedence with misleading names. Altho this arrangement doesnt make sense, its still how things are. Im sure if we started from scratch we could make something better (something like the Elm package `mdgriffith/elm-ui`).

But as a matter of technique, it helps to think about positioning as a separate task from styling. You should have separate blocks of code for laying out and styling. Css rules can get complicated and are liable to interfere with each other, so if you try to make one monster html element that both looks right and is well placed, then you often just end up with something thats either broken or fragile. To make good maintainable html you can take the simple approach of dedicating some html elements to just positioning and other html elements to just styling.

Thats where css grids come in. Css grids just position stuff in a grid, then its up to you to style the stuff in the grid how you need. 

# Whats in this package

This package exposes a `row` function and a `column` function. A sequence of `row`s will naturally be organized vertically, and a sequence of `column`s will naturally be organized horizontally. They are flex elements, so if you put only one `column` in a row, it will take up the whole row horizontally; two `column`s, each take up 50% of the row horizontally.

The type signatures of `row` and `column` are very similar to that of html functions in `elm/html`, with the exception that their first parameter is a `List Css.Style` instead of `List (Attribute msg)`. This is an opinionated api; it takes the position that if something needs attributes its the content inside the grid, not the grid itself. You can however style the grid with your own `List Css.Style`, which will override the default styling of the grid components, such as in the cases where a column needs a fixed width or a row needs a margin.

`row`s and `column`s show up in the DOM as `<row></row>` and `<column></column>`.