require "LovePunk.Entity"
require "LovePunk.RenderMode"
require "LovePunk.Screen"
require "LovePunk.geometry.Rectangle"
require "LovePunk.utils.Draw"

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
		LP.time = love.timer.getTime!

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

		@__frameList = {}
		@__frameLast = 0
		@__frameListSum = 0

		-- Do something with the Löve functions...
		love.draw = @\render
		love.update = @\update
		if love._version_major >= 0 and love._version_minor >= 9
			love.resize = @\resize

	focusGained: =>
	focusLost: =>
	init: =>
	render: =>
		LP.resize LP.windowWidth, LP.windowHeight if LP.screen.needsResize

		-- timing stuff
		t = love.timer.getDelta!

		@__frameLast = t if @__frameLast == 0

		-- render loop
		if LP.renderMode == RenderMode.Buffer
			LP.screen.swap!
			LP.screen.refresh!

		Draw.resetTarget!

		LP.scene.render! if LP.scene.visible

		LP.screen.redraw! if LP.renderMode == RenderMode.Buffer

		-- more timing stuff
		t = love.timer.getTime!
		@__frameList[#@__frameList] = t - @__frameLast
		@__frameListSum += @__frameList[#@__frameList]
		if #@__frameList > 10
			@__frameListSum -= @__frameList[#@__frameList]
			@__frameList = [frame for frame in *@__frameList[2,]]

		LP.frameRate = 1000 / (@__frameListSum / #@__frameList)
		@__frameLast = t

	update: =>
		LP.scene.updateLists!
		checkScene! if LP\sceneIsNull!
		LP.tweener\updateTweens! if LP.tweener.active and LP.tweener\hasTween!

		if LP.scene.active
			LP.scene\updateTweens! if LP.scene\hasTween!
			LP.scene\update!

		LP.scene\updateLists false

	resize: =>

	checkScene = =>
		return if not LP\sceneIsNull!

		if LP.scene != nil
			LP.scene\endScene!
			LP.scene\updateLists!
			LP.scene\clearTweens! if LP.scene.autoClear and LP.scene\hasTween!
			-- TODO
			-- removeChild(LP.scene.sprite) if LP.scene.sprite
			LP\swapScene!
			-- TODO
			-- addChild LP.scene.sprite
			LP.camera = LP.scene.camera
			LP.scene\begin!
			LP.scene\updateLists!
