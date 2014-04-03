require_json = ->
	r, json = pcall require, "dkjson"
	return json if r
	r, json = pcall require, "lua2json"
	return json if r
	r, json = pcall require, "cjson"
	return json if r

-- This should be called from conf.lua from the main directory of your project
-- The filename is actualy very important. Your entire project and LunoPunk
-- must be compiled with moonc before this will work. Love actually reads
-- conf.lua before all others. Using require won't work unless you include the
-- moonscript loader first.
--
-- @param options A table containing options for configuring the engine
-- @param cfg A configuration filename, json is currently accepted. If a pure Lua YAML library is created, that could be an option as well. 
-- @param width The window width
-- @param height The window height
-- @param fullscreen If the engine should switch to fullscreen mode
-- @param title The application title
export config = (options) ->
	if options and type(options.cfg) == "string"
		json = require_json!
		if json == nil
			print "Error loading a json decoding library"
		else
			f, err = io.open options.cfg
			if f == nil
				print err
			else
				tmp_options, err = json.decode f\read "*a"
				f\close!
				if tmp_options == nil
					print err
				else
					options[k] = v for k,v in pairs tmp_options

	love.conf = (t) ->
		if options != nil
			t.window.width = options.width if options.width != nil
			t.window.height = options.height if options.height != nil
			t.window.fullscreen = options.fullscreen if options.fullscreen != nil
			t.title = options.title if options.title != nil
