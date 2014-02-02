require "LunoPunk.LP"
require "LunoPunk.Scene"
require "entities.Player"

export ^

class GameScene extends Scene
	begin: =>
		@add Player LP.halfWidth!, LP.height

	update: =>
		super!
