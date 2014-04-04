class Color
	new: (color) =>
		{@r, @g, @b} = LP.convertColor color
		@a = 255

	rgb: =>
		{ @r, @g, @b }

{ :Color }
