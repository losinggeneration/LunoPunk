require "LunoPunk.graphics.Image"
require "LunoPunk.geometry.Rectangle"

export ^

-- Performance-optimized animated Image. Can have multiple animations,
-- which draw frames from the provided source image to the screen.
class Spritemap extends Image
	new: (source, frameWidth = 0, frameHeight = 0, cbFunc = nil, name = "") =>
		-- If the animation has stopped.
		@complete = true
		-- Optional callback function for animation end.
		@callbackFunc
		-- Animation speed factor, alter this to speed up/slow down all animations.
		@rate

		@__rect = Rectangle 0, 0, frameWidth, frameHeight

		super source, _rect, name

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