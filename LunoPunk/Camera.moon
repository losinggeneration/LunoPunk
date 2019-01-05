-- TODO verify this works as expected
class Camera
	@x: 0
	@y: 0

	@scale: 1
	@scaleX: 1
	@scaleY: 1
	-- Whether this graphic will be snapped to the nearest whole number pixel
	-- position when rendering. If this is true for either an individual
	-- Graphic or for the Camera, snapping will occur.
	@pixelSnapping: false

	@anchorTarget: nil -- Vector2
	@anchorX: 0
	@anchorY: 0

	@__shakeTime: 0
	@__shakeMagnitude: 0
	@__shakeX: 0
	@__shakeY: 0

	new: (x = 0, y = 0) =>
		@x = x
		@y = y

	-- Set the Camera's position. If provided, px and py determine the part of
	-- the screen to move to the given position; 0.5 will center the camera,
	-- and 1.0 will set the right edge.
	setTo: (x, y, px = 0, py = 0) =>
		-- TODO verify this
		@x = x - ((LP.width / fullScaleX) * px)
		@y = y - ((LP.height / fullScaleY) * py)


	fullScaleX: => @scale * @scaleX
	fullScaleY: => @scale * @scaleY

	-- TODO verify this
	screenScaleX: => @fullScaleX! * LP.screen.scaleX
	screenScaleY: => @fullScaleY! * LP.screen.scaleY

	-- TODO verify this
	width: => LP.screen.width / @screenScaleX!
	height: => LP.screen.height / @screenScaleY!

	-- Return an X value that, after scaling, will result in an integer.
	floorX: (x) => math.floor((x + 0.5) * @screenScaleX!) / @screenScaleX!
	-- Return a Y value that, after scaling, will result in an integer.
	floorY: (y) => math.floor((y + 0.5) * @screenScaleY!) / @screenScaleY!

	-- Anchor the Camera to an Entity or other object with position. The
	-- Camera will keep the target in the specified part of the screen.
	-- @since 4.0.0
	anchor: (target, anchorX = 0.5, anchorY = 0.5) =>
		@anchorTarget = target
		@anchorX = anchorX
		@anchorY = anchorY

	-- TODO verify this
	onCamera(entity) =>
		entity\collideRect(entity.x, entity.y, x, y, LP.width, LP.height)

	-- Cause the screen to shake for a specified length of time.
	-- @param	duration	Duration of shake effect, in seconds.
	-- @param	magnitude	Number of pixels to shake in any direction.
	-- @since	2.5.3
	shake: (duration = 0.5, magnitude = 4) =>
		@__shakeTime = duration if @__shakeTime < duration
		@__shakeMagnitude = magnitude

	-- Stop the screen from shaking immediately.
	-- @since	2.5.3
	shakeStop: => @__shakeTime = 0

	-- TODO verify this
	update: =>
		if @anchorTarget != nil
			tx, ty = @anchorTarget.x, @anchorTarget.y
			if isA(@anchorTarget, Entity!)
				e = @anchorTarget
				tx = e.centerX
				ty = e.centerY
			x = tx - (LP.width / fullScaleX * anchorX)
			y = ty - (LP.height / fullScaleY * anchorY)

		-- screen shake
		if @__shakeTime > 0
			sx = Std.random(_shakeMagnitude * 2 + 1) - _shakeMagnitude
			sy = Std.random(_shakeMagnitude * 2 + 1) - _shakeMagnitude

			x += sx - @__shakeX
			y += sy - @__shakeY

			@__shakeX = sx
			@__shakeY = sy

			@__shakeTime -= LP.elapsed
			@__shakeTime = 0 if @__shakeTime < 0
		else if @__shakeX != 0 or @__shakeY != 0
			x -= @__shakeX
			y -= @__shakeY
			@__shakeX, @__shakeY = 0, 0

{ :Camera }
