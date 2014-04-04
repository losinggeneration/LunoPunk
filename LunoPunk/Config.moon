-- Try a few different json libraries and return one that loads
require_json = ->
	local json
	rj = (s) -> pcall -> json = require s
	if not (rj("dkjson") or rj("lua2json") or rj("cjson"))
		error "Cannot find a json library to use"

	json

-- Extract the Löve version information for later use
extract_love_version = (version) ->
	major, minor, patch = string.match version, "^(%d+)%.(%d+)%.(%d+)$"
	release = string.match version, '^%d+%.%d+'
	export LunoPunk = {love_version: {:release, :major, :minor, :patch}}

-- Sets the window title of the engine
set_love_title = (title, release = false) ->
	development = " (development)" if not release

	if title == nil
		title = string.format "%s%s", "LunoPunk", development
	else
		title = string.format "%s%s", title, development

	if LunoPunk.love_version.release == "0.9" and love.window
		love.window.setTitle title
	elseif love.graphics
		love.graphics.setCaption title

	title

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
-- @param author Likely you or your team's name
-- @param release Setting this to true so the engine doesn't display back traces to the user
config = (options) ->
	if options and type(options.cfg) == "string"
		json = require_json!
		if json == nil
			print "Error loading a json decoding library"
		else
			f, err = io.open options.cfg
			if f == nil
				print "I/O Error:", err
			else
				tmp_options, err = json.decode f\read "*a"
				f\close!
				if tmp_options == nil
					error string.format "Parse error in %s: %s", options.cfg, err
				else
					options[k] = v for k,v in pairs tmp_options

	-- This is the actual callback Löve will call upon loading conf.lua
	love.conf = (t) ->
		extract_love_version t.version

		if options != nil
			window = nil
			if t.version == "0.9.0"
				window = t.window
			else
				window = t.screen

			window.width = options.width if options.width != nil
			window.height = options.height if options.height != nil
			window.fullscreen = options.fullscreen if options.fullscreen != nil
			t.title = set_love_title options.title, options.release
		else
			t.title = set_love_title!

{:config, :extract_love_version, :set_love_title}
