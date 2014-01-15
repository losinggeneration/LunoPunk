require "LovePunk.Entity"
require "LovePunk.Screen"
require "LovePunk.geometry.Rectangle"

export ^

---
-- The main class which manages the game loop
class Engine
	---
	-- Constructor. Defines startup information about your game.
	-- @param width      The width of your game.
	-- @param height     The height of your game.
	-- @param frameRate  The game framerate, in frames per second.
	-- @param fixed      If a fixed-framerate should be used.
	-- @param renderMode Overrides the default render mode for this target
	new: (width = 0, height = 0, frameRate = 0, fixed = false, renderMode) =>
		LP.bounds = Rectangle(0, 0, width, height)
		LP.assignedFrameRate = frameRate
		LP.fixed = fixed

		LP.engine = @
		LP.screen = Screen!
		LP.width = width
		LP.height = height

		LP.randomizeSeed! unless LP.randomSeed

		LP.entity = Entity!
		--LP.time = Lib.getTimer!

		---
		-- Cap on the elapsed time (default at 30 FPS). Raise this to allow for lower framerates (eg. 1 / 10).
		@maxElapsed = 0.0333
		---
		-- The max amount of frames that can be skipped in fixed framerate mode.
		@maxFrameSkip = 0
		---
		-- If the game should stop updating/rendering.
		@paused = false
		---
		-- The amount of milliseconds between ticks in fixed framerate mode.
		@tickRate = 4

		-- Do something with the Löve functions...

	focusGained: =>
	focusLost: =>
	init: =>
	render: =>
	update: =>
