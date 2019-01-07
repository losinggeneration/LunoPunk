import App from require 'LunoPunk.App'
import Console from require 'LunoPunk.debug.Console'
import Entity from require "LunoPunk.Entity"
import Rectangle from require "LunoPunk.geometry.Rectangle"
import LP from require "LunoPunk.LP"
import Scene from require "LunoPunk.Scene"
import Screen from require "LunoPunk.Screen"
import Event from require "LunoPunk.utils.Event"
import AddEventListener, DispatchEvent from require "LunoPunk.utils.EventListener"
import Input from require "LunoPunk.utils.Input"

-- Main game Sprite class, added to the Stage.
-- Manages the game loop.
--
-- Your main class **needs** to extends this.
class Engine
	console: nil

	-- If the game should stop updating/rendering.
	paused: false

	-- Cap on the elapsed time (default at 30 FPS). Raise this to allow for lower framerates (eg. 1 / 10).
	maxElapsed: 0.0333

	-- The max amount of frames that can be skipped in fixed framerate mode.
	maxFrameSkip: 5

	-- Invoked before the update cycle begins each frame.
	preUpdate: =>
	-- Invoked after update cycle.
	postUpdate: =>
	-- Invoked before rendering begins each frame.
	preRender: =>
	-- Invoked after rendering completes.
	postRender: =>
	-- Invoked after the screen is resized.
	onResize: =>
	-- Invoked when input is received.
	onInputPressed: =>
	-- Invoked when input is received.
	onInputReleased: =>
	-- Invoked after the scene is switched.
	onSceneSwitch: =>
	-- Invoked when the application is closed.
	onClose: =>

	-- Constructor. Defines startup information about your game.
	-- @param width      The width of your game.
	-- @param height     The height of your game.
	-- @param frameRate  The game framerate, in frames per second.
	-- @param fixed      If a fixed-framerate should be used.
	new: (width = 0, height = 0, frameRate = 60, fixed = false) =>
		LP.bounds = Rectangle 0, 0, width, height
		LP.assignedFrameRate = frameRate
		LP.fixed = fixed

		LP.engine = @
		LP.width = width
		LP.height = height

		LP.screen = Screen!
		@app = @createApp!
		LP.app = @app

		-- TODO
		--Random.randomizeSeed! unless Random.randomSeed

		LP.entity = Entity!
		LP.time = love.timer.getTime!

		@__frameList = {}

		-- TODO
		--@__iterator = VisibleSceneIterator!

		@app\init!

		-- Do something with the Löve functions...
		love.draw = @\onRender
		love.update = @\onUpdate
		love.focus = (f) ->
			if f
				DispatchEvent Event Event.ACTIVATE
			else
				DispatchEvent Event Event.DEACTIVATE

		if LP.__love "0.9", "12.0"
			love.resize = (w, h) -> DispatchEvent Event(Event.RESIZE), w, h

		-- call some more setup from here
		setup @

	createApp: => App @

	-- Override this, called after Engine has been added to the stage.
	init: =>

	-- Override this, called when game gains focus
	focusGained: =>

	-- Override this, called when game loses focus
	focusLost: =>

	-- Updates the game, updating the Scene and Entities.
	update: =>
		LP.resize LP.windowWidth, LP.windowHeight if LP.needsResize

		@_scene\updateLists!
		@checkScene!

		@preUpdate!
		-- TODO
		--@_scene\preUpdate!

		LP.tweener\updateTweens LP.elapsed if LP.tweener.active and LP.tweener\hasTween!

		if @_scene.active
			@_scene\updateTweens LP.elapsed if @_scene\hasTween!
			@_scene\update!

		@_scene\updateLists false

		-- TODO
		--@_scene.postUpdate!
		@postUpdate!

	-- Renders the game, rendering the Scene and Entities.
	onRender: =>
		-- timing stuff
		t = @app\getTimeMillis!

		if @paused
			@_frameLast = t
			return if not Console.enabled

		@_frameLast = t if @_frameLast == 0

		@preRender!

		-- TODO
		--@_renderer\startFrame!

		for scene in *@_iterator
			-- TODO
			-- @_renderer\startScene scene
			LP.renderingScene = scene
			scene\render!
			-- TODO
			--for commands in *scene.batch
				--@_renderer\render commands

			-- TODO
			--@_renderer\flushScene scene

		LP.renderingScene = nil
		-- TODO
		--@_renderer\endFrame!

		@postRender!

		-- more timionStageng stuff
		t = @app\getTimeMillis!
		@_frameList[#@_frameList] = t - @_frameLast
		@_frameListSum += @_frameList[#@_frameList]
		if #@_frameList > 10
			@_frameListSum -= @_frameList[#@_frameList]
			@_frameList = [frame for frame in *@_frameList[2,]]

		LP.frameRate = 1000 / (@_frameListSum / #@_frameList)
		@_frameLast = t

	onUpdate: =>
		@_time = @app\getTimeMillis!
		@_gameTime = @_time
		LP._systemTime = @_time - @_systemTime
		@_updateTime = @_time

		-- update timer
		elapsed = @_time - @_last / 1000
		if LP.fixed
			@_elapsed += elapsed
			LP.elapsed = 1 / LP.assignedFrameRate
			@_elapsed = LP.elapsed * @maxFrameSkip if @_elapsed > LP.elapsed * @maxFrameSkip
			while @_elapsed > LP.elapsed
				@_elapsed -= LP.elapsed
				@step!

		else
			LP.elapsed = elapsed
			LP.elapsed = @maxElapsed if LP.elapsed > @maxElapsed
			LP.elapsed *= LP.rate
			@step!

		@_last = @_time

		-- update timer
		@_time = @app\getTimeMillis!
		LP._updateTime = @_time - @_updateTime

		-- update timer
		@_time = @app\getTimeMillis!
		@_systemTime = @_timer
		LP._gameTime = @_time - @_gameTime

	step: =>
		-- update input
		-- TODO
		--Input.update!

		-- update loop
		@update! if not @paused

		-- update console
		-- TODO
		--@console\update! if @console

		-- TODO
		--Input.postUpdate!

	-- @private Switch scenes if they've changed.
	checkScene: =>
		if @_scene != nil and #@_scenes > 0 and @_scenes[#@_scenes - 1] != @_scene
			-- TODO
			--Log.debug("ending scene: ", @_scene.__name)
			@_scene\endScene!
			@_scene\updateLists false
			@_scene\clearTweens! if @_scene.autoClear and @_scene\hasTween!

			@_scene = @_scenes[#@_scenes - 1]

			@onSceneSwitch!

			-- TODO
			--Log.debug("starting scene: ", @_scene.__name)
			@_scene.assetCache\enable!
			@_scene\updateLists!
			if @_scene.started
				@_scene\resume!
			else
				@_scene\begin!
			@_scene.started = true
			@_scene\updateLists true

	pushScene: (value) =>
		-- TODO
		--Log.debug("pushed scene: ", value.__name)
		@_scenes[#@_scenes] = value

	popScene: =>
		-- TODO
		--Log.debug("poped scene: ", value.__name)
		scene = table.remove @_scenes, #@_scenes-1
		scene.assetCache\dispose! if scene.assetCache.enabled
		scene

	app: nil

	_scene: Scene!
	_scenes: {}

	_delta: 0
	_time: 0
	_last: 0
	_rate: 0
	_skip: 0
	_prev: 0
	_elapsed: 0

	_updateTime: 0
	_gameTime: 0
	_systemTime: 0

	_frameLast: 0
	_frameListSum: 0
	_frameList: {}

	_render: nil

	_iterator: {}

	-- LunoPunk/Löve specific implementation from backend/flash/haxepunk/_internal/FlashApp
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
			--@focusGained!
			--@_scene\focusGained!

		AddEventListener Event.DEACTIVATE, (e) ->
			LP.focused = false
			--@focusLost!
			--@_scene\focusLost!

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
		@checkScene!

		-- game start
		@init!

	-- @private Framerate independent game loop.
	onEnterFrame = (e) =>

{ :Engine }
