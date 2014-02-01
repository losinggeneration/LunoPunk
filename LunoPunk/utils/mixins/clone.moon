moon = require "moon"

return (t) ->
	clone = class
		clone: =>
			c = @@!
			moon.mixin_table c, @
	moon.mixin t, clone