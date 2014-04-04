import LP from require "LunoPunk.LP"
import Scene from require "LunoPunk.Scene"
import Player from require "entities.Player"

class GameScene extends Scene
	begin: =>
		@add Player LP.halfWidth!, LP.height

	update: =>
		super!

{ :GameScene }
