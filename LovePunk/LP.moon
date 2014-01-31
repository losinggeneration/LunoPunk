require "LovePunk.geometry.Point"
require "LovePunk.geometry.Rectangle"
require "LovePunk.geometry.Matrix"
require "LovePunk.Scene"
require "LovePunk.Tweener"

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
	camera: nil
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
	point2: Point
	random: -> math.random!
	randomSeed: nil
	rate: 0
	rect: Rectangle!
	renderMode: nil
	scene: Scene!
	screen: nil
	sprite: nil
	tweener: Tweener!
	volume: nil
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
	approach: (value, target, amount) ->
	choose: (objs) ->
	clamp: (value, min, max) ->
	clampInRect: (object, x, y, width, height, padding) ->
	colorLerp: (fromColor, toColor, t) ->
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

	convertColor: (color) -> { lp.getRed(color), lp.getGreen(color), lp.getBlue(color) }
	getColorRGB: (r, g, b) -> r * 0x10000 + g * 0x100 + b
	getRed: (color) -> math.floor color / 0x10000
	getGreen: (color) -> math.floor color / 0x100 % 0x100
	getBlue: (color) -> math.floor color % 0x100

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

	sceneIsNull: => @scene != @__scene or @__scene == nil

	lerp: (a, b, t) ->
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
	setCamera: (x, y) -> LP.camera.x, LP.camera.y = x, y
	shuffle: (a) ->

	-- Finds the sign of the provided value.
	-- @param	value		The Float to evaluate.
	-- @return	1 if value > 0, -1 if value < 0, and 0 when value == 0.
	sign: (value) -> if value < 0 then -1 else if value == 0 then 0 else 1

	stepTowards: (object, x, y, distance) ->
	swap: (current, a, b) ->
	swapScene: => @__scene = @scene
	timeFlag: ->
	tween: (object, values, duration, options) ->

LP = lp!
