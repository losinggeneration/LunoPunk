import Point from require "LunoPunk.geometry.Point"

class Vector extends Point
	new: (x = 0, y = 0) =>
		super x, y

	-- Calculates the dotProduct between two points
	--
	-- @param	p	The other point
	--
	-- @return The dot product.
	dot: (p) => @x * p.x + @y * p.y

	-- Calculates the cross product
	-- @return A Vector
	cross: => Vector @y, -@x

	toString: => string.format "<%f, %f>", @x, @y

	__tostring: => @toString!

{ :Vector }
