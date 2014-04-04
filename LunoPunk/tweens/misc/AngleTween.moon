import Tween from require "LunoPunk.Tween"

-- Tweens from one angle to another.
class AngleTween extends Tween
	-- Constructor.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	 new: (complete, type) =>
		@__start, @__range = 0, 0
		-- The current value.
		@angle = 0
		super 0, type, complete

	-- Tweens the value from one angle to another.
	-- @param	fromAngle		Start angle.
	-- @param	toAngle			End angle.
	-- @param	duration		Duration of the tween.
	-- @param	ease			Optional easer function.
	 tween: (fromAngle, toAngle, duration, ease = null) =>
		@__start, @angle = fromAngle, fromAngle
		d = toAngle - @angle
		a = math.abs(d)
		if a > 181
			@__range = (360 - a) * (if d > 0 then -1 else 1)
		else if a < 179
			@__range = d
		else
			@__range = LP.choose {180, -180}
		@__target = duration
		@__ease = ease
		@start!

	--  @private Updates the Tween.
	 update: =>
		super!
		@angle = (@__start + @__range * @t) % 360
		@angle += 360 if angle < 0

{ :AngleTween }
