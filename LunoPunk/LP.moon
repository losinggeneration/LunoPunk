require "LunoPunk.geometry.Point"
require "LunoPunk.geometry.Rectangle"
require "LunoPunk.geometry.Matrix"
require "LunoPunk.Scene"
require "LunoPunk.Tweener"

export ^

class lp
	-- Private
	BASELAYER = 10
	DEG = -180 / math.pi
	INT_MAX_VALUE = nil
	NUMBER_MAX_VALUE = nil
	RAD = math.pi / -180
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

	scene: Scene!
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
	approach: (value, target, amount) ->
		if value < target - amount
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
	distance: (x1, y1, x2, y2) ->
	istanceRectPoint: (px, py, rx, ry, rw, rh) ->
	distanceRects: (x1, y1, w1, h1, x2, y2, w2, h2) ->
	distanceSquared: (x1, y1, xprint2, y2) ->
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
			LP.getColorRGB unpack f

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
	sign: (value) -> if value < 0 then -1 else if value == 0 then 0 else 1

	-- Steps the object towards a point.
	-- @param	object		Object to move (must have an x and y property).
	-- @param	x			X position to step towards.
	-- @param	y			Y position to step towards.
	-- @param	distance	The distance to step (will not overshoot target).
	stepTowards: (object, x, y, distance) ->
		assert object.x != nil and object.y != nil, "Object must have x and y components"
		object.x = LP.approach object.x, x, distance
		object.y = LP.approach object.y, y, distance

	swap: (current, a, b) ->
	swapScene: => @__scene = @scene
	timeFlag: ->
	tween: (object, values, duration, options) ->

	-- Used to determine the Löve version that's being used
	-- @param	version		The string containing the major.minor Löve version
	-- @return	true if version matches the Löve version
	__love: (version) -> version == string.format "%d.%d", love._version_major, love._version_minor

LP = lp!

-- Don't allow unknown Löve versions
if not (LP.__love("0.8") or LP.__love("0.9"))
	assert false, "Unsupported Löve version"