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

