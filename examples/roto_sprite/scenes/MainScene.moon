require "LunoPunk.Graphic"
require "LunoPunk.Scene"
require "LunoPunk.utils.Draw"
require "LunoPunk.graphics.Image"
require "LunoPunk.geometry.Point"

export ^

class MainScene extends Scene
	begin: =>
		@img = Image "scenes/front.png"
		@img.originX = @img\width!/2
		@img.originY = @img\height!/2
		@point = Point 400, 100
		@camera = Point 0, 0
		print "MainScene begin"

	update: =>
		super!
		@img.angle += 1

	render: =>
		Draw.circle 200, 100, 50, 0x123456
		Draw.rect 300, 100, 50, 50, 0x654321
		Draw.text "Hello MainScene", 300, 300
		@img\render @point, @camera
		g = Graphic!
		g.visable = true
		e = Entity 25, 25, g
		e\setHitbox 25, 25, 50, 50
		Draw.hitbox e, true, 0xFF00FF
-- 		e\render!
