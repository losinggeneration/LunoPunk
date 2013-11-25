export ^

TweenType = {
	"Persist"
	"Looping"
	"OneShot"
}

class Tween
	@active = false
	@percent = 0.0
	@scale = 0.0
	@parent = nil

	scale: =>
		@scale

	new: (duration, type, complete, ease) =>
		@target = duration
		@type = if type == nil then "Persist" else type
		@ease = ease
		@t = 0

		--if complete != nil
			-- TODO: Add event for when tween is finished
			-- addEventListener(TweenEvent.FINISH, complete);

	update: =>
		@time += if LP.fixed then 1 else LP.elapsed
		@t = @time/@target
		if @ease != nil and @t > 0 and @t < 1
			@t = @ease @t

		if @time >= @target
			@t = 1
			@finish = true

		-- dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
		return

	start: =>
		@time = 0
		if @target == 0
			@active = false
			-- dispatchEvent(new TweenEvent(TweenEvent.FINISH));
		else
			@active = true
			-- dispatchEvent(new TweenEvent(TweenEvent.START));
		return

	@finish: =>
		switch @type
			when "Persist"
				@time = @target
				@active = false
			when "Looping"
				@time %= @target
				@t = @time/@target
				if @ease != nil and @t > 0 and @t < 1
					@t = @ease @t
				@\start!
			when "OneShot"
				@time = @target
				@active = false
				-- parent.removeTween(this);
		@finish = false
		-- dispatchEvent(new TweenEvent(TweenEvent.FINISH));


	cancel: =>
		@active = false
		@parent.removeTween @ if @parent != nil
		return


