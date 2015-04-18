import LP  from require "LunoPunk.LP"
import Entity from require "LunoPunk.Entity"
import Rect from require "LunoPunk.graphics.prototype.Rect"
import Input from require "LunoPunk.utils.Input"
import Key from require "LunoPunk.utils.Key"

class Player extends Entity
	new: (x, y) =>
		super x, y

		@y @y! - 55
		@graphic Rect 50, 50
		@setHitbox 50, 50

	update: =>
		@moveBy -5, 0 if Input.check(Key.LEFT) and @x! - 5 >= 0
		@moveBy 5, 0 if Input.check(Key.RIGHT) and @x! + 5 + @width <= LP.width

		b = @collide "bullet", @x!, @y!
		b\destroy! if b

		super!

{ :Player }
