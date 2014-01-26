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

	-- bd Bitmap
	disposeBitmap = (bd) =>

	-- Resizes the screen by recreating the bitmap buffer.
	resize: =>

	-- Swaps screen buffers.
	swap: =>

	-- Add a filter.
	--
	-- @param	filter	The filter to add.
	addFilter: (filter) =>

	-- Refreshes the screen.
	refresh: =>

	-- Redraws the screen.
	redraw: =>

	-- @private Re-applies transformation matrix.
	update = =>

	-- Refresh color of the screen.
	color: (value) =>
		@__color = value if value != nil
		@__color

	-- X offset of the screen.
	-- value int
	-- return int
	x = (value) =>
		@__x = value if value != nil
		@__x

	-- Y offset of the screen.
	-- value int
	-- return int
	y = (value) =>
		@__y = value if value != nil
		@__y

	-- X origin of transformations.
	-- value int
	-- return int
	originX = (value) =>
		@__originX = value if value != nil
		@__originX

	-- Y origin of transformations.
	-- value int
	-- return int
	originY = (value) =>
		@__originY = value if value != nil
		@__originY

	-- X scale of the screen.
	-- value float
	-- return float
	scaleX = (value) =>
		@__scaleX = value if value != nil
		@__scaleX

	-- Y scale of the screen.
	-- value float
	-- return float
	scaleY = (value) =>
		@__scaleY = value if value != nil
		@__scaleY

	-- Scale factor of the screen. Final scale is scaleX * scale by scaleY * scale, so
	-- you can use this factor to scale the screen both horizontally and vertically.
	-- value float
	-- return float
	scale = (value) =>
		@__scale = value if value != nil
		@__scale

	-- Final X scale value of the screen
	fullScaleX: => 1

	-- Final Y scale value of the screen
	fullScaleY: => 1

	-- True if the scale of the screen has changed.
	needsResize: => false

	-- Rotation of the screen, in degrees.
	angle: (value) =>
		if value != nil
			return value if @__angle == value * LP.RAD
			@__angle = value * LP.RAD
			@update!
			return @__angle

		@__angle * LP.DEG

	-- Whether screen smoothing should be used or not.
	-- value bool
	-- return bool
	smoothing = (value) =>
		-- TODO
		@__smoothing = value if value != nil
		@__smoothing

	-- Width of the screen.
	width: => @__width

	-- Height of the screen.
	height: => @__height

	-- X position of the mouse on the screen.
	mouseX: =>

	-- Y position of the mouse on the screen.
	mouseY: =>

	-- Captures the current screen as an Image object.
	-- @return	A new Image object.
	capture: =>
	-- TODO return LovePunk.graphics.Image
