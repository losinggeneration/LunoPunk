moon = require "moon"

export instance, moon_type

moon_check = (c, b) ->
	moon.type(c) == moon.type(b)

instance = (c, b) ->
	base = false
	if c.__parent != nil
		base = instance c.__parent, b

	base or moon_check(c, b) or moon_check(c.__parent, b)

moon_type = moon.type