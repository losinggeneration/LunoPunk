import Image from require "LunoPunk.graphics.Image"
import Rectangle from require "LunoPunk.geometry.Rectangle"

-- Template used by Spritemap to define animations.
-- Don't create these yourself, instead you can fetch them with Spritemap.add.
class Animation
	-- @param name Animation name.
	-- @param frames Array of frame indices to animate.
	-- @param frameRate Animation speed.
	-- @param loop If the animation should loop.
	new: (name, frames, frameRate = 0, loop = true, parent = nil) =>
		@__name = name
		@__frames = frames
		@__frameRate = frameRate
		@__loop = loop

	-- Plays the animation.
	--
	-- @param reset If the animation should force-restart if it is already playing.
	-- @param reverse If the animation should play in reverse.
	play: (reset = false, reverse = false) =>

	-- Amount of frames in the animation.
	frameCount: => #@__frames

	-- Animation speed.
	frameRate: => @__frameRate

	-- Array of frame indices to animate.
	frames: => @__frames

	-- If the animation loops.
	loop: => @__loop

	-- Name of the animation.
	name: => @__name

-- Performance-optimized animated Image. Can have multiple animations,
-- which draw frames from the provided source image to the screen.
-- TODO
class Spritemap extends Image
	-- @param	source			Source image.
	-- @param	frameWidth		Frame width.
	-- @param	frameHeight		Frame height.
	-- @param	callback		Optional callback function for animation end.
	new: (source, frameWidth = 0, frameHeight = 0, callback = nil, name = "") =>
		-- Optional callback function for animation end.
		@callback = callback
		-- If the animation has stopped.
		@complete = true
		-- Sets the current frame index. When you set this, any animations playing will be stopped to force the frame.
		@frame = 0
		-- Current index of the playing animation.
		@index = 0
		-- Animation speed factor, alter this to speed up/slow down all animations.
		@rate = 1
		-- If the animation is played in reverse.
		@reverse = false
		@__anims = {}
		@__rect = Rectangle 0, 0, frameWidth, frameHeight

		super source, @__rect, name

	update: =>

	-- Add an Animation.
	-- @param	name		Name of the animation.
	-- @param	frames		Array of frame indices to animate through.
	-- @param	frameRate	Animation speed (with variable framerate: in frames per second, with fixed framerate: in frames per frame).
	-- @param	loop		If the animation should loop.
	-- @return	A new Anim object for the animation.
	add: (name, frames, frameRate = 0, loop = true) =>

	-- Plays an animation.
	-- @param	name		Name of the animation to play.
	-- @param	reset		If the animation should force-restart if it is already playing.
	-- @return	Anim object representing the played animation.
	play: (name = "", reset = false) =>

	getFrame: (column = 0, row = 0) =>
	setFrame: (column = 0, row = 0) =>
	randomFrame: =>

	-- Sets the frame to the frame index of an animation.
	-- @param name Animation to draw the frame frame.
	-- @param index Index of the frame of the animation to set to.
	setAnimFrame: (name, index) =>

	-- Columns in the Spritemap.
	columns: => @__columns

	-- The currently playing animation.
	currentAnim: => @__currentAnim

	-- Rows in the Spritemap.
	rows: => @__rows

	-- The amount of frames in the Spritemap.
	frameCount: => @__frameCount

{ :Spritemap }
