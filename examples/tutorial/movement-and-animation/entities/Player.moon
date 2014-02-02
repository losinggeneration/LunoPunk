require "LunoPunk.Entity"
require "LunoPunk.graphics.Spritemap"
require "LunoPunk.utils.Input"
require "LunoPunk.utils.Key"

export ^

class Player extends Entity
	new: (x, y) =>
		super x, y
		@y @y! - 16

		-- create a new spritemap (image, frameWidth, frameHeight)
		@__sprite = Spritemap "graphics/player.png", 16, 16
		-- define animations by passing frames in an array
		@__sprite\add "idle", {0}
		-- we set a speed to the walk animation
		@__sprite\add "walk", {1, 2, 3, 2}, 12
		-- tell the sprite to play the idle animation
		@__sprite\play "idle"

		-- apply the sprite to our graphic object so we can see the player
		@graphic = @__sprite

		-- defines left and right as arrow keys and WASD controls
		Input.define "left", {Key.LEFT, Key.A}
		Input.define "right", {Key.RIGHT, Key.D}

		@__velocity = 0

	handleInput = =>
		@__velocity = 0

		@__velocity = -2 if Input.check "left"
		@__velocity if Input.check "right"

	setAnimations = =>
		if @__velocity == 0
			-- we are stopped, set animation to idle
			@__sprite\play "idle"
		else
			-- we are moving, set animation to walk
			@__sprite\play "walk"

			-- this will flip our sprite based on direction
			if @__velocity < 0 -- left
				@__sprite.flipped = true
			else -- right
				@__sprite.flipped = false

	update: =>
		handleInput @
		@moveBy @__velocity, 0
		setAnimations @

		super!