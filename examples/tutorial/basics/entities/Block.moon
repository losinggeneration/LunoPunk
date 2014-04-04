import Entity from require "LunoPunk.Entity"
import Image from require "LunoPunk.graphics.Image"
import Input from require "LunoPunk.utils.Input"
import Key from require "LunoPunk.utils.Key"

class Block extends Entity
	new: (x, y) =>
		super x, y
		@graphic Image "graphics/block.png"

	update: =>
		@moveBy -2, 0 if Input.check Key.LEFT
		@moveBy 2, 0 if Input.check Key.RIGHT
		super!

{ :Block }
