export ^

class lp
	-- Private
	BASELAYER = nil
	DEG = nil
	INT_MAX_VALUE = nil
	NUMBER_MAX_VALUE = nil
	RAD = nil
	VERSION = "0.0.1"

	@_gameTime: nil
	@_renderTime: nil
	@_systemTime: nil
	@_updateTime: nil
	@assignedFrameRate: nil
	@blackColor: nil
	@bounds: nil
	@buffer: nil
	@camera: nil
	@console: nil
	@defaultFont: nil
	@elapsed: nil
	@engine: nil
	@entity: nil
	@fixed: nil
	@focused: nil
	@frameRate: nil
	@fullscreen: nil
	@halfHeight: nil
	@halfWidth: nil
	@height: nil
	@log: nil
	@matrix: nil
	@orientations: nil
	@pan: nil
	@point: nil
	@point2: nil
	@random: nil
	@randomSeed: nil
	@rate: nil
	@rect: nil
	@renderMode: nil
	@scene: nil
	@screen: nil
	@sprite: nil
	@stage: nil
	@tweener: nil
	@volume: nil
	@watch: nil
	@width: nil
	@windowHeight: nil
	@windowWidth: nil
	@world: nil
	@zero: nil

	@alarm: (delay, complete, typeweenType, tweener) ->
	@anchorTo: (object, anchor, distance) ->
	@angle: (x1, y1, x2, y2) ->
	@angleDifference: (angle1, angle2) ->
	@angleXY: (object, angle, length, x, y) ->
	@approach: (value, target, amount) ->
	@choose: (objs) ->
	@clamp: (value, min, max) ->
	@clampInRect: (object, x, y, width, height, padding) ->
	@clear: (array) ->
	@colorLerp: (fromColor, toColor, t) ->
	@consoleEnabled: ->
	@convertColor: (color) ->
	@createBitmap: (width, height, transparent, color) ->
	@distance: (x1, y1, x2, y2) ->
	@distanceRectPoint: (px, py, rx, ry, rw, rh) ->
	@distanceRects: (x1, y1, w1, h1, x2, y2, w2, h2) ->
	@distanceSquared: (x1, y1, x2, y2) ->
	@frames: (from_frame, to_frame, skip) ->
	@getBitmap: (source) ->
	@getBlue: (color) ->
	@getColorHSV: (h, s, v) ->
	@getColorHue: (color) ->
	@getColorRGB: (R, G, B) ->
	@getColorSaturation: (color) ->
	@getColorValue: (color) ->
	@getGreen: (color) ->
	@getRed: (color) ->

	DEG: ->
		DEG

	NUMBER_MAX_VALUE: ->
		NUMBER_MAX_VALUE

	RAD: ->
		RAD

	VERSION: ->
		VERSION

	@gotoIsNull: ->
	@lerp: (a, b, t) ->
	@next: (current, options, loop) ->
	@prev: (current, options, loop) ->

	rand: (amount) ->
		math.random(amount)

	randomizeSeed: ->
		math.randomseed os.time()

	@resetCamera: ->
	@resize: (width, height) ->
	@rotateAround: (object, anchor, angle, relative) ->
	@round: (num, precision) ->
	@scale: (value, min, max, min2, max2) ->
	@scaleClamp: (value, min, max, min2, max2) ->
	@setCamera: (x, y) ->
	@shuffle: (a) ->
	@sign: (value) ->
	@stepTowards: (object, x, y, distance) ->
	@swap: (current, a, b) ->
	@swapScene: ->
	@timeFlag: ->
	@tween: (object, values, duration, options) ->

LP = lp!
