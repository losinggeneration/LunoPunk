-- Try a few different json libraries and return one that loads
require_json = ->
	local json
	rj = (s) -> pcall -> json = require s
	if not (rj("dkjson") or rj("lua2json") or rj("cjson"))
		error "Cannot find a json library to use"

	json

-- Extract the Löve version information for later use
extract_love_version = (version) ->
	import mixin_table from require "moon"
	local major, minor, patch

	if love.getVersion != nil and love.getVersion() != nil
		major, minor, patch = love.getVersion()
	elseif love._version_major != nil and love._version_minor != nil
		major, minor, patch = love._version_major, love._version_minor, love._version_patch
	else
		major, minor, patch = string.match version, "^(%d+)%.(%d+)%.?(%d+)$"
		major, minor, patch = tonumber(major), tonumber(minor), tonumber(patch)

	release = string.format "%d.%d", major, minor
	export LunoPunk = LunoPunk or {}
	mixin_table LunoPunk, {love_version: {:release, :major, :minor, :patch}}
	LunoPunk

-- Sets the window title of the engine
set_love_title = (title, release = false) ->
	development = if release then "" else " (development)"

	if title == nil
		title = string.format "%s%s", "LunoPunk", development
	else
		title = string.format "%s%s", title, development

	if tonumber(LunoPunk.love_version.release) >= 0.9 and love.window
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
		lp = extract_love_version t.version

		if options == nil
			t.title = set_love_title!
		else
			window = nil
			if tonumber(LunoPunk.love_version.release) >= 0.9
				window = t.window
			else
				window = t.screen

			window.width = options.width unless options.width == nil
			window.height = options.height unless options.height == nil
			window.fullscreen = options.fullscreen unless options.fullscreen == nil
			t.title = set_love_title options.title, options.release

{:config, :extract_love_version, :set_love_title}
