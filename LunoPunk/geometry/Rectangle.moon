export ^

clone = require "LunoPunk.utils.mixins.clone"
moon = require "moon"

class Rectangle
	new: (x = 0, y = 0, w = 0, h = 0) =>
		moon.mixin @, clone
		@x, @y = x, y
		@w, @h = w, h

	width: => @w
	height: => @h