import LP from require "LunoPunk.LP"
import Point from require "LunoPunk.geometry.Point"

class Graphic
	new: =>
		-- If the graphic should update.
		@active = false
		-- If the graphic should render.
		@visible = true
		-- X offset.
		@x = 0.0
		-- Y offset.
		@y = 0.0
		-- X scrollfactor, effects how much the camera offsets the drawn graphic. Can be used for parallax effect, eg. Set to 0 to follow the camera, 0.5 to move at half-speed of the camera, or 1 (default) to stay still.
		@scrollX = 1.0
		-- Y scrollfactor, effects how much the camera offsets the drawn graphic. Can be used for parallax effect, eg. Set to 0 to follow the camera, 0.5 to move at half-speed of the camera, or 1 (default) to stay still.
		@scrollY = 1.0
		-- If the graphic should render at its position relative to its parent Entity's position.
		@relative = true
		-- The layer to use for rendering, should only be set by the Entity
		@__layer = LP.BASELAYER!
		@__scroll = true
		@__point = Point!
		@__entity = nil

	-- Updates the graphic.
	update: =>

	-- Removes the graphic from the scene
	destroy: =>

	-- Renders the graphic to the screen buffer.
	-- @param  target     The buffer to draw to.
	-- @param  point      The position to draw the graphic.
	-- @param  camera     The camera offset.
	render: (target, point, camera) =>

	setEntity: (entity) =>
		@__entity = entity
		layer = if entity == nil
			LP.BASELAYER!
		else
			entity.layer

	-- Pause updating this graphic.
	pause: => @active = false

	-- Resume updating this graphic.
	resume: => @active = true

	-- The layer to use for rendering, should only be set by the Entity
	layer: => @__layer

{ :Graphic }
