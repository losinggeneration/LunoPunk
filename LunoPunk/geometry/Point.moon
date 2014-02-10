export ^

-- Implementation of the AS3 Point. The API interface was used for function
-- names, but the code is original work.
class Point
	new: (x = 0, y = 0) =>
		-- Add the clone mixin
		clone = require "LunoPunk.utils.mixins.clone"
		clone @
		@x, @y = x, y

	-- The length of the line from (0, 0) to the point
	length: => math.sqrt @x^2 + @y^2

	-- Add two points together
	add: (p) => Point @x + p.x, @y + p.y

	__add: (p) => @add p

	-- Copies point data from p to this Point
	copyFrom: (p) => @x, @y = p.x, p.y

	-- The distance between two points
	distance: (p1, p2) -> math.sqrt (p1.x - p2.x)^2 + (p1.y - p2.y)^2

	-- determine if two points are equal
	equals: (p) => @x == p.x and @y == p.y

	-- offsets the point by an amount
	offset: (dx, dy) =>
		@x += dx
		@y += dy

	-- set the point to a new value
	set: (x, y) => @x, @y = x, y

	-- Subtracts p from this point to create a new Point
	subtract: (p) => Point @x - p.x, @y - p.y

	toString: => string.format "(%f, %f)", @x, @y

	__tostring: => @toString!