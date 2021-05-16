# straightplotter

Visualizes what a simple plotter understands under \"straight line\".

Plotters are the ancestors of our contemporary printers.  Instead of
printing a pixel matrix you gave them a list of commands how it should
move its pen.  Its like the difference between pixel-based file
formats (e.g. PNG, JPG) and verctor-based (e.g. SVG) just for
printers.  The probably simplest type – a so called \"polar plotter\"
– just uses a pen held by two strings against gravity and I was
intrigued by the simplicity since I saw it the first time.  But
yesterday as I though about it a bit I realised that if you want to
draw a straight line you can't just calculate how long the strings
have to be at start and end and then interpolate linearly between them
because that would give a curved line.  A visualisation for these
curved lines is what I tried to implement here.

# Usage
Choose the start and end points by pressing the left respectively the
right mouse button.  Then it automatically draws the line through
these two points that is straight according to polar plotters.  You
can choose new points by pressing the mouse again and it automatically
uses the other point again.  You can hold a mouse button pressed and
then move the mouse to see many possible lines fast and – as long as
you don't change it as indicated below – it saves all old lines till
you press the scroll wheel.  If you just want a line between your two
points you can change that below too.

# Simple Example
For an simple example that makes it intuitively clear *why* these
lines are not really straight consider you want to draw a line from
`(0|1)` to `(1|0)` where one of the strings starts at `(0|0)` and the
other at `(0|1)`: String 1 has to be one unit long both at start and
at the end, while the other has other, here not important, lengths
(`0` and `sqrt(2)` units long, if you want to know).  That means that
the pen is always one unit away from one specific point if we just
interpolate linearly and that means it moves on a circle which is well
known to be not a straight line.
