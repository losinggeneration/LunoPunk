export ^

class Rectangle
	new: (x = 0, y = 0, w = 0, h = 0) =>
		@x, @y = x, y
		@w, @h = w, h

	width: => @w
	height: => @h