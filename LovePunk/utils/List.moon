export ^

class List
	new: =>
		@__list = {}

	push: (value) =>
		@__list[#@__list + 1] = value

	pop: =>
		value = @__list[1]
		table.remove @__list, 1

	peek: =>
		@__list[1]

	last: =>
		@__list[#@__list]

	pairs: =>
		n = 0
		->
			n += 1
			return nil if n > #@__list
			n, @__list[n]