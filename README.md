# Elm Css Grid

This package provides a simple css grid system for Elm projects that use rtfeldman/elm-css.

# Whats this all about?

Ive heard whats been referred to as 'the lie of css', which is that despite obstensibly being about style sheets its not really about styling. What it would seem like, is that html is about laying stuff out on a page, and css is about styling it. But thats not really true. If you want to lay stuff out on a page you are going to have to mess around with css. Unfortunately, the concepts of styling and laying out dont neatly correspond to the two technologies of html and css. At this point its just a big coincedence with misleading names. Altho this arrangement doesnt make sense, its still how things are in web development. Im sure if we started from scratch we could make something better.

But as a matter of technique, it does help to think about positioning as a separate task from styling. Css rules can get complicated and are liable to interfere with each other, so if you try to make one monster html element that both looks right and is well placed, then you often just end up with something thats either broken or fragile. To make good maintainable html you can take the simple approach of dedicating some html elements to just positioning and other html elements to styling.

Thats where css grids come in. Css grids just position stuff in a grid, then its up to you to style the stuff in the grid how you need. This package exposes a `row` function and a `column` function. A sequence of `row`s will naturally be organized vertically, and a sequence of `column`s will naturally be organized horizontally.
