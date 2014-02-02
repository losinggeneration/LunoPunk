export ^

class input
	enable: ->
	define: (value) ->

	-- key is either a string (from Key or the Löve KeyConstants) or a table of strings
	check: (key) ->
		return false if key == nil
		switch type key
			when "string"
				love.keyboard.isDown key
			when "table"
				love.keyboard.isDown unpack key
			else
				print "Unknown key type", type key

Input = input!
