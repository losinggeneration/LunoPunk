require "LovePunk.LP"
require "LovePunk.Mask"
require "LovePunk.Tweener"

export ^

class Entity extends Tweener
	new: (x = 0, y = 0, graphic = nil, mask = nil) =>
		super!
		-- If the Entity should render.
		@visible = true
		-- If the Entity should respond to collision checks.
		@collidable = true
		-- If the entity should follow the camera.
		@followCamera = false
		-- X position of the Entity in the Scene.
		@__x = x
		-- Y position of the Entity in the Scene.
		@__y = y
		-- X origin of the Entity's hitbox.
		@originX = 0
		-- Y origin of the Entity's hitbox.
		@originY = 0
		-- Width of the Entity's hitbox.
		@width = 0
		-- Height of the Entity's hitbox.
		@height = 0

		-- The bottommost position of the Entity's hitbox.
		@bottom = 0
		-- The center x position of the Entity's hitbox.
		@centerX = 0
		-- The center y position of the Entity's hitbox.
		@centerY = 0
		@__moveX, @__moveY = 0, 0
		-- The collision type, used for collision checking.
		@type = ""
		@name = ""

		@__hitbox = Mask!
		@__point = LP.point
		@__camera = LP.point2

		-- The rendering layer of this Entity. Higher layers are rendered first.
		@layer = LP.BASELAYER!

		-- Graphical component to render to the screen.
		@graphic = graphic if graphic != nil

		-- An optional Mask component, used for specialized collision. If this is not assigned, collision checks will use the Entity's hitbox by default.
		@mask = mask if mask != nil

		@__hitbox\assignTo @

	x: (value) =>
		if value != nil
			@__x = value
			return @__x

		if @followCamera
			@__x + LP.camera.x
		else
			@__x

	y: (value) =>
		if value != nil
			@__y = value
			return @__y
		if @followCamera
			@__y + LP.camera.y
		else
			@__y

	-- The World object is deprecated for FlashPunk-like compatibility
	world: (value) =>
		@scene = value if value != nil
		@scene

	added: =>
	removed: =>
	update: =>
	render: =>
	collide: (type, x, y) =>
	collideTypes: (types, x, y) =>
	collideWith: (e, x, y) =>
	collideRect: (x, y, rX, rY, rWidth, rHeight) =>
	collidePoint: (x, y, pX, pY) =>
	collideInto: (type, x, y, array) =>
	collideTypesInto: (types, x, y, array) =>
	addGraphic: (g) =>
	setHitbox: (width, height, originX, originY) =>
	setHitboxTo: (o) =>
	setOrigin: (x, y) =>
	centerOrigin: =>
	distanceFrom: (e, useHitboxes) =>
	distanceToPoint: (px, py, useHitbox) =>
	distanceToRect: (rx, ry, rwidth, rheight) =>
	toString: =>
	moveBy: (x, y, solidType, sweep) =>
	moveTo: (x, y, solidType, sweep) =>
	moveTowards: (x, y, amount, solidType, sweep) =>
	moveAtAngle: (angle, amount, solidType, sweep) =>
	moveCollideX: (e) =>
	moveCollideY: (e) =>
	clampHorizontal: (left, right, padding) =>
	clampVertical: (top, bottom, padding) =>
	centerGraphicInRect: =>
