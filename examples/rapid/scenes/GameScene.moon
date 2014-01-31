require "LunoPunk.Scene"
require "LunoPunk.graphics.Image"

export ^

class GameScene extends Scene
	new: =>
		super!

	begin: =>
		@addGraphic Image "graphics/block.png"