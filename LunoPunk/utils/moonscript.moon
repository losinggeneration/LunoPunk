moon = require "moon"

export instance, moon_type, moon_class

moon_check = (c, b) ->
	moon.type(c) == moon.type(b)

-- Check if an instance of one class
instance = (c, b) ->
	base = false
	if moon.is_object(c) and c.__parent != nil
		base = instance c.__parent, b

	base or moon_check(c, b) or (moon.is_object(c) and b != nil and moon_check(c.__parent, b))

moon_type = moon.type

-- This can be used to easily create a Moonscript compatible class from Lua
-- @param name string The name of the class to create
-- @param init function(self) The function to be called when initializing a new instance
-- @param parent class The parent class (or nil)
-- @param base table The functions and variables for the class base.
moon_class = (name, init, parent, base = {}) ->
	base.__index = base
	setmetatable base, parent.__base if parent
	cls = setmetatable {
		__init: =>
			init @ if init
			parent.__init @ if parent and parent.__init

		__name: name
		__base: base
		__parent: parent
	}, {
		__index: (name) =>
			val = rawget base, name
			return parent[name] if parent
			return val

		__call: (...) =>
			s = setmetatable {}, base
			@.__init s, ...
			s
	}

	base.__class = cls
	parent.__inherited parent, cls if parent and parent.__inherited

	return cls