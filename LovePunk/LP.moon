require "LovePunk.geometry.Point"
require "LovePunk.geometry.Rectangle"
require "LovePunk.geometry.Matrix"
require "LovePunk.Scene"
require "LovePunk.Tweener"

export ^

class lp
	-- Private
	BASELAYER = 10
	DEG = nil
	INT_MAX_VALUE = nil
	NUMBER_MAX_VALUE = nil
	RAD = nil
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
	fullscreen: nil
	halfHeight: nil
	halfWidth: nil
	height: nil
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
	stage: nil
	tweener: Tweener!
	volume: nil
	watch: nil
	width: nil
	windowHeight: nil
	windowWidth: nil
	world: nil
	zero: Point!

	alarm: (delay, complete, typeweenType, tweener) ->
	anchorTo: (object, anchor, distance) ->
	angle: (x1, y1, x2, y2) ->
	angleDifference: (angle1, angle2) ->
	angleXY: (object, angle, length, x, y) ->
	approach: (value, target, amount) ->
	choose: (objs) ->
	clamp: (value, min, max) ->
	clampInRect: (object, x, y, width, height, padding) ->
	clear: (array) ->
	colorLerp: (fromColor, toColor, t) ->
	consoleEnabled: ->
	convertColor: (color) ->
	createBitmap: (width, height, transparent, color) ->
	distance: (x1, y1, x2, y2) ->
	istanceRectPoint: (px, py, rx, ry, rw, rh) ->
	distanceRects: (x1, y1, w1, h1, x2, y2, w2, h2) ->
	distanceSquared: (x1, y1, xprint2, y2) ->
	frames: (from_frame, to_frame, skip) ->
	getBitmap: (source) ->
	getBlue: (color) ->
	getColorHSV: (h, s, v) ->
	getColorHue: (color) ->
	getColorRGB: (R, G, B) ->
	getColorSaturation: (color) ->
	getColorValue: (color) ->
	getGreen: (color) ->
	getRed: (color) ->

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

	rand: (amount) ->
		math.random(amount)

	randomizeSeed: ->
		math.randomseed os.time()

	resetCamera: ->
	resize: (width, height) ->
	rotateAround: (object, anchor, angle, relative) ->
	round: (num, precision) ->
	scale: (value, min, max, min2, max2) ->
	scaleClamp: (value, min, max, min2, max2) ->
	setCamera: (x, y) ->
	shuffle: (a) ->
	sign: (value) ->
	stepTowards: (object, x, y, distance) ->
	swap: (current, a, b) ->
	swapScene: => @__scene = @scene
	timeFlag: ->
	tween: (object, values, duration, options) ->

LP = lp!
