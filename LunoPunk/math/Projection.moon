export ^

class Projection
	new: =>
		@max, @min = 0, 0

	-- Check if two projection overlap.
	--
	-- @param	other	The other projection
	--
	-- @return	If they overlap.
	overlaps: (other) => not (@min > other.max or @max < other.min)

	-- Get the value of two projection overlap.
	--
	-- @param	other	The other projection
	--
	-- @return	The overlap value.
	getOverlap: (other) => if @max > other.max
			@max - other.min
		else
			other.max - @min

	-- Prints the projection as a string
	--
	-- @return	String version of the object.
	toString: => string.format "[%f, %f]", @min, @max

	__tostring: => @toString!
