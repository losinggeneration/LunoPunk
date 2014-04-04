import Scene from require "LunoPunk.Scene"
import Image from require "LunoPunk.graphics.Image"

class GameScene extends Scene
	new: =>
		super!

	begin: =>
		@addGraphic Image "graphics/block.png"

{ :GameScene }
