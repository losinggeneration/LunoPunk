require "moon"

export instance_of

instance_of: (c, b) ->
	if c.__parent != nil
		base = instance_of c.__parent, b

	base or type(c) == type(b)

