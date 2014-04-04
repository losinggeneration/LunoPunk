class List
	new: =>
		@__list = {}

	-- Add an item to the end of the list
	push: (value) => @__list[@len! + 1] = value

	-- Remove an item from the end of the list
	pop: => table.remove @__list, @len!

	-- Look at the item at the end of the list
	peek: => @__list[@len!]

	-- The last item in the list
	last: => @peek!

	-- Add an item to the begining of the list
	unshift: (value) => table.insert @__list, 1, value

	-- Remove an item from the begining of the list
	shift: => table.remove @__list, 1

	-- Remove an item at any point
	remove: (i) => table.remove @__list, i

	-- Look at the item at the begining of the list
	first: => @__list[1]

	len: => #@__list
	__len: => @len!

	__tostring: => string.format "{ %s }", table.concat @__list, ", "

	index: (i) => @__list[i]

	-- Iterate over the list
	-- Removing items during iteration may cause unexpected results
	pairs: =>
		n, len = 0, @len!
		->
			n += 1
			return nil if n > len
			@__list[n]

	-- Reverse iterate over the list
	-- Removing items during iteration may cause unexpected results
	rpairs: =>
		n = @len! + 1
		->
			n -= 1
			return nil if n < 1
			@__list[n]

	-- Iterate over the list returning the index as well
	-- Removing items during iteration may cause unexpected results
	ipairs: =>
		n, len = 0, @len!
		->
			n += 1
			return nil if n > len
			n, @__list[n]

	-- Reverse iterate over the list returning the index as well
	-- Removing items during iteration may cause unexpected results
	ripairs: =>
		n = @len! + 1
		->
			n -= 1
			return nil if n < 1
			n, @__list[n]

{ :List }
