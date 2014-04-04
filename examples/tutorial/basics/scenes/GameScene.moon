import Scene from require "LunoPunk.Scene"
import Block from require "entities.Block"

class GameScene extends Scene
	begin: =>
		@add Block 30, 50

{ :GameScene }
