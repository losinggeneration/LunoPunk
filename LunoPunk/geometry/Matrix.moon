class Matrix
	-- If no arguments are given, it creates an identity matrix:
	-- [a c tx]   [1 0 0]
	-- [b d ty] = [0 1 0]
	-- [0 0  1]   [0 0 1]
	new: (a = 1, b = 0, c = 0, d = 1, tx = 0, ty = 0) =>
		-- Add the clone mixin
		clone = require "LunoPunk.utils.mixins.clone"
		clone @
		@a = a
		@b = b
		@c = c
		@d = d
		@tx = tx
		@ty = ty

{ :Matrix }
