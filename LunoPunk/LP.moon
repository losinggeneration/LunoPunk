import App from require "LunoPunk.App"
import Camera from require "LunoPunk.Camera"
import Point from require "LunoPunk.geometry.Point"
import Rectangle from require "LunoPunk.geometry.Rectangle"
import Tweener from require "LunoPunk.Tweener"

local LP

-- for Lua 5.3 compatibility
table.unpack = unpack if table.unpack == nil

-- TODO fair amount of missing functionality here
class lp
	VERSION = "1.0.0"
	VERSION: -> VERSION

	HAXEPUNK_VERSION = "4.0.1"
	HAXEPUNK_VERSION: -> HAXEPUNK_VERSION

	width: 0
	height: 0

	windowWidth: 0
	windowHeight: 0

	fixed: false
	frameRate: 0
	assignedFrameRate: nil
	elapsed: 0
	rate: 0

	screen: nil
	bounds: nil
	defaultFont: "font/monofonto"

	-- TODO I'm not sure if LP.scene is what is needed here
	camera: -> if LP.scene! == nil
		nil
	else
		LP.scene!.camera

	tweener: Tweener!

	focused: false

	halfWidth: 0
	halfHeight: 0
	orientations: {}
	needsResize: false

	cursor = nil
	cursor: (value) ->
		return cursor if cursor == value
		if value == nil
			Mouse.showCursor()
		else
			Mouse.hideCursor()

		cursor = value
		cursor

	-- TODO
	choose: (objs) ->

	scene: (value) ->
		return LP.engine.scene if value == nil or value == LP.engine.scene
		LP.engine.scene = value

	renderingScene: nil

	resize: (width, height) ->
		-- resize scene to scale
		LP.windowWidth, LP.windowHeight = width, height
		LP.screen\resize width, height
		LP.halfWidth, LP.halfHeight = LP.width / 2, LP.height / 2
		LP.bounds.width, LP.bounds.height = width, height
		scene\resize! for scene in pairs LP.engine._scenes
		LP.needsResize = false

	-- not needed to implement
	-- clear: (array)

	-- Sets the camera position
	setCamera: (x, y) -> LP.camera!.x, LP.camera!.y = x, y
	resetCamera: -> LP.camera!.x, LP.camera!.y = 0, 0

	fullscreen: (value) ->
		return LP.app.fullscreen if value == nil
		LP.app.fullscreen = value

	volume = 1
	volume: (value) ->
		return volume if value == nil
		volume = value

	pan = nil
	pan: (value) ->
		value = -1 if value < -1
		value = 1 if value > 1
		return value if pan == value
		pan = value
		Sfx.onGlobalUpdated true
		pan

	-- not going to implement
	-- indexOf: (arr, v) ->

	-- not going to implement
	-- next: (t, options, loop = true) ->

	-- not going to implement
	-- prev: (t, options, loop = true) ->

	-- not going to imelement
	-- swap: (current, a, b) ->

	-- not going to implement
	-- insertSortedKe: (list, key, compare)

	-- TODO
	timeFlag: ->

	-- TODO
	tween: (object, values, duration, options) ->
	-- TODO
	alarm: (delay, complete, typeweenType, tweener) ->
	-- TODO
	frames: (from_frame, to_frame, skip) ->
	-- TODO
	shuffle: (a) ->

	time = nil
	time: (value) ->
		time = value
		return time

	__gameTime: nil
	__systemTime: nil
	__updateTime: nil

	engine: nil
	app: App!
	entity: nil

	point: Point!
	point2: Point!
	zeroCamera: Camera!
	rect: Rectangle!

	-- Used to determine the Löve version is exactly a version or if it's within the
	-- acceptable range of [version..range)
	-- @param	version		The string containing the major.minor Löve version
	-- @param	range		The string containing the major.minor max Löve version
	-- @return	true if version matches the Löve version
	__love: (version, range) ->
		if range
			release = tonumber(LunoPunk.love_version.release)
			release >= tonumber(version) and release < tonumber(range)
		else
			version == LunoPunk.love_version.release

LP = lp!

-- Setup some initial things since the user didn't
if not LunoPunk
	import extract_love_version, set_love_title from require "LunoPunk.Config"
	extract_love_version love._version
	set_love_title!

-- Don't allow unknown Löve versions
if not (LP.__love "0.8", "12.0")
	assert false, "Unsupported Löve version" .. LunoPunk.love_version.release

{ :LP }
