require "LunoPunk.Scene"
require "entities.Block"

export ^

class GameScene extends Scene
	begin: =>
		@add Block 30, 50