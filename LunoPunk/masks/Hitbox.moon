import Mask from require "LunoPunk.Mask"

class Hitbox extends Mask
	-- Constructor.
	-- @param	width		Width of the hitbox.
	-- @param	height		Height of the hitbox.
	-- @param	x			X offset of the hitbox.
	-- @param	y			Y offset of the hitbox.
	new: (width = 1, height = 1, x = 0, y = 0) =>
		super!
		@width = width
		@height = height
		@x = x
		@y = y

	collide: (mask) =>
		return @__collideHitbox mask if mask.__class == @.__class
		return @__collideMask mask if mask.__class == Mask.__class
		super!

	-- @private Collides against an Entity.
	__collideMask: (other) =>
		px = @x + @parent.x
		py = @y + @parent.y

		ox = other.parent.originX + other.parent.x
		oy = other.parent.originY + other.parent.y

		return px + @width > ox and
			py + @height > oy and
			px < ox + other.parent.width and
			py < oy + other.parent.height

	-- @private Collides against a Hitbox.
	__collideHitbox: (other) =>
		px = @x + @parent.x
		py = @y + @parent.y

		ox = other.x + other.parent.x
		oy = other.y + other.parent.y

		px + _width > ox and
			py + _height > oy and
			px < ox + other.width and
			py < oy + other.height

	-- X offset.
	setX: (value) =>
		return value if @x == value
		@x = value
		@update! if parent != nil
		@x

	-- Y offset.
	setY: (value) =>
		return value if @y == value
		@y = value
		@update! if parent != nil
		@y

	-- Width.
	setWidth: (value) =>
		return value if @width == value
		@width = value
		@update! if parent != nil
		@width

	-- Height.
	setHeight: (value) =>
		return value if @height == value
		@height = value
		@update! if parent != nil
		@height

	-- Updates the parent's bounds for this mask.
	update: =>
		if @parent != nil
			-- update entity bounds
			@parent.originX = -@x
			@parent.originY = -@y
			@parent.width = @width
			@parent.height = @height

	debugDraw: (camera) =>
		if @parent != nil
			Mask.drawContext.setColor(0xff0000, 0.25)
			Mask.drawContext.rectFilled((parent.x - camera.x + x) * camera.screenScaleX, (parent.y - camera.y + y) * camera.screenScaleY, width * camera.screenScaleX, height * camera.screenScaleY)
			Mask.drawContext.setColor(0xff0000, 0.5)
			Mask.drawContext.rect((parent.x - camera.x + x) * camera.screenScaleX, (parent.y - camera.y + y) * camera.screenScaleY, width * camera.screenScaleX, height * camera.screenScaleY)

	project: (axis, projection) =>
		px, py = _x, _y
		max = Math.NEGATIVE_INFINITY
		min = Math.POSITIVE_INFINITY

		cur = px * axis.x + py * axis.y
		min = cur if cur < min
		max = cur if cur > max

		cur = (px + _width) * axis.x + py * axis.y
		min = cur if cur < min
		max = cur if cur > max

		cur = px * axis.x + (py + _height) * axis.y
		min = cur if cur < min
		max = cur if cur > max

		cur = (px + _width) * axis.x + (py + _height) * axis.y
		min = cur if cur < min
		max = cur if cur > max

		projection.min = min
		projection.max = max

	-- Hitbox information.
	width: 0
	height: 0
	x: 0
	y: 0

{ :Hitbox }
