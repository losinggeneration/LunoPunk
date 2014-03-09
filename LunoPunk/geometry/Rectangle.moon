export ^

class Rectangle
	new: (x = 0, y = 0, w = 0, h = 0) =>
		-- Add the clone mixin
		clone = require "LunoPunk.utils.mixins.clone"
		clone @
		@x, @y = x, y
		@width, @height = w, h
