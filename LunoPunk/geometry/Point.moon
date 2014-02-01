export ^

class Point
	new: (x = 0, y = 0) =>
		-- Add the clone mixin
		clone = require "LunoPunk.utils.mixins.clone"
		clone @
		@x, @y = x, y