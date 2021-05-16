/*
 * straightplotter
 * Copyright (c) 2021 Matthias Kaak
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

//! Visualizes what a simple plotter understands under \"straight line\".
//!
//! Plotters are the ancestors of our contemporary printers.  Instead
//! of printing a pixel matrix you gave them a list of commands how it
//! should move its pen.  Its like the difference between pixel-based
//! file formats (e.g. PNG, JPG) and verctor-based (e.g. SVG) just for
//! printers.  The probably simplest type – a so called \"polar
//! plotter\" – just uses a pen held by two strings against gravity
//! and I was intrigued by the simplicity since I saw it the first
//! time.  But yesterday as I though about it a bit I realised that if
//! you want to draw a straight line you can't just calculate how long
//! the strings have to be at start and end and then interpolate
//! linearly between them because that would give a curved line.  A
//! visualisation for these curved lines is what I tried to implement
//! here.
//!
//! # Usage
//! Choose the start and end points by pressing the left respectively
//! the right mouse button.  Then it automatically draws the line
//! through these two points that is straight according to polar
//! plotters.  You can choose new points by pressing the mouse again
//! and it automatically uses the other point again.  You can hold a
//! mouse button pressed and then move the mouse to see many possible
//! lines fast and – as long as you don't change it as indicated below
//! – it saves all old lines till you press the scroll wheel.  If you
//! just want a line between your two points you can change that below
//! too.
//!
//! # Simple Example
//! For an simple example that makes it intuitively clear *why* these
//! lines are not really straight consider you want to draw a line
//! from `(0|1)` to `(1|0)` where one of the strings starts at `(0|0)` and
//! the other at `(0|1)`: String 1 has to be one unit long both at start
//! and at the end, while the other has other, here not important,
//! lengths (`0` and `sqrt(2)` units long, if you want to know).  That
//! means that the pen is always one unit away from one specific point
//! if we just interpolate linearly and that means it moves on a
//! circle which is well known to be not a straight line.

int sizex = 1024;
int sizey = 768;

Point left_mouse;
Point right_mouse;

class Point
{
  int x;
  int y;

  Point(int x,
	int y)
  {
    this.x = x;
    this.y = y;
  }
};

Point from_lines(double len1,
		 double len2)
{
  double x = (sizex*sizex + len1*len1 - len2*len2)/(2*sizex);
  double y = sqrt((float) (len1*len1 - x*x));

  return new Point((int) x, (int) y);
}

int len1(Point v)
{
  return (int) sqrt((float) v.x*v.x + v.y*v.y);
}

int len2(Point v)
{
  return (int) sqrt((float) (v.x-sizex)*(v.x-sizex) + v.y*v.y);
}

void setup()
{
  background(color(255));
  size(1024, 768);

  left_mouse = new Point(0, 0);
  right_mouse = new Point(0, 0);
}

void draw()
{
  double i;

  double start1 = len1(left_mouse);
  double start2 = len2(left_mouse);
  double end1 = len1(right_mouse);
  double end2 = len2(right_mouse);

  // Uncomment the following line so that it always just draws one
  // line, not all since the last time scroll wheel was pressed.
  // background(color(255));

  // Change `-10` to `0` and `10` to `1` if you just want to see the
  // line between the two points you choose.
  for(i = -10; i < 10; i += 0.001)
    {
      double len1 = start1*(1-i) + end1*i;
      double len2 = start2*(1-i) + end2*i;

      if(len1 < 0 || len2 < 0)
	continue;

      Point p = from_lines(len1, len2);

      point(p.x, p.y);
    }
}

void mouseDragged()
{
  if(mouseButton == LEFT)
    left_mouse = new Point(mouseX, mouseY);
  else if(mouseButton == RIGHT)
    right_mouse = new Point(mouseX, mouseY);
  else
    background(color(255));
}

void mouseClicked()
{
    mouseDragged();
}
