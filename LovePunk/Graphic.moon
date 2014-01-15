export ^

class Graphic
	new: =>
		-- If the graphic should update.
		@active = false
		-- If the graphic should render at its position relative to its parent Entity's position.
		@relative = false
		-- X scrollfactor, effects how much the camera offsets the drawn graphic. Can be used for parallax effect, eg. Set to 0 to follow the camera, 0.5 to move at half-speed of the camera, or 1 (default) to stay still.
		@scrollX = 1.0
		-- Y scrollfactor, effects how much the camera offsets the drawn graphic. Can be used for parallax effect, eg. Set to 0 to follow the camera, 0.5 to move at half-speed of the camera, or 1 (default) to stay still.
		@scrollY = 1.0
		-- If the graphic should render.
		@visible = false
		-- X offset.
		@x = 0.0
		-- Y offset.
		@y = 0.0
		-- The layer to use for rendering, should only be set by the Entity
		@__layer = 0

	layer: =>
		@__layer

	destroy: =>
	pause: =>
	render: (target, point, camera) =>	
	resume: =>
	setEntity: (entity) =>
	update: =>
