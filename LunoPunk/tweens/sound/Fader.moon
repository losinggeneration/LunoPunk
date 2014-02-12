require "LunoPunk.Tween"

export ^

-- Global volume fader.
class Fader extends Tween
	-- Constructor.
	-- @param	complete	Optional completion callback.
	-- @param	type		Tween type.
	new: (complete, type)  =>
		-- Fader information.
		@__start, @__range = 0, 0
		super 0, type, complete

	-- Fades FP.volume to the target volume.
	-- @param	volume		The volume to fade to.
	-- @param	duration	Duration of the fade.
	-- @param	ease		Optional easer function.
	fadeTo: (volume, duration, ease = nil) =>
		volume = 0 if volume < 0
		@__start = LP.volume
		@__range = volume - @__start
		@__target = duration
		@__ease = ease
		@start!

	-- @private Updates the Tween.
	update: ()  =>
		super!
		LP.volume = @__start + @__range * @t
