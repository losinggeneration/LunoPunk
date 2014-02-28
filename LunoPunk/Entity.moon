require "LunoPunk.graphics.Graphiclist"
require "LunoPunk.LP"
require "LunoPunk.Mask"
require "LunoPunk.Tweener"
require "LunoPunk.utils.moonscript"
require "LunoPunk.utils.Math"

export ^

class Entity extends Tweener
	-- Constructor. Can be usd to place the Entity and assign a graphic and mask.
	-- @param	x			X position to place the Entity.
	-- @param	y			Y position to place the Entity.
	-- @param	graphic		Graphic to assign to the Entity.
	-- @param	mask		Mask to assign to the Entity.
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

		-- The collision type, used for collision checking.
		@__typeNext = nil
		@__typePrev = nil
		@__type = ""
		@name = ""

		@__point = LP.point
		@__camera = LP.point2

		-- Collision information.
		@__hitbox = Mask!
		-- An optional Mask component, used for specialized collision. If this is not assigned, collision checks will use the Entity's hitbox by default.
		@mask mask if mask != nil
		@__moveX, @__moveY = 0, 0
		@__collide_x, @__collide_y = 0, 0

		-- The rendering layer of this Entity. Higher layers are rendered first.
		@__layer = LP.BASELAYER!

		-- Graphical component to render to the screen.
		@graphic graphic if graphic != nil

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

		@__scene\removeRender @
		@__layer = if value then value else nil
		@__scene\addRender @
		@__layer

	type: (value) =>
		return @__type if value == nil

		if @__scene == nil
			@__type = value
			return @__type

		@__scene\removeType(@) if @__type != ""
		@__type = value
		@__scene\addType(@) if @__type != ""

		@__type

	mask: (value) =>
		return @__mask if value == nil or @__mask == value

		@__mask\assignTo(nil) if @__mask != nil
		@__mask = if value then value else nil
		@__mask\assignTo(@) if value

		@__mask

	graphic: (value) =>
		return @__graphic if value == nil or @__graphic == value

		value.layer = @__layer if value
		@__graphic = if value then value else nil
		@__graphic

	scene: (value) =>
		@__scene = value if value != nil and @__scene != value
		@__scene

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
	update: => super!

	-- Renders the Entity. If you override this for special behaviour,
	-- remember to call super.render() to render the Entity's graphic.
	render: =>
		if @__graphic != nil and @__graphic.visible
			if @__graphic.relative
				@__point.x = @x!
				@__point.y = @y!
			else
				@__point.x, @__point.y = 0, 0
				@__camera.x = if @__scene == nil then LP.camera.x else @__scene.camera.x
				@__camera.y = if @__scene == nil then LP.camera.y else @__scene.camera.y

			@__graphic\render @__point, @__camera

	-- Checks for a collision against an Entity type.
	-- @param	type		The Entity type to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @return	The first Entity collided with, or nil if none were collided.
	collide: (type, x, y) =>
		return nil if @__scene == nil
		return nil if not @collidable or @__scene\typeFirst type == nil

		@__collide_x, @__collide_y = @x!, @y!
		@x x
		@y y
		e = @__scene\typeFirst type

		if @__mask == nil
			while e != nil
				if do
						c1 = e.collidable and e != @
						c2 = x - @originX + @width >= e\x! - e.originX
						c3 = y - @originY + @height >= e\y! - e.originY
						c4 = x - @originX <= e\x! - e.originX + e.width
						c5 = y - @originY <= e\y! - e.originY + e.height
						c1 and c2 and c3 and c4 and c5
					if e.__mask == nil or e.__mask\collide @HITBOX
						@x @__collide_x
						@y @__collide_y
						return e

				e = e.__typeNext

			@x @__collide_x
			@y @__collide_y

			return nil

		while e != nil
			if do
					c1 = e.collidable and e != @
					c2 = x - @originX + @width >= e\x! - e.originX
					c3 = y - @originY + @height >= e\y! - e.originY
					c4 = x - @originX <= e\x! - e.originX + e.width
					c5 = y - @originY <= e\y! - e.originY + e.height
					c1 and c2 and c3 and c4 and c5
				if e.__mask\collide (if e.__mask != nil then e.__mask else e.HITBOX)
					@x @__collide_x
					@y @__collide_y
					return e

			e = e.__typeNext

		@x @__collide_x
		@y @__collide_y

		return nil

	-- Checks for collision against multiple Entity types.
	-- @param	types		An Array or Vector of Entity types to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @return	The first Entity collided with, or null if none were collided.
	collideTypes: (types, x, y) =>
		return nil if @__scene == nil

		if type(types) == "string"
			return @collide types, x, y
		else
			if types != nil
				for t in *types
					e = @collide t, x, y
					return e if e != nil

		return nil

	-- Checks if this Entity collides with a specific Entity.
	-- @param	e		The Entity to collide against.
	-- @param	x		Virtual x position to place this Entity.
	-- @param	y		Virtual y position to place this Entity.
	-- @return	The Entity if they overlap, or null if they don't.
	collideWith: (e, x, y) =>
		@__collide_x, @__collide_y = @x!, @y!
		@x x
		@y y

		c = do
			c1 = @collidable and e.collidable
			c2 = x - @originX + @width > e.x - e.originX
			c3 = y - @originY + @height > e.y - e.originY
			c4 = x - @originX < e.x - e.originX + e.width
			c5 = y - @originY < e.y - e.originY + e.height
			c1 and c2 and c3 and c4 and c5
		if c
			if @__mask == nil
				if e.__mask == nil or e.__mask\collide @__hitbox
					@x @__collide_x
					@y @__collide_y
					return e
				@x @__collide_x
				@y @__collide_y
				return nil


			if (if @__mask\collide(e.__mask) != nil then e.__mask else e.__hitbox)
				@x @__collide_x
				@y @__collide_y
				return e

		@x @__collide_x
		@y @__collide_y
		return nil

	-- Checks if this Entity overlaps the specified rectangle.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	rX			X position of the rectangle.
	-- @param	rY			Y position of the rectangle.
	-- @param	rWidth		Width of the rectangle.
	-- @param	rHeight		Height of the rectangle.
	-- @return	If they overlap.
	collideRect: (x, y, rX, rY, rWidth, rHeight) =>
		c = do
			c1 = x - @originX + @width >= rX
			c2 = y - @originY + @height >= rY
			c3 = x - @originX <= rX + rWidth
			c4 = y - @originY <= rY + rHeight
			c1 and c2 and c3 and c4
		if c
			return true if @__mask == nil
			@__collide_x, @__collide_y = @x!, @y!
			@x x
			@y y
			LP.entity.x = rX
			LP.entity.y = rY
			LP.entity.width = rWidth
			LP.entity.height = rHeight
			if @__mask\collide LP.entity.__hitbox
				@x @__collide_x
				@y @__collide_y
				return true

			@x @__collide_x
			@y @__collide_y
			return false

		return false

	-- Checks if this Entity overlaps the specified position.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	pX			X position.
	-- @param	pY			Y position.
	-- @return	If the Entity intersects with the position.
	collidePoint: (x, y, pX, pY) =>
		c = do
			c1 = pX >= x - @originX
			c2 = pY >= y - @originY
			c3 = pX < x - @originX + @width
			c4 = pY < y - @originY + height
		if c
			return true if @__mask == nil
			@__collide_x, @__collide_y = @x!, @y!
			@x x
			@y y
			LP.entity.x, LP.entity.y = pX, pY
			LP.entity.width, LP.entity.height = 1, 1
			if @__mask\collide LP.entity.__hitbox
				@x @__collide_x
				@y @__collide_y
				return true

			@x @__collide_x
			@y @__collide_y
			return false

		return false

	-- Populates an array with all collided Entities of a type.
	-- @param	type		The Entity type to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	array		The Array or Vector object to populate.
	-- @return	The array, populated with all collided Entities.
	collideInto: (type, x, y, array) =>
		return if @__scene == nil

		e = @__scene.__typeFirst\get type
		return if not @collidable or e == nil

		@__collide_x, @__collide_y = @x!, @y!
		@x x
		@y y

		if @__mask == nil
			while e != nil
				c = do
					c1 = e.collidable and e != @
					c2 = x - @originX + @width > e.x - e.originX
					c3 = y - @originY + @height > e.y - e.originY
					c4 = x - @originX < e.x - e.originX + e.width
					c5 = y - @originY < e.y - e.originY + e.height
					c1 and c2 and c3 and c4 and c5
				if c
					array[#array+1] = e if e__mask == nil or e.__mask\collide @__hitbox

				e = e.__typeNext

			@x @__collide_x
			@y @__collide_y
			return

		while e != nil
			c = do
				c1 = e.collidable and e != @
				c2 = x - @originX + @width > e.x - e.originX
				c3 = y - @originY + @height > e.y - e.originY
				c4 = x - @originX < e.x - e.originX + e.width
				c5 = y - @originY < e.y - e.originY + e.height
				c1 and c2 and c3 and c4 and c5
			if c
				array[#array+1] = e if (if @__mask\collide(e.__mask) != nil then e.__mask else e.__hitbox)

			e = e.__typeNext

		@x @__collide_x
		@y @__collide_y
		return

	-- Populates an array with all collided Entities of multiple types.
	-- @param	types		An array of Entity types to check for.
	-- @param	x			Virtual x position to place this Entity.
	-- @param	y			Virtual y position to place this Entity.
	-- @param	array		The Array or Vector object to populate.
	-- @return	The array, populated with all collided Entities.
	collideTypesInto: (types, x, y, array) =>
		return if @__scene == nil
		for t in *types
			@collideInto t, x, y, array

	-- Adds the graphic to the Entity via a Graphiclist.
	-- @param	g		Graphic to add.
	addGraphic: (g) =>
		g.layer = @__layer
		if @graphic! == nil
			@graphic g
		else if moon_type(g) == Graphiclist
			@graphic!\add g
		else
			list = Graphiclist!
			list\add graphic if @graphic! != nil
			list\add g
			@graphic list
			list\setEntity @

		g

	-- Sets the Entity's hitbox properties.
	-- @param	width		Width of the hitbox.
	-- @param	height		Height of the hitbox.
	-- @param	originX		X origin of the hitbox.
	-- @param	originY		Y origin of the hitbox.
	setHitbox: (width, height, originX = 0, originY = 0) =>
		@width, @height = width, height
		@originX, @originY = originX, originY

	-- Sets the Entity's hitbox to match that of the provided object.
	-- @param	o		The object defining the hitbox (eg. an Image or Rectangle).
	setHitboxTo: (o) =>
		@width, @height = o.width, o.height

		if o.originX and o.originY
			@originX, @originY = o.originX, o.originY
		else
			@originX, @originY = o.x, o.y
			@originX, @originY = -@originX, -@originY

	-- Sets the origin of the Entity.
	-- @param	x		X origin.
	-- @param	y		Y origin.
	setOrigin: (x, y) => @originX, @originY = x, y

	-- Center's the Entity's origin (half width & height).
	centerOrigin: => @originX, @originY = @halfWidth!, @halfHeight!

	-- Calculates the distance from another Entity.
	-- @param	e				The other Entity.
	-- @param	useHitboxes		If hitboxes should be used to determine the distance. If not, the Entities' x/y positions are used.
	-- @return	The distance.
	distanceFrom: (e, useHitboxes) =>
		return math.sqrt (@x! - e.x) * (@x! - e.x) + (@y! - e.y) * (@y - e.y) if not useHitboxes
		LP.distanceRects @x! - @originX, @y! - @originY, @width, @height, e.x - e.originX, e.y - e.originY, e.width, e.height

	-- Calculates the distance from this Entity to the point.
	-- @param	px				X position.
	-- @param	py				Y position.
	-- @param	useHitboxes		If hitboxes should be used to determine the distance. If not, the Entities' x/y positions are used.
	-- @return	The distance.
	distanceToPoint: (px, py, useHitbox) =>
		return math.sqrt (@x! - px) * (@x! - px) + (@y! - py) * (@y! - py) if not useHitbox
		LP.distanceRectPoint px, py, @x! - @originX, @y! - @originY, @width, @height

	-- Calculates the distance from this Entity to the rectangle.
	-- @param	rx			X position of the rectangle.
	-- @param	ry			Y position of the rectangle.
	-- @param	rwidth		Width of the rectangle.
	-- @param	rheight		Height of the rectangle.
	-- @return	The distance.
	distanceToRect: (rx, ry, rwidth, rheight) =>
		LP.distanceRects rx, ry, rwidth, rheight, @x! - @originX, @y! - @originY, @width, @height

	-- Gets the class name as a string.
	-- @return	A string representing the class name.
	toString: => @@.__name

	__tostring: => @toString!

	-- Moves the Entity by the amount, retaining integer values for its x and y.
	-- @param	x			Horizontal offset.
	-- @param	y			Vertical offset.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveBy: (x, y, solidType, sweep) =>
		@__moveX += x
		@__moveY += y
		x, y = Math.round(@__moveX), Math.round(@__moveY)
		@__moveX -= x
		@__moveY -= y

		if solidType != nil
			if x != 0
				if @collidable and (sweep or @collideTypes(solidType, @x! + x, @y!) != nil)
					sign = if x > 0 then 1 else -1
					while x != 0
						e = @collideTypes solidType, @x! + sign, @y!
						if e != nil
							break if @moveCollideX e
							@x @x! + sign
						else
							@x @x! + sign

						x -= sign
				else
					@x @x! + x

			if y != 0
				if @collidable and (sweep or @collideTypes(solidType, @x!, @y! + y) != nil)
					sign = if y > 0 then 1 else -1
					while y != 0
						e = @collideTypes solidType, @x!, @y! + sign
						if e != nil
							break if @moveCollideY e
							@y @y! + sign
						else
							@y @y! + sign

						y -= sign
		else
			@x @x! + x
			@y @y! + y

	-- Moves the Entity to the position, retaining integer values for its x and y.
	-- @param	x			X position.
	-- @param	y			Y position.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveTo: (x, y, solidType, sweep) => moveBy x - @x!, y - @y!, solidType, sweep

	-- Moves towards the target position, retaining integer values for its x and y.
	-- @param	x			X target.
	-- @param	y			Y target.
	-- @param	amount		Amount to move.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveTowards: (x, y, amount, solidType, sweep) =>
		@__point.x, @__point.y = x - @x!, y - @y!
		@__point.normalize amount if @__point.x * @__point.x + @__point.y * @__point.y > amount * amount
		@moveBy @__point.x, @__point.y, solidType, sweep

	-- Moves at an angle by a certain amount, retaining integer values for its x and y.
	-- @param	angle		Angle to move at in degrees.
	-- @param	amount		Amount to move.
	-- @param	solidType	An optional collision type to stop flush against upon collision.
	-- @param	sweep		If sweeping should be used (prevents fast-moving objects from going through solidType).
	moveAtAngle: (angle, amount, solidType, sweep) =>
		angle *= LP.RAD!
		@moveBy math.cos(angle) * amount, math.sin(angle) * amount, solidType, sweep

	-- When you collide with an Entity on the x-axis with moveTo() or moveBy().
	-- @param	e		The Entity you collided with.
	moveCollideX: (e) => true

	-- When you collide with an Entity on the y-axis with moveTo() or moveBy().
	-- @param	e		The Entity you collided with.
	moveCollideY: (e) => true

	-- Clamps the Entity's hitbox on the x-axis.
	-- @param	left		Left bounds.
	-- @param	right		Right bounds.
	-- @param	padding		Optional padding on the clamp.
	clampHorizontal: (left, right, padding) =>
		@x left + @originX + padding if @x! - @originX < left + padding
		@x right - @width + @originX - padding if @x! - @originX + @width > right - padding

	-- Clamps the Entity's hitbox on the y axis.
	-- @param	top			Min bounds.
	-- @param	bottom		Max bounds.
	-- @param	padding		Optional padding on the clamp.
	clampVertical: (top, bottom, padding) =>
		@y top + @originY + padding if @y! - @originY < top + padding
		@y bottom - @height + @originX - padding if @y! - @originY + @height > bottom - padding

	-- Center graphic inside bounding rect.
	centerGraphicInRect: =>
		@__graphic.x, @__graphic.y = @halfWidth!, @halfHeight! if @__graphic != nil