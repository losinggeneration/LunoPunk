import LP from require "LunoPunk.LP"
import Matrix from require "LunoPunk.geometry.Matrix"
import EventListener from require "LunoPunk.utils.EventListener"

class Screen
	new: =>
		@init!
		-- LP.engine\addChild @__sprite if LP.renderMode == RenderMode.Buffer

	init: =>
		@__x, @__y = 0, 0
		@__originX, @__originY = 0, 0
		@__angle, @__current = 0, 0
		@__scale, @__scaleX, @__scaleY = 1, 1, 1
		@__matrix = Matrix!
		@__update!

	-- bd Bitmap
	disposeBitmap = (bd) =>

	-- Resizes the screen by recreating the bitmap buffer.
	resize: =>
		if LP.__love "0.8"
			love.graphics.setMode LP.width, LP.height
		elseif LP.__love "0.9", "12.0"
			love.window.setMode LP.width, LP.height

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
	__update: =>
		return if @__matrix == nil -- prevent update on init
		@__matrix.b, @__matrix.c = 0, 0
		@__matrix.a, @__matrix.d = @fullScaleX!, @fullScaleY!
		@__matrix.tx = -@originX! * @__matrix.a
		@__matrix.ty = -@originY! * @__matrix.d
		@__matrix\rotate @__angle unless @__angle == 0
		@__matrix.tx += @originX! * @fullScaleX! + @x!
		@__matrix.ty += @originY! * @fullScaleY! + @y!
		-- TODO
		-- _sprite.transform.matrix = _matrix;

	-- Refresh color of the screen.
	color: (value) =>
		return @__color if value == nil or @__color == value
		@__color = value
		@__color

	-- X offset of the screen.
	-- value int
	-- return int
	x: (value) =>
		return @__x if value == nil or @__x == value
		@__x = value
		@__update!
		@__x

	-- Y offset of the screen.
	-- value int
	-- return int
	y: (value) =>
		return @__y if value == nil or @__y == value
		@__y = value
		@__update!
		@__y

	-- X origin of transformations.
	-- value int
	-- return int
	originX: (value) =>
		return @__originX if value == nil or @__originX == value
		@__originX = value
		@__update!
		@__originX

	-- Y origin of transformations.
	-- value int
	-- return int
	originY: (value) =>
		return @__originY if value == nil or @__originY == value
		@__originY = value
		@__update!
		@__originY

	-- X scale of the screen.
	-- value float
	-- return float
	scaleX: (value) =>
		return @__scaleX if value == nil or @__scaleX == value
		@__scaleX = value
		@fullScaleX = => @scaleX! * @scale!
		@__update!
		-- TODO How does setting this ever set it back?
		@needsResize = => true
		@__scaleX

	-- Y scale of the screen.
	-- value float
	-- return float
	scaleY: (value) =>
		return @__scaleY if value == nil or @__scaleY == value
		@__scaleY = value
		@fullScaleY = => @scaleY! * @scale!
		@__update!
		-- TODO How does setting this ever set it back?
		@needsResize = => true
		@__scaleY

	-- Scale factor of the screen. Final scale is scaleX * scale by scaleY * scale, so
	-- you can use this factor to scale the screen both horizontally and vertically.
	-- value float
	-- return float
	scale: (value) =>
		return @__scale if value == nil or @__scale == value
		@__scale = value
		@fullScaleX = => @scaleX! * @scale!
		@fullScaleY = => @scaleY! * @scale!
		@__update!
		-- TODO How does setting this ever set it back?
		@needsResize = => true
		@__scale

	-- Final X scale value of the screen
	fullScaleX: => 1

	-- Final Y scale value of the screen
	fullScaleY: => 1

	-- True if the scale of the screen has changed.
	needsResize: => false

	-- Rotation of the screen, in degrees.
	angle: (value) =>
		return @__angle * LP.DEG if value == nil
		return value if @__angle == value * LP.RAD
		@__angle = value * LP.RAD
		@__update!
		@__angle

	-- Whether screen smoothing should be used or not.
	-- value bool
	-- return bool
	smoothing = (value) =>
		-- TODO
		@__smoothing = value unless value == nil
		@__smoothing

	-- Width of the screen.
	width: => love.graphics.getWidth!

	-- Height of the screen.
	height: => love.graphics.getHeight!

	-- X position of the mouse on the screen.
	mouseX: => love.mouse.getX!

	-- Y position of the mouse on the screen.
	mouseY: => love.mouse.getY!

	-- Captures the current screen as an Image object.
	-- @return	A new Image object.
	capture: =>
	-- TODO return LunoPunk.graphics.Image

{ :Screen }
