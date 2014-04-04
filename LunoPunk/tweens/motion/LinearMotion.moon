import Motion from require "LunoPunk.tweens.motion.Motion"

-- Determines motion along a line, from one point to another.
class LinearMotion extends Motion
	-- Constructor.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	new: (complete = nil, type = nil) =>
		-- Line information.
		@__fromX, @__fromY = 0, 0
		@__moveX, @__moveY = 0, 0
		@__distance = -1

		super 0, complete, type, nil


	-- Starts moving along a line.
	-- @param	fromX		X start.
	-- @param	fromY		Y start.
	-- @param	toX			X finish.
	-- @param	toY			Y finish.
	-- @param	duration	Duration of the movement.
	-- @param	ease		Optional easer function.
	setMotion: (fromX, fromY, toX, toY, duration, ease = nil) =>
		@__distance = -1
		@x, @__fromX = fromX, fromX
		@y, @__fromY = fromY, fromY
		@__moveX = toX - fromX
		@__moveY = toY - fromY
		@__target = duration
		@__ease = ease
		@start!

	-- Starts moving along a line at the speed.
	-- @param	fromX		X start.
	-- @param	fromY		Y start.
	-- @param	toX			X finish.
	-- @param	toY			Y finish.
	-- @param	speed		Speed of the movement.
	-- @param	ease		Optional easer function.
	setMotionSpeed: (fromX, fromY, toX, toY, speed, ease = nil) =>
		@__distance = -1
		@x, @__fromX = fromX, fromX
		@y, @__fromY = fromY, fromY
		@__moveX = toX - fromX
		@__moveY = toY - fromY
		@__target = @distance! / speed
		@__ease = ease
		@start!

	-- @private Updates the Tween.
	update: =>
		super!
		@x = @__fromX + @__moveX * @t
		@y = @__fromY + @__moveY * @t
		if @x == @__fromX + @__moveX and @y == @__fromY + @__moveY and @active
			super!
			@finish!

	-- Length of the current line of movement.
	distance: =>
		return @__distance if @__distance >= 0
		@__distance = math.sqrt @__moveX * @__moveX + @__moveY * @__moveY
		return @__distance

{ :LinearMotion }
