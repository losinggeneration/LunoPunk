require "LunoPunk.Tween"

export ^

-- Tweens a numeric value.
class NumTween extends Tween
	-- Constructor.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	new: (complete, type) =>
		-- Tween information
		@__start, @__range = 0, 0
		-- The current value.
		@value = 0
		super 0, type, complete

	-- Tweens the value from one value to another.
	-- @param	fromValue		Start value.
	-- @param	toValue			End value.
	-- @param	duration		Duration of the tween.
	-- @param	ease			Optional easer function.
	tween: (fromValue, toValue, duration, ease) =>
		@__start, @value = fromValue, fromValue
		@__range = toValue - @value
		@__target = duration
		@__ease = ease
		@start!

	-- @private Updates the Tween.
	update: =>
		super!
		@value = @__start + @__range * @t
