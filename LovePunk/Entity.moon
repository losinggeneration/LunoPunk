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
		@__type = ""
		@name = ""

		@__hitbox = Mask!
		@__point = LP.point
		@__camera = LP.point2

		-- The rendering layer of this Entity. Higher layers are rendered first.
		@__layer = LP.BASELAYER!

		-- Graphical component to render to the screen.
		@__graphic = graphic if graphic != nil

		-- An optional Mask component, used for specialized collision. If this is not assigned, collision checks will use the Entity's hitbox by default.
		@__mask = mask if mask != nil

		@__hitbox\assignTo @

	-- X position of the Entity in the Scene.
	x: (value) =>
		if value != nil
			@__x = value
			return @__x

		if @followCamera
			@__x + LP.camera.x
		else
			@__x

	-- Y position of the Entity in the Scene.
	y: (value) =>
		if value != nil
			@__y = value
			return @__y
		if @followCamera
			@__y + LP.camera.y
		else
			@__y

	-- Some helper accessors

	-- If the Entity collides with the camera rectangle.
	onCamera: =>
		return false if @__scene == nil
		@collideRect @x!, @y!, @__scene.camera.x, @__scene.camera.y, LP.width, LP.height

	-- Half the Entity's width.
	halfWidth: => @width/2
	-- Half the Entity's height.
	halfHeight: => @height/2
	-- The center x position of the Entity's hitbox.
	centerX: => @x! - @originX + @halfWidth!
	-- The center y position of the Entity's hitbox.
	centerY: => @y! - @originY + @halfHeight!
	-- The leftmost position of the Entity's hitbox.
	left: => @x! - @originX
	-- The rightmost position of the Entity's hitbox.
	right: => @x! - @originX + @width
	-- The topmost position of the Entity's hitbox.
	top: => @y! - @originY
	-- The bottommost position of the Entity's hitbox.
	bottom: => @y! - @originY + @height

	layer: (value) =>
		return @__layer if value == nil

		@__graphic.layer = value if @__graphic != nil

		if @__scene == nil
			@__layer = value
			return @__layer

		@__scene.removeRender @
		@__layer = if value then value else nil
		@__scene.addRender @
		@__layer

	type: (value) =>
		return @__type if value == nil

		if @__scene == nil
			@__type = value
			return @__type

		@__scene.removeType @ if @__type != ""
		@__type = value
		@__scene.addType @ if @__type != ""

		@__type

	mask: (value) =>
		return @__mask if value == nil or @__mask == value

		@__mask.assignTo nil if @__mask != nil
		@__mask = if value then value else nil
		@__mask.assignTo @ if value

		@__mask

	graphic: (value) =>
		return @__graphic if value == nil or @__graphic == value

		value.layer = @__layer if value
		@__graphic = if value then value else nil
		@__graphic

	-- The World object is deprecated for FlashPunk-like compatibility
	-- TODO give a massage about this kept for porting compatibility
	world: (value) =>
		@__scene = value if value != nil
		@__scene

	-- Override this, called when the Entity is added to a Scene.
	added: =>
	-- Override this, called when the Entity is removed from a Scene.
	removed: =>
	-- Updates the Entity.
	update: =>

	-- Renders the Entity. If you override this for special behaviour,
	-- remember to call super.render() to render the Entity's graphic.
	render: =>
		if @__graphic != nil and @__graphic.visable
			if @__graphic.relative
				@__point.x = @x!
				@__point.y = @y!
			else
				@__point.x, @__point.y = 0, 0
				@__camera.x = if @__scene == nil then LP.camera.x else @__scene.camera.x
				@__camera.y = if @__scene == nil then LP.camera.y else @__scene.camera.y
				@__graphic\render (if @__renderTarget != nil then @__renderTarget else LP.buffer), @__point, @__camera

	collide: (type, x, y) =>

	-- Checks for collision against multiple Entity types.
	-- @param	types		An Array or Vector of Entity types to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @return	The first Entity collided with, or null if none were collided.
	collideTypes: (types, x, y) =>

	-- Checks if this Entity collides with a specific Entity.
	-- @param	e		The Entity to collide against.
	-- @param	x		Virtual x position to place this Entity.
	-- @param	y		Virtual y position to place this Entity.
	-- @return	The Entity if they overlap, or null if they don't.
	collideWith: (e, x, y) =>

	-- Checks if this Entity overlaps the specified rectangle.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	rX			X position of the rectangle.
	-- @param	rY			Y position of the rectangle.
	-- @param	rWidth		Width of the rectangle.
	-- @param	rHeight		Height of the rectangle.
	-- @return	If they overlap.
	collideRect: (x, y, rX, rY, rWidth, rHeight) =>

	-- Checks if this Entity overlaps the specified position.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	pX			X position.
	-- @param	pY			Y position.
	-- @return	If the Entity intersects with the position.
	collidePoint: (x, y, pX, pY) =>

	-- Populates an array with all collided Entities of a type.
	-- @param	type		The Entity type to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	array		The Array or Vector object to populate.
	-- @return	The array, populated with all collided Entities.
	collideInto: (type, x, y, array) =>

	-- Populates an array with all collided Entities of multiple types.
	-- @param	types		An array of Entity types to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	array		The Array or Vector object to populate.
	-- @return	The array, populated with all collided Entities.
	collideTypesInto: (types, x, y, array) =>

	-- Adds the graphic to the Entity via a Graphiclist.
	-- @param	g		Graphic to add.
	addGraphic: (g) =>

	-- Sets the Entity's hitbox properties.
	-- @param	width		Width of the hitbox.
	-- @param	height		Height of the hitbox.
	-- @param	originX		X origin of the hitbox.
	-- @param	originY		Y origin of the hitbox.
	setHitbox: (width, height, originX, originY) =>
		@width, @height = width, height
		@originX, @originY = originX, originY

	-- Sets the Entity's hitbox to match that of the provided object.
	-- @param	o		The object defining the hitbox (eg. an Image or Rectangle).
	setHitboxTo: (o) =>

	-- Sets the origin of the Entity.
	-- @param	x		X origin.
	-- @param	y		Y origin.
	setOrigin: (x, y) =>

	-- Center's the Entity's origin (half width & height).
	centerOrigin: =>

	-- Calculates the distance from another Entity.
	-- @param	e				The other Entity.
	-- @param	useHitboxes		If hitboxes should be used to determine the distance. If not, the Entities' x/y positions are used.
	-- @return	The distance.
	distanceFrom: (e, useHitboxes) =>

	-- Calculates the distance from this Entity to the point.
	-- @param	px				X position.
	-- @param	py				Y position.
	-- @param	useHitboxes		If hitboxes should be used to determine the distance. If not, the Entities' x/y positions are used.
	-- @return	The distance.
	distanceToPoint: (px, py, useHitbox) =>

	-- Calculates the distance from this Entity to the rectangle.
	-- @param	rx			X position of the rectangle.
	-- @param	ry			Y position of the rectangle.
	-- @param	rwidth		Width of the rectangle.
	-- @param	rheight		Height of the rectangle.
	-- @return	The distance.
	distanceToRect: (rx, ry, rwidth, rheight) =>

	-- Gets the class name as a string.
	-- @return	A string representing the class name.
	toString: =>

	__tostring: => @toString!

	-- Moves the Entity by the amount, retaining integer values for its x and y.
	-- @param	x			Horizontal offset.
	-- @param	y			Vertical offset.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveBy: (x, y, solidType, sweep) =>

	-- Moves the Entity to the position, retaining integer values for its x and y.
	-- @param	x			X position.
	-- @param	y			Y position.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveTo: (x, y, solidType, sweep) =>

	-- Moves towards the target position, retaining integer values for its x and y.
	-- @param	x			X target.
	-- @param	y			Y target.
	-- @param	amount		Amount to move.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveTowards: (x, y, amount, solidType, sweep) =>

	-- Moves at an angle by a certain amount, retaining integer values for its x and y.
	-- @param	angle		Angle to move at in degrees.
	-- @param	amount		Amount to move.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveAtAngle: (angle, amount, solidType, sweep) =>

	-- When you collide with an Entity on the x-axis with moveTo() or moveBy().
	-- @param	e		The Entity you collided with.
	moveCollideX: (e) =>

	-- When you collide with an Entity on the y-axis with moveTo() or moveBy().
	-- @param	e		The Entity you collided with.
	moveCollideY: (e) =>

	-- Clamps the Entity's hitbox on the x-axis.
	-- @param	left		Left bounds.
	-- @param	right		Right bounds.
	-- @param	padding		Optional padding on the clamp.
	clampHorizontal: (left, right, padding) =>

	-- Clamps the Entity's hitbox on the y axis.
	-- @param	top			Min bounds.
	-- @param	bottom		Max bounds.
	-- @param	padding		Optional padding on the clamp.
	clampVertical: (top, bottom, padding) =>

	-- Center graphic inside bounding rect.
	centerGraphicInRect: =>