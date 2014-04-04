import Motion from require "LunoPunk.tweens.motion.Motion"
import Point  from require "LunoPunk.geometry.Point"

-- Determines motion along a cubic curve.
class CubicMotion extends Motion
	-- Constructor.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	new: (complete, type) =>
		-- Curve information.
		@__fromX, @__fromY = 0, 0
		@__toX, @__toY = 0, 0
		@__aX, @__aY = 0, 0
		@__bX, @__bY = 0, 0

		super 0, complete, type, nil

	-- Starts moving along the curve.
	-- @param	fromX		X start.
	-- @param	fromY		Y start.
	-- @param	aX			First control x.
	-- @param	aY			First control y.
	-- @param	bX			Second control x.
	-- @param	bY			Second control y.
	-- @param	toX			X finish.
	-- @param	toY			Y finish.
	-- @param	duration	Duration of the movement.
	-- @param	ease		Optional easer function.
	setMotion: (fromX, fromY, aX, aY, bX, bY, toX, toY, duration, ease = nil) =>
		@x, @__fromX = fromX, fromX
		@y, @__fromY = fromY, fromY
		@__aX, @__aY = aX, aY
		@__bX, @__bY = bX, bY
		@__toX, @__toY = toX, toY
		@__target = duration
		@__ease = ease
		@start!

	-- @private Updates the Tween.
	update: =>
		super!
		ttt = @t^3
		tt = @t^2
		@x = ttt * (@__toX + 3 * (@__aX - @__bX) - @__fromX) + 3 * tt * (@__fromX - 2 * @__aX + @__bX) + 3 * @t * (@__aX - @__fromX) + @__fromX
		@y = ttt * (@__toY + 3 * (@__aY - @__bY) - @__fromY) + 3 * tt * (@__fromY - 2 * @__aY + @__bY) + 3 * @t * (@__aY - @__fromY) + @__fromY

{ :CubicMotion }
