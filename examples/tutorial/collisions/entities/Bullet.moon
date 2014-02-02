require "LunoPunk.LP"
require "LunoPunk.Entity"
require "LunoPunk.graphics.prototype.Rect"

export ^

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