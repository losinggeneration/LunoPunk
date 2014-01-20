require "LovePunk.Tweener"

export ^

class Entity extends Tweener
	new: (x, y, graphic, mask) =>
		-- The bottommost position of the Entity's hitbox.
		@bottom = 0
		-- The center x position of the Entity's hitbox.
		@centerX = 0
		-- The center y position of the Entity's hitbox.
		@centerY = 0
		-- If the Entity should respond to collision checks.
		@collidable = false
		-- Graphical component to render to the screen.
		@graphic = nil
		-- Half the Entity's height.
		@halfHeight = 0
		-- Half the Entity's width.
		@halfWidth = 0
		-- Height of the Entity's hitbox.
		@height = 0
		-- The rendering layer of this Entity. Higher layers are rendered first.
		@layer = 0
		-- The leftmost position of the Entity's hitbox.
		@left = 0
		-- An optional Mask component, used for specialized collision. If this is not assigned, collision checks will use the Entity's hitbox by default.
		@mask = nil
		@name = ""
		-- If the Entity collides with the camera rectangle.
		@onCamera = false
		-- X origin of the Entity's hitbox.
		@originX = 0
		-- Y origin of the Entity's hitbox.
		@originY = 0
		-- The BitmapData target to draw the Entity to. Leave as nil to render to the current screen buffer (default).
		@renderTarget = nil
		-- The rightmost position of the Entity's hitbox.
		@right = 0
		-- The Scene object this Entity has been added to.
		@scene = nil
		-- The topmost position of the Entity's hitbox.
		@top = 0
		-- The collision type, used for collision checking.
		@type = ""
		-- If the Entity should render.
		@visible = false
		-- Width of the Entity's hitbox.
		@width = 0
		-- X position of the Entity in the Scene.
		@x = 0
		-- Y position of the Entity in the Scene.
		@y = 0

	-- The World object is deprecated for FlashPunk-like compatibility
	world: (value) =>
		@scene = value if value != nil
		@scene

	addGraphic: (g) =>
	added: =>
	centerGraphicInRect: =>
	centerOrigin: =>
	clampHorizontal: (left, right, padding) =>
	clampVertical: (top, bottom, padding) =>
	collide: (type, x, y) =>
	collideInto: (type, x, y, array) =>
	collidePoint: (x, y, pX, pY) =>
	collideRect: (x, y, rX, rY, rWidth, rHeight) =>
	collideTypes: (types, x, y) =>
	collideTypesInto: (types, x, y, array) =>
	collideWith: (e, x, y) =>
	distanceFrom: (e, useHitboxes) =>
	distanceToPoint: (px, py, useHitbox) =>
	distanceToRect: (rx, ry, rwidth, rheight) =>
	moveAtAngle: (angle, amount, solidType, sweep) =>
	moveBy: (x, y, solidType, sweep) =>
	moveCollideX: (e) =>
	moveCollideY: (e) =>
	moveTo: (x, y, solidType, sweep) =>
	moveTowards: (x, y, amount, solidType, sweep) =>
	removed: =>
	render: =>
	setHitbox: (width, height, originX, originY) =>
	setHitboxTo: (o) =>
	setOrigin: (x, y) =>
	toString: =>
	update: =>
