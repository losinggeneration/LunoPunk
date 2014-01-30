moon = require "moon"

return class clone
	new: =>
	clone: =>
		c = @@!
		moon.mixin_table c, @
		c