require "LunoPunk.Tween"

export ^

-- Tweens a numeric public property of an Object.
class VarTween extends Tween
	-- Constructor.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	new: (complete, type) =>
		-- Tween information.
		@__object = nil
		@__property = ""
		@__start, @__range = 0, 0

		super 0, type, complete

	-- Tweens a numeric public property.
	-- @param	object		The object containing the property.
	-- @param	property	The name of the property (eg. "x").
	-- @param	to			Value to tween to.
	-- @param	duration	Duration of the tween.
	-- @param	ease		Optional easer function.
	tween: (object, property, to, duration, ease = null) =>
		@__object = object
		@__ease = ease

		-- Check to make sure we have valid parameters
		assert type(object) == "table", "A valid table was not passed."

		@__property = property
		a = tonumber @__object[property]

		-- Check if the variable is a number
		assert a, string.format 'The property "%s" is not numeric.', property

		@__start = a
		@__range = to - @__start
		@__target = duration
		@start!

	-- @private Updates the Tween.
	update: =>
		super!
		@__object[@__property] = @__start + @__range * @t
