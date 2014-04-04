import LP from require "LunoPunk.LP"
import Entity from require "LunoPunk.Entity"
import Rect from require "LunoPunk.graphics.prototype.Rect"
import Image from require "LunoPunk.graphics.Image"

class Bullet extends Entity
	new: =>
		super!

		@graphic Image.createRect 5, 10

		@x LP.rand LP.width
		@setHitbox 5, 10
		@type "bullet"

	update: =>
		@moveBy 0, 3
		@destroy! if @y! >= LP.height
		super!

	destroy: =>
		@scene!\remove @

{ :Bullet }
