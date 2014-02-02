require "LunoPunk.LP"
require "LunoPunk.Scene"
require "entities.Player"
require "entities.Bullet"

export ^

class GameScene extends Scene
	begin: =>
		@add Player LP.halfWidth!, LP.height
		@add Bullet!

	update: =>
		super!

		@add Bullet! if LP.rand(50) % 10 == 0