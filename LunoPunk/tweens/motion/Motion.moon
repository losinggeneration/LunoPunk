require "LunoPunk.Tween"

export ^

class Motion extends Tween
	-- @param	duration	Duration of the Tween.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	-- @param	ease		Optional easer function.
	new: (duration, type = TweenType.Persist, complete = nil, ease = nil) =>
		@x, @y = 0, 0
		super duration, type, complete, ease