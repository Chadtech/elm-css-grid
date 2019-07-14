# Elm Css Grid

This package provides a simple css grid system for Elm projects that use `rtfeldman/elm-css`.

The example in thie Ellie app is probably the best demonstration of what this package does: https://ellie-app.com/65Hb3tZTqDya1

![elm css grid](https://i.imgur.com/D2MHRNl.png)

# Whats this all about?

Ive heard whats been referred to as 'the lie of css', which is that despite being an abbreviation for "style sheets" its not really about styling. If you didnt know anything about html or css, it would kind of seem like html is about laying out and css is about styling. Thats not really true. Both html and css are necessary for both laying out and styling. The different concepts dont neatly correspond to the different technologies. At this point in history html and css are just a big ugly accident with misleading names. Im sure if we started the internet from scratch we would make something better than html and css (something like the Elm package `mdgriffith/elm-ui`).

But in practice, it helps to think about positioning as a separate thing from styling. You should have separate blocks of html just for laying things out and other blocks of html just for being styled. If you dont do this, and instead try to make make one monster html element that both looks right and is well placed, you will not have a fun time. It will look funny, it will not be scalable, and it will break very easily. To make good maintainable html you can take the simple approach of dedicating some html elements to just positioning and other html elements to just styling.

Thats where css grids come in. Css grids just position stuff in a grid, then its up to you to style the stuff in the grid how you want. 

# Whats in this package

This package exposes a `row` function and a `column` function. A sequence of `row`s will naturally be organized vertically, and a sequence of `column`s in a row will naturally be organized horizontally. They are flex elements, so if you put only one `column` in a row, it will take up the whole row horizontally. If you have two unstyled column in a row they will naturally each take up 50% of the horizontal space.


# This is an opinionated Api

This api is meant to be used in one way, and it wont let itself be used in another way:
- The type signatures of `row` and `column` are very similar to that of html functions in `elm/html`, with the exception that their first parameter is a `List Css.Style` instead of `List (Attribute msg)`. Layout html does not need attributes. You need attributes for thinks like event handlers, and data. Layout html shouldnt be used for that kind of thing.
- The `column` function makes a `Column msg` and not an `Html msg`. The `row` function takes `List (Column msg)` and not `List (Html msg)`. They only work with each other. A row with one column is fine, and preferable to a row with many non-column children.

You can however style the grid with your own `List Css.Style`, which will override the default styling of the grid components, such as in the case where a row or column needs needs a margin or padding.

# Also

`row`s and `column`s show up in the DOM as `<row></row>` and `<column></column>`.