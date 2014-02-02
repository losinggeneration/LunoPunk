require "LunoPunk.Entity"
require "LunoPunk.graphics.Image"
require "LunoPunk.utils.Input"
require "LunoPunk.utils.Key"

export ^

class Block extends Entity
	new: (x, y) =>
		super x, y
		@graphic Image "graphics/block.png"

	update: =>
		@moveBy -2, 0 if Input.check Key.LEFT
		@moveBy 2, 0 if Input.check Key.RIGHT
		super!