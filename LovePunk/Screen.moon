export ^

class Screen
	new: =>
		@init!
		-- LP.engine\addChild @__sprite if LP.renderMode == RenderMode.Buffer

	init: =>
		@__x, @__y = 0, 0
		@__originX, @__originY = 0, 0
		@__angle, @__current = 0, 0
		@__scale, @__scaleX, @__scaleY = 1, 1, 1
		@update!

	addFilter: (filter) =>
	capture: =>
		-- TODO return LovePunk.graphics.Image

	redraw: =>
	refresh: =>
	resize: =>
	swap: =>
	update: =>

	angle: (value) =>
		if value != nil
			return value if @__angle == value * LP.RAD
			@__angle = value * LP.RAD
			@update!
			return @__angle

		@__angle * LP.DEG

	color: (value) =>
		@__color = value if value != nil
		@__color

	mouseX: =>
	mouseY: =>

	-- value float
	-- return float
	angle = (value) =>
		@__angle = value if value != nil
		@__angle

	-- value int
	-- return int
	color = (value) =>
		@__color = value if value != nil
		@__color

	-- value int
	-- return int
	originX = (value) =>
		@__originX = value if value != nil
		@__originX

	-- value int
	-- return int
	originY = (value) =>
		@__originY = value if value != nil
		@__originY

	-- value float
	-- return float
	scale = (value) =>
		@__scale = value if value != nil
		@__scale

	-- value float
	-- return float
	scaleX = (value) =>
		@__scaleX = value if value != nil
		@__scaleX

	-- value float
	-- return float
	scaleY = (value) =>
		@__scaleY = value if value != nil
		@__scaleY

	-- value bool
	-- return bool
	smoothing = (value) =>
		@__smoothing = value if value != nil
		@__smoothing

	-- value int
	-- return int
	x = (value) =>
		@__x = value if value != nil
		@__x

	-- value int
	-- return int
	y = (value) =>
		@__y = value if value != nil
		@__y

	-- bd Bitmap
	disposeBitmap = (bd) =>
