import Hitbox from require "LunoPunk.masks.Hitbox"

class Masklist extends Hitbox
	collide: (mask) =>
		return @__collideMasklist mask if mask.__class == @.__class
		super!

	__collideMasklist: (mask) => false

{ :Masklist }
