import LP from require "LunoPunk.LP"
import Scene from require "LunoPunk.Scene"
import Player from require "entities.Player"
import Bullet from require "entities.Bullet"

class GameScene extends Scene
	begin: =>
		@add Player LP.halfWidth!, LP.height
		@add Bullet!

	update: =>
		super!

		@add Bullet! if LP.rand(50) % 10 == 0

{ :GameScene }
