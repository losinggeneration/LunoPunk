require "LunoPunk.utils.EventListener"
require "LunoPunk.tweens.TweenEvent"

export ^

TweenType = {
	Persist: "Persist"
	Looping: "Looping"
	OneShot: "OneShot"
}

class Tween
	-- Constructor. Specify basic information about the Tween.
	-- @param	duration		Duration of the tween (in seconds or frames).
	-- @param	type			Tween type, one of Tween.PERSIST (default), Tween.LOOPING, or Tween.ONESHOT.
	-- @param	complete		Optional callback for when the Tween completes.
	-- @param	ease			Optional easer function to apply to the Tweened value.
	new: (duration, type = TweenType.Persist, complete = nil, ease = nil) =>
		assert duration != nil, "Cannot create a Tween without a duration"
		@active = false
		@__scale = 0.0
		@__parent = nil
		@__finish = false

		@__target = duration
		@type = if type == nil then "Persist" else type
		@ease = ease
		@t = 0
		@__time = 0

		if complete != nil
			AddEventListener TweenEvent.FINISH!, complete

	-- Updates the Tween, called by World.
	update: =>
		@__time += if LP.fixed then 1 else LP.elapsed
		@t = @__time/@__target
		if @ease != nil and @t > 0 and @t < 1
			@t = @ease @t

		if @__time >= @__target
			@t = 1
			@__finish = true

		DispatchEvent TweenEvent TweenEvent.UPDATE!
		return

	-- Starts the Tween, or restarts it if it's currently running.
	start: =>
		@__time = 0
		if @__target == 0
			@active = false
			DispatchEvent TweenEvent TweenEvent.FINISH!
		else
			@active = true
			DispatchEvent TweenEvent TweenEvent.START!
		return

	-- @private Called when the Tween completes.
	finish = =>
		switch @type
			when "Persist"
				@__time = @__target
				@active = false
			when "Looping"
				@__time %= @__target
				@t = @__time/@__target
				if @ease != nil and @t > 0 and @t < 1
					@t = @ease @t
				@start!
			when "OneShot"
				@__time = @__target
				@active = false
				@parent\removeTween @
		@__finish = false
		DispatchEvent TweenEvent TweenEvent.FINISH!

	-- Immediately stops the Tween and removes it from its Tweener without calling the complete callback.
	cancel: =>
		@active = false
		@parent\removeTween @ if @parent != nil
		return

	percent: (value) =>
		return @__time/@__target if value == nil
		@__time = @__target * value
		@__time

	scale: =>
		@__scale
