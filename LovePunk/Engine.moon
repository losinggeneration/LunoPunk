export ^

class Engine
	-- Cap on the elapsed time (default at 30 FPS). Raise this to allow for lower framerates (eg. 1 / 10).
	@maxElapsed = 30.0
	-- The max amount of frames that can be skipped in fixed framerate mode.
	@maxFrameSkip = 0
	-- If the game should stop updating/rendering.
	@paused = false
	-- The amount of milliseconds between ticks in fixed framerate mode.
	@tickRate = 0

	new: (width, height, frameRate, fixed, renderMode) =>

	focusGained: =>
		return

	focusLost: =>
		return

	init: =>
		return

	render: =>
		return

	update: =>
		return
