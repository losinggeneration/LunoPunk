-- TODO
class input
	__defines = {}

	enable: ->

	-- Allows the user to define custom key(s) to check for by name
	define: (key, value) ->
		__defines[key] = value

	-- key is either a string (from Key or the Löve KeyConstants) or a table of strings
	check: (key) ->
		return false if key == nil

		-- Consult the user defined "keys" first
		if type string
			for k, v in pairs __defines
				if k == key -- Found a match, so assign key the value
					key = v
					break

		switch type key
			when "string"
				love.keyboard.isDown key
			when "table"
				love.keyboard.isDown unpack key
			else
				print "Unknown key type", type key

	mouseX: -> love.mouse.getX!
	mouseY: -> love.mouse.getY!

Input = input!

{ :Input }
