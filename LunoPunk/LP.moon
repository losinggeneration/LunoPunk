import Point from require "LunoPunk.geometry.Point"
import Rectangle from require "LunoPunk.geometry.Rectangle"
import Matrix from require "LunoPunk.geometry.Matrix"
import Tweener from require "LunoPunk.Tweener"

local LP

-- for Lua 5.3 compatibility
table.unpack = unpack if table.unpack == nil

class lp
	-- Private
	BASELAYER = 10
	DEG = -180 / math.pi
	INT_MAX_VALUE = nil
	NUMBER_MAX_VALUE = nil
	RAD = math.pi / 180
	VERSION = "0.0.1"
	__scene = nil

	_gameTime: nil
	_renderTime: nil
	_systemTime: nil
	_updateTime: nil
	assignedFrameRate: nil
	blackColor: 0x00000000
	bounds: nil
	buffer: nil
	camera: Point!
	console: nil
	defaultFont: "default"
	elapsed: 0
	engine: nil
	entity: nil
	fixed: false
	focused: nil
	frameRate: 0
	log: nil
	matrix: Matrix!
	orientations: nil
	pan: nil
	point: Point!
	point2: Point!
	random: -> math.random!
	randomSeed: nil
	rate: 0
	rect: Rectangle!
	renderMode = (value) ->
		return __renderMode if value == nil or __renderMode == value
		__renderMode = value

		-- recreate screen for buffer rendering
		if LP.screen == nil
			LP.screen = Screen!
		else
			LP.screen.init!

		value

	scene: nil
	screen: nil
	sprite: nil
	tweener: Tweener!
	volume: 1
	watch: nil
	world: nil
	zero: Point!

	-- Window/resolution related fields
	fullscreen: false
	halfHeight: -> LP.height/2
	halfWidth: -> LP.width/2
	height: 0
	width: 0
	windowHeight: 0
	windowWidth: 0


	alarm: (delay, complete, typeweenType, tweener) ->
	anchorTo: (object, anchor, distance) ->
	angle: (x1, y1, x2, y2) ->
	angleDifference: (angle1, angle2) ->
	angleXY: (object, angle, length, x, y) ->

	-- Approaches the value towards the target, by the specified amount, without overshooting the target.
	-- @param	value	The starting value.
	-- @param	target	The target that you want value to approach.
	-- @param	amount	How much you want the value to approach target by.
	-- @return	The new value.
	approach: (value, target, amount) -> if value < target - amount
		value + amount
	else if value > target + amount
		value - amount
	else
		target

	choose: (objs) ->

	-- Clamps the value within the minimum and maximum values.
	-- @param	value		The Float to evaluate.
	-- @param	min			The minimum range.
	-- @param	max			The maximum range.
	-- @return	The clamped value.
	clamp: (value, min, max) -> if value < min
		min
	else if value > max
		max
	else
		value

	clampInRect: (object, x, y, width, height, padding) ->
	clear: (t) -> while #t > 0 do table.remove t
	consoleEnabled: ->
	createBitmap: (width, height, transparent, color) ->

	-- Find the distance between two points.
	-- @param	x1		The first x-position.
	-- @param	y1		The first y-position.
	-- @param	x2		The second x-position.
	-- @param	y2		The second y-position.
	-- @return	The distance.
	distance: (x1, y1, x2, y2) -> math.sqrt (x2 - x1)^2 + (y2 - y1)^2

	istanceRectPoint: (px, py, rx, ry, rw, rh) ->

	-- Find the distance between two rectangles. Will return 0 if the rectangles overlap.
	-- @param	x1		The x-position of the first rect.
	-- @param	y1		The y-position of the first rect.
	-- @param	w1		The width of the first rect.
	-- @param	h1		The height of the first rect.
	-- @param	x2		The x-position of the second rect.
	-- @param	y2		The y-position of the second rect.
	-- @param	w2		The width of the second rect.
	-- @param	h2		The height of the second rect.
	-- @return	The distance.
	distanceRects: (x1, y1, w1, h1, x2, y2, w2, h2) ->
		if x1 < x2 + w2 and x2 < x1 + w1
			return 0 if y1 < y2 + h2 and y2 < y1 + h1
			return y1 - (y2 + h2) if y1 > y2
			return y2 - (y1 + h1)

		if y1 < y2 + h2 and y2 < y1 + h1
			return x1 - (x2 + w2) if x1 > x2
			return x2 - (x1 + w1)

		if x1 > x2
			return distance x1, y1, (x2 + w2), (y2 + h2) if y1 > y2
			return distance x1, y1 + h1, x2 + w2, y2

		return distance x1 + w1, y1, x2, y2 + h2 if y1 > y2
		return distance x1 + w1, y1 + h1, x2, y2

	-- Find the distance between a point and a rectangle. Returns 0 if the point is within the rectangle.
	-- @param	px		The x-position of the point.
	-- @param	py		The y-position of the point.
	-- @param	rx		The x-position of the rect.
	-- @param	ry		The y-position of the rect.
	-- @param	rw		The width of the rect.
	-- @param	rh		The height of the rect.
	-- @return	The distance.
	distanceRectPoint: (px, py, rx, ry, rw, rh) ->
		if px >= rx and px <= rx + rw
			return 0 if py >= ry and py <= ry + rh
			return py - (ry + rh) if py > ry
			return ry - py

		if py >= ry and py <= ry + rh
			return px - (rx + rw) if px > rx
			return rx - px

		if px > rx
			return distance px, py, rx + rw, ry + rh if py > ry
			return distance px, py, rx + rw, ry

		return distance px, py, rx, ry + rh if py > ry
		return distance px, py, rx, ry

	-- Find the squared distance between two points.
	-- @param	x1		The first x-position.
	-- @param	y1		The first y-position.
	-- @param	x2		The second x-position.
	-- @param	y2		The second y-position.
	-- @return	The squared distance.
	distanceSquared: (x1, y1, xprint2, y2) -> (x2 - x1)^2 + (y2 - y1)^2

	frames: (from_frame, to_frame, skip) ->
	getImage: (source) -> love.graphics.newImage source
	getColorHSV: (h, s, v) ->
	getColorHue: (color) ->

	getColorSaturation: (color) ->
	getColorValue: (color) ->

	-- Take a 12 bit RGB integer and turn it into a table
	convertColor: (color) -> { lp.getRed(color), lp.getGreen(color), lp.getBlue(color) }

	-- Make a 12 bit RGB integer
	getColorRGB: (r, g, b) -> r * 0x10000 + g * 0x100 + b

	-- Get the red value from an RGB 12 bit integer
	getRed: (color) -> math.floor color / 0x10000

	-- Get the green value from an RGB 12 bit integer
	getGreen: (color) -> math.floor color / 0x100 % 0x100

	-- Get the blue value from an RGB 12 bit integer
	getBlue: (color) -> math.floor color % 0x100

	-- Finds the index of the specified item within a table
	-- Assumes the table is an array indexed table
	indexOf: (tbl, item) -> for i, v in ipairs tbl do return i if item == v

	-- read-only
	DEG: -> DEG

	-- read-only
	NUMBER_MAX_VALUE: -> NUMBER_MAX_VALUE

	-- read-only
	RAD: -> RAD

	-- read-only
	VERSION: -> VERSION

	-- read-only
	BASELAYER: -> BASELAYER

	-- Returns true if the scene doesn't match the internal scene or if the
	-- internal scene is null
	sceneIsNull: => @scene != @__scene or @__scene == nil

	-- Linear interpolation between two values.
	-- @param	a		First value.
	-- @param	b		Second value.
	-- @param	t		Interpolation factor.
	-- @return	When t=0, returns a. When t=1, returns b. When t=0.5, will return halfway between a and b. Etc.
	lerp: (a, b, t = 1) -> a + (b - a) * t

	-- Linear interpolation between two colors.
	-- @param	fromColor		First color.
	-- @param	toColor			Second color.
	-- @param	t				Interpolation value. Clamped to the range [0, 1].
	-- return	RGB component-interpolated color value.
	colorLerp: (fromColor, toColor, t = 1) ->
		if t <= 0
			fromColor
		else if t >= 1
			toColor
		else
			f = LP.convertColor fromColor
			d = LP.convertColor toColor
			d[1] -= f[1]
			d[2] -= f[2]
			d[3] -= f[3]
			f[1] = d[1] * t
			f[2] = d[2] * t
			f[3] = d[3] * t
			LP.getColorRGB table.unpack f

	next: (current, options, loop) ->
	prev: (current, options, loop) ->

	rand: (amount) -> math.random(amount)
	randomizeSeed: -> math.randomseed os.time()

	resetCamera: -> camera.x, camera.y = 0, 0

	resize: (width, height) ->
		-- resize scene to scale
		width /= LP.screen\fullScaleX!
		height = height / LP.screen\fullScaleY!
		LP.width, LP.height = width, height
		LP.bounds.width, LP.bounds.height = width, height
		LP.screen\resize!

	rotateAround: (object, anchor, angle, relative) ->
	round: (num, precision) ->
	scale: (value, min, max, min2, max2) ->
	scaleClamp: (value, min, max, min2, max2) ->

	-- Sets the camera's x and y
	setCamera: (x, y) -> LP.camera.x, LP.camera.y = x, y
	shuffle: (a) ->

	-- Finds the sign of the provided value.
	-- @param	value		The Float to evaluate.
	-- @return	1 if value > 0, -1 if value < 0, and 0 when value == 0.
	sign: (value) -> if value < 0
		-1
	elseif value == 0
		0
	else
		1

	-- Steps the object towards a point.
	-- @param	object		Object to move (must have an x and y property).
	-- @param	x			X position to step towards.
	-- @param	y			Y position to step towards.
	-- @param	distance	The distance to step (will not overshoot target).
	stepTowards: (object, x, y, distance) ->
		assert object\x != nil or object\y != nil, "Object must have x and y components"
		object\x LP.approach object\x!, x, distance
		object\y LP.approach object\y!, y, distance

	-- Swaps the current item between a and b. Useful for quick state/string/value swapping.
	-- @param	current		The currently selected item.
	-- @param	a			Item a.
	-- @param	b			Item b.
	-- @return	Returns a if current is b, and b if current is a.
	swap: (current, a, b) -> if current == a then b else a

	swapScene: => @__scene = @scene
	timeFlag: ->
	tween: (object, values, duration, options) ->

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
