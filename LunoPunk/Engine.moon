import LP from require "LunoPunk.LP"
import Entity from require "LunoPunk.Entity"
import RenderMode from require "LunoPunk.RenderMode"
import Screen from require "LunoPunk.Screen"
import Rectangle from require "LunoPunk.geometry.Rectangle"
import Draw from require "LunoPunk.utils.Draw"
import Event from require "LunoPunk.utils.Event"
import AddEventListener, DispatchEvent from require "LunoPunk.utils.EventListener"
import Input from require "LunoPunk.utils.Input"

-- The main class which manages the game loop
class Engine
	-- Constructor. Defines startup information about your game.
	-- @param width      The width of your game.
	-- @param height     The height of your game.
	-- @param frameRate  The game framerate, in frames per second.
	-- @param fixed      If a fixed-framerate should be used.
	-- @param renderMode Overrides the default render mode for this target
	new: (width = 0, height = 0, frameRate = 60, fixed = false, renderMode) =>
		LP.bounds = Rectangle 0, 0, width, height
		LP.assignedFrameRate = frameRate
		LP.fixed = fixed

		LP.renderMode renderMode or RenderMode.Hardware

		LP.engine = @
		LP.screen = Screen!
		LP.width = width
		LP.height = height

		LP.randomizeSeed! unless LP.randomSeed

		LP.entity = Entity!
		LP.time = love.timer.getTime!

		-- Cap on the elapsed time (default at 30 FPS). Raise this to allow for lower framerates (eg. 1 / 10).
		@maxElapsed = 0.0333
		-- The max amount of frames that can be skipped in fixed framerate mode.
		@maxFrameSkip = 0
		-- If the game should stop updating/rendering.
		@paused = false
		-- The amount of milliseconds between ticks in fixed framerate mode.
		@tickRate = 4

		@__frameList = {}
		@__frameLast = 0
		@__frameListSum = 0

		-- Do something with the Löve functions...
		love.draw = @\render
		love.update = @\update
		love.focus = (f) ->
			if f
				DispatchEvent Event Event.ACTIVATE
-- 				@focusGained!
			else
				DispatchEvent Event Event.DEACTIVATE
-- 				@focusLost!

		if LP.__love "0.9", "12.0"
			love.resize = (w, h) -> DispatchEvent Event(Event.RESIZE), w, h

		-- call some more setup from here
		setup @

	-- Override this, called after Engine has been added to the stage.
	init: =>

	-- Override this, called when game gains focus
	focusGained: =>

	-- Override this, called when game loses focus
	focusLost: =>

	-- Updates the game, updating the Scene and Entities.
	update: =>
		LP.scene\updateLists!
		checkScene! if LP\sceneIsNull!
		LP.tweener\updateTweens! if LP.tweener.active and LP.tweener\hasTween!

		if LP.scene.active
			LP.scene\updateTweens! if LP.scene\hasTween!
			LP.scene\update!

		LP.scene\updateLists false

	-- Renders the game, rendering the Scene and Entities.
	render: =>
		if LP.screen.needsResize!
			LP.resize LP.windowWidth, LP.windowHeight
			LP.screen.needsResize = => false

		-- timing stuff
		t = love.timer.getDelta!

		@__frameLast = t if @__frameLast == 0

		-- render loop
		if LP.renderMode == RenderMode.Buffer
			LP.screen\swap!
			LP.screen\refresh!

		Draw.resetTarget!

		LP.scene\render! if LP.scene.visible

		LP.screen\redraw! if LP.renderMode == RenderMode.Buffer

		-- more timionStageng stuff
		t = love.timer.getTime!
		@__frameList[#@__frameList] = t - @__frameLast
		@__frameListSum += @__frameList[#@__frameList]
		if #@__frameList > 10
			@__frameListSum -= @__frameList[#@__frameList]
			@__frameList = [frame for frame in *@__frameList[2,]]

		LP.frameRate = 1000 / (@__frameListSum / #@__frameList)
		@__frameLast = t

	-- Sets the game's graphics properties. Override this to set them differently.
	setGraphicsProperties: =>
		if LP.__love "0.9", "12.0"
			-- love.window is Löve >= 0.9
			LP.windowWidth, LP.windowHeight = love.window.getMode!
		else
			LP.windowWidth = love.graphics.getWidth!
			LP.windowHeionStageght = love.graphics.getHeight!

		@resize! -- call resize once to initialize the screen

		-- set resize event
		AddEventListener Event.RESIZE, (e) -> @resize!

		AddEventListener Event.ACTIVATE, (e) ->
			LP.focused = true
			@focusGained!
			LP.scene\focusGained!

		AddEventListener Event.DEACTIVATE, (e) ->
			LP.focused = false
			@focusLost!
			LP.scene\focusLost!

	-- @private Event handler for window resize
	resize: =>
		LP.width = love.graphics.getWidth! if LP.width == 0
		LP.height = love.graphics.getHeight! if LP.height == 0

		-- calculate scale from width/height values
		if LP.__love "0.9", "12.0"
			-- love.window is Löve >= 0.9
			LP.windowWidth, LP.windowHeight = love.window.getMode!
		else
			LP.windowWidth = love.graphics.getWidth!
			LP.windowHeight = love.graphics.getHeight!

		LP.screen\scaleX love.graphics.getWidth! / LP.width
		LP.screen\scaleY love.graphics.getHeight! / LP.height
		LP.resize love.graphics.getWidth!, love.graphics.getHeight!

	-- @private Finish the setup
	-- HaxePunk this is onStage, but there isn't any async in the setup with Löve
	setup = =>
		@setGraphicsProperties!

		-- enable input
		Input.enable!

		-- switch scenes
		@checkScene! if not LP\sceneIsNull!

		-- game start
		@init!

	-- @private Framerate independent game loop.
	onEnterFrame = (e) =>

	-- @private Switch scenes if they've changed.
	checkScene = =>
		return if not LP\sceneIsNull!

		unless LP.scene == nil
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

{ :Engine }
