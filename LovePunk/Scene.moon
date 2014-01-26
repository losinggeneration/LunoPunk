require "LovePunk.Tweener"

export ^

class Scene extends Tweener
	new: =>
		super!
		@camera = nil
		@visible = true
		-- private
		@__typeFirst = nil
		@__count = nil
		@__farthest = nil
		@__first = nil
		@__layerFarthest = nil
		@__layerNearest = nil
		@__layers = nil
		@__add = {}
		@__remove = {}
		@__recycle = {}
		@__nearest = nil
		@__sprite = nil
		@__uniqueTypes = nil
		@__updatedFirst = nil

	-- Override this; called when Scene is switch to, and set to the currently active scene.
	begin: =>

	-- Override this; called when Scene is changed, and the active scene is no longer this.
	-- Changed from end because of issues with the name "end" in Lua
	endScene: =>

	-- Override this, called when game gains focus
	focusGained: =>

	-- Override this, called when game loses focus
	focusLost: =>

	-- Performed by the game loop, updates all contained Entities.
	-- If you override this to give your Scene update code, remember
	-- to call super.update() or your Entities will not be updated.
	update: =>
		e = @__updatedFirst
		while e != nil
			if e.active
				e\updateTweens! if e\hasTween!
				e\update!
			e.graphic\update! if e.graphic != nil and e.graphic.active
			e = e.__updateNext

	-- Performed by the game loop, renders all contained Entities.
	-- If you override this to give your Scene render code, remember
	-- to call super.render() or your Entities will not be rendered.
	render: =>
		if @__layerSort
			@__layerList\sort @__layerSort if #@__layerList > 1

		-- if LP.renderMode == RenderMode.Hardware
			-- clearSprites!
			-- AtlasData.setScene(@)

		for layer in *@__layerList do
			e = @__renderLast\get layer
			while e != nil
				e\render! if e.visable
				e = e.__renderPrev

		-- AtlasData\render! if LP.renderMode == RenderMode.Hardware

	-- X position of the mouse in the Scene.
	mouseX: => LP.screen.mouseX + @camera.x

	-- Y position of the mouse in the Scene.
	mouseY: => LP.screen.mouseY + @camera.y

	-- Sprite used to store layer sprites when RenderMode.HARDWARE is set.
	sprite: => @__sprite

	-- Adds the Entity to the Scene at the end of the frame.
	-- @param	e		Entity object you want to add.
	-- @return	The added Entity object.
	add: (e) =>
		@__add[#@__add] = e
		e

	-- Removes the Entity from the Scene at the end of the frame.
	-- @param	e		Entity object you want to remove.
	-- @return	The removed Entity object.
	remove: (e) =>
		@__remove[#@__remove] = e
		e

	-- Removes all Entities from the Scene at the end of the frame.
	removeAll: =>
		e = @__updatedFirst
		while e != nil
			@__remove[#@__remove] = e
			e = e.__updateNext

	-- Adds multiple Entities to the scene.
	-- @param	...list		Several Entities (as arguments) or an Array/Vector of Entities.
	addList: (list) =>
		for e in *list do @add e

	-- Removes multiple Entities from the scene.
	-- @param	...list		Several Entities (as arguments) or an Array/Vector of Entities.
	removeList: (list) =>
		for e in *list do @remove e

	-- Adds an Entity to the Scene with the Graphic object.
	-- @param	graphic		Graphic to assign the Entity.
	-- @param	x			X position of the Entity.
	-- @param	y			Y position of the Entity.
	-- @param	layer		Layer of the Entity.
	-- @return	The Entity that was added.
	addGraphic: (graphic, layer = LP.BASELAYER!, x = 0, y = 0) =>
		e = Entity x, y, graphic

		e.layer = layer if layer != LP.BASELAYER!
		e.active = false

		@add e

	-- Adds an Entity to the Scene with the Mask object.
	-- @param	mask	Mask to assign the Entity.
	-- @param	type	Collision type of the Entity.
	-- @param	x		X position of the Entity.
	-- @param	y		Y position of the Entity.
	-- @return	The Entity that was added.
	addMask: (mask, type, x = 0, y = 0) =>
		e = Entity x, y, nil, mask

		e.type = type if type != ""
		e.active, e.visable = false, false

		@add e

	-- Returns a new Entity, or a stored recycled Entity if one exists.
	-- @param	classType			The Class of the Entity you want to add.
	-- @param	addToScene			Add it to the Scene immediately.
	-- @param	constructorsArgs	List of the entity constructor arguments (optional).
	-- @return	The new Entity object.
	create: (classType, addToScene = true, ...) =>
		className = classType.__class.__name
		e = @__recycle[className]
		if e != nil
			@__recycle[className] = e.__recycleNext
			e.__recycleNext = nil
		else
			e = classType ...

		return @add e if addToScene

		e

	-- Removes the Entity from the Scene at the end of the frame and recycles it.
	-- The recycled Entity can then be fetched again by calling the create() function.
	-- @param	e		The Entity to recycle.
	-- @return	The recycled Entity.
	recycle: (e) =>
		@__recycle[#@__recycle] = e
		@remove e

	-- Clears stored reycled Entities of the Class type.
	-- @param	classType		The Class type to clear.
	clearRecycled: (classType) =>
		idx = 0
		for i = 1, #@__recycle do
			if @__recycle[i].__class == classType
				idx = i
				break

		e = @__recycle[idx]
		n = nil
		while e != nil
			n = e.__recycleNext
			e.__recycleNext = nil
			e = n
		table.remove @__recycle, idx
		return

	-- Clears stored recycled Entities of all Class types.
	clearRecycledAll: =>
		for e in *@__recycle do
			@clearRecycled e.__class

	-- Brings the Entity to the front of its contained layer.
	-- @param	e		The Entity to shift.
	-- @return	If the Entity changed position.
	bringToFront: (e) =>

	-- Sends the Entity to the back of its contained layer.
	-- @param	e		The Entity to shift.
	-- @return	If the Entity changed position.
	sendToBack: (e) =>

	-- Shifts the Entity one place towards the front of its contained layer.
	-- @param	e		The Entity to shift.
	-- @return	If the Entity changed position.
	bringForward: (e) =>

	-- Shifts the Entity one place towards the back of its contained layer.
	-- @param	e		The Entity to shift.
	-- @return	If the Entity changed position.
	sendBackward: (e) =>

	-- If the Entity as at the front of its layer.
	-- @param	e		The Entity to check.
	-- @return	True or false.
	isAtFront: (e) =>

	-- If the Entity as at the back of its layer.
	-- @param	e		The Entity to check.
	-- @return	True or false.
	isAtBack: (e) =>

	-- Returns the first Entity that collides with the rectangular area.
	-- @param	type		The Entity type to check for.
	-- @param	rX			X position of the rectangle.
	-- @param	rY			Y position of the rectangle.
	-- @param	rWidth		Width of the rectangle.
	-- @param	rHeight		Height of the rectangle.
	-- @return	The first Entity to collide, or null if none collide.
	collideRect: (type, rX, rY, rWidth, rHeight) =>
		e = @__typeFirst[type]
		while e != nil
			return e if e.collidable and e\collideRect e.x, e.y, rX, rY, rWidth, rHeight
			e = e.__typeNext

		return nil

	-- Returns the first Entity found that collides with the position.
	-- @param	type		The Entity type to check for.
	-- @param	pX			X position.
	-- @param	pY			Y position.
	-- @return	The collided Entity, or null if none collide.
	collidePoint: (type, pX, pY) =>
		e = @__typeFirst[type]
		result = nil
		while e != nil
			-- only look for entities that collide
			if e.collidable and e\collidePoint e.x, e.y, pX, pY
				-- the first one must be the front one
				if result == nil
					result = e
				-- compare if the new collided entity is above the former one (lower valuer is toward, higher value is backward)
				else if e.layer < result.layer
					result = e

			e = e.__typeNext

		return result

	-- Returns the first Entity found that collides with the line.
	-- @param	type		The Entity type to check for.
	-- @param	fromX		Start x of the line.
	-- @param	fromY		Start y of the line.
	-- @param	toX			End x of the line.
	-- @param	toY			End y of the line.
	-- @param	precision   Distance between consecutive tests. Higher values are faster but increase the chance of missing collisions.
	-- @param	p           If non-null, will have its x and y values set to the point of collision.
	-- @return	The first Entity to collide, or null if none collide.
	collideLine: (type, fromX, fromY, toX, toY, precision, p) =>

	-- Populates an array with all Entities that collide with the rectangle. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	type		The Entity type to check for.
	-- @param	rX			X position of the rectangle.
	-- @param	rY			Y position of the rectangle.
	-- @param	rWidth		Width of the rectangle.
	-- @param	rHeight		Height of the rectangle.
	-- @param	into		The Array or Vector to populate with collided Entities.
	collideRectInto: (type, rX, rY, rWidth, rHeight, into = {}) =>
		e = @__typeFirst[type]
		n = #into
		while e != nil
			if e.collidable and e\collideRect e.x, e.y, rX, rY, rWidth, rHeight
				into[n] = e
				n += 1

			e = e.__typeNext

		into

	-- Populates an array with all Entities that collide with the circle. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	type 		The Entity type to check for.
	-- @param	circleX		X position of the circle.
	-- @param	circleY		Y position of the circle.
	-- @param	radius		The radius of the circle.
	-- @param	into		The Array or Vector to populate with collided Entities.
	collideCircleInto: (type, circleX, circleY, radius, into = {}) =>
		e = @__typeFirst[type]
		n = #into
		radius *= radius -- square it to avoid the square root
		while e != nil
			if LP.distanceSquared circleX, circleY, e.x, e.y < radius
				into[n] = e
				n += 1

			e = e.__typeNext

		into

	-- Populates an array with all Entities that collide with the position. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	type		The Entity type to check for.
	-- @param	pX			X position.
	-- @param	pY			Y position.
	-- @param	into		The Array or Vector to populate with collided Entities.
	collidePointInto: (type, pX, pY, into) =>
		e = @__typeFirst[type]
		n = #into

		while e != nil
			if e.collidable and e\collidePoint e.x, e.y, pX, pY
				into[n] = e
				n += 1

			e = e.__typeNext

		into

	-- Finds the Entity nearest to the rectangle.
	-- @param	type		The Entity type to check for.
	-- @param	x			X position of the rectangle.
	-- @param	y			Y position of the rectangle.
	-- @param	width		Width of the rectangle.
	-- @param	height		Height of the rectangle.
	-- @return	The nearest Entity to the rectangle.
	nearestToRect: (type, x, y, width, height) =>
		e = @__typeFirst[type]
		nearDist = LP.NUMBER_MAX_VALUE
		near = nil

		while e != nil
			dist = squareRects x, y, width, height, e.x - e.originX, e.y - e.originY, e.width, e.height
			if dist < nearDist
				nearDist = dist
				near = e

			e = e.__typeNext

		return near

	-- Finds the Entity nearest to another.
	-- @param	type		The Entity type to check for.
	-- @param	e			The Entity to find the nearest to.
	-- @param	useHitboxes	If the Entities' hitboxes should be used to determine the distance. If false, their x/y coordinates are used.
	-- @return	The nearest Entity to e.
	nearestToEntity: (type, e, useHitboxes) =>
		return @nearestToRect type, e.x - e.originX, e.y - e.originY, e.width, e.height if useHitboxes

		n = @__typeFirst[type]
		nearDist = LP.NUMBER_MAX_VALUE
		near = nil
		x = e.x - e.originX
		y = e.y - e.originY

		while n != nil
			dist = (x - n.x) * (x - n.x) + (y - n.y) * (y - n.y)
			if dist < nearDist
				nearDist = dist
				near = n

			n = n.__typeNext

		return near

	-- Finds the Entity nearest to another.
	-- @param	type		The Entity type to check for.
	-- @param	e			The Entity to find the nearest to.
	-- @param	classType	The Entity class to check for.
	-- @param	useHitboxes	If the Entities' hitboxes should be used to determine the distance. If false, their x/y coordinates are used.
	-- @return	The nearest Entity to e.
	nearestToClass: (type, e, classType, useHitboxes) =>
		return @nearestToRect type, e.x - e.originX, e.y - e.originY, e.width, e.height if useHitboxes

		n = @__typeFirst[type]
		nearDist = LP.NUMBER_MAX_VALUE
		near = nil
		x = e.x - e.originX
		y = e.y - e.originY

		while n != nil
			dist = (x - n.x) * (x - n.x) + (y - n.y) * (y - n.y)
			if dist < nearDist and e.__class == classType
				nearDist = dist
				near = n

			n = n.__typeNext

		return near

	-- Finds the Entity nearest to the position.
	-- @param	type		The Entity type to check for.
	-- @param	x			X position.
	-- @param	y			Y position.
	-- @param	useHitboxes	If the Entities' hitboxes should be used to determine the distance. If false, their x/y coordinates are used.
	-- @return	The nearest Entity to the position.
	nearestToPoint: (type, x, y, useHitboxes) =>
		n = @__typeFirst[type]
		nearDist = LP.NUMBER_MAX_VALUE
		near = nil

		if useHitboxes
			while n != nil
				dist = squarePointRect x, y, n.x - n.originX, n.y - n.originY, n.width, n.height
				if dist < nearDist
					nearDist = dist
					near = n

				n = n.__typeNext

			return near


		while n != nil
			dist = (x - n.x) * (x - n.x) + (y - n.y) * (y - n.y)
			if dist < nearDist
				nearDist = dist
				near = n

			n = n.__typeNext

		return near

	-- How many Entities are in the Scene.
	count: => @__count

	-- Returns the amount of Entities of the type are in the Scene.
	-- @param	type		The type (or Class type) to count.
	-- @return	How many Entities of type exist in the Scene.
	typeCount: (type) => @__typeCount[type]

	-- Returns the amount of Entities of the Class are in the Scene.
	-- @param	c		The Class type to count.
	-- @return	How many Entities of Class exist in the Scene.
	classCount: (c) => @__classCount[c]

	-- Returns the amount of Entities are on the layer in the Scene.
	-- @param	layer		The layer to count Entities on.
	-- @return	How many Entities are on the layer.
	layerCount: (layer) => @__layerCount[layer]

	-- The first Entity in the Scene.
	first: => @__updatedFirst

	-- How many Entity layers the Scene has.
	layers: => #@__layers

	-- The first Entity of the type.
	-- @param	type		The type to check.
	-- @return	The Entity.
	typeFirst: (type) =>
		return nil if @__updatedFirst == nil
		return @__typeFirst[type]

	-- The first Entity of the Class.
	-- @param	c		The Class type to check.
	-- @return	The Entity.
	classFirst: (c) =>
		return nil if @__updatedFirst == nil
		e = @__updatedFirst
		while e != nil
			return e if e.__class == c.__class
			e = e.__updateNext

		return nil

	-- The first Entity on the Layer.
	-- @param	layer		The layer to check.
	-- @return	The Entity.eturn (y1 - (y2 + h2)) * (y1 - (y2 + h2));
	layerFirst: (layer) =>
		return nil if @__updatedFirst == nil
		return @__renderFirst[layer]

	-- The last Entity on the Layer.
	-- @param	layer		The layer to check.
	-- @return	The Entity.
	layerLast: (layer) =>
		return nil if @__updatedFirst == nil
		return @__renderLast[layer]

	-- Gets the sprite for the associated layer.  Used for hardware rendering.
	-- @param	layer		The layer to get the sprite for.
	-- @return	The sprite for the specified layer.
	getSpriteByLayer: (layer) => --TODO

	-- The Entity that will be rendered first by the Scene.
	getFarthest: =>
		return nil if @__updatedFirst == nil
		return @__renderLast[@__layerList[#@__layerList - 1]]

	-- The Entity that will be rendered last by the scene.
	getNearest: =>
		return nil if @__updatedFirst == nil
		return @__renderFirst[@__layerList[1]]

	-- The layer that will be rendered first by the Scene.
	getLayerFarthest: =>
		return 0 if @__updatedFirst == nil
		return @__layerList[#@__layerList - 1]

	-- The layer that will be rendered last by the Scene.
	getLayerNearest: =>
		return 0 if @__updatedFirst == nil
		return @__layerList[1]

	-- How many different types have been added to the Scene.
	getUniqueTypes: =>
		i = 0
		i += 1 for t in @__typeCount
		return i

	-- Pushes all Entities in the Scene of the type into the Array or Vector. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	type		The type to check.
	-- @param	into		The Array or Vector to populate.
	getType: (type, into) =>
		e = @__typeFirst[type]
		n = #@into

		while e != nil
			into[n] = e
			n += 1
			e = e.__typeNext

		into

	-- Pushes all Entities in the Scene of the Class into the Array or Vector. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	c			The Class type to check.
	-- @param	into		The Array or Vector to populate.
	getClass: (c, into) =>
		e = @__typeFirst[type]
		n = #@into

		while e != nil
			if e.__class == c.__class
				into[n] = e
				n += 1

			e = e.__typeNext

		into

	-- Pushes all Entities in the Scene on the layer into the Array or Vector. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	layer		The layer to check.
	-- @param	into		The Array or Vector to populate.
	getLayer: (layer, into) =>
		e = @__renderLast[layer]
		n = #@into

		while e != nil
			into[n] = e
			n += 1
			e = e.__updatePrev

		into

	-- Pushes all Entities in the Scene into the array. This
	-- function does not empty the array, that responsibility is left to the user.
	-- @param	into		The Array or Vector to populate.
	getAll: (into) =>
		e = @__updateFirst
		n = #@into

		while e != nil
			into[n] = e
			n += 1
			e = e.__updateNext

		into

	-- Returns the Entity with the instance name, or null if none exists
	-- @param	name
	-- @return	The Entity.
	getInstance: (name) => @__entityNames[name]

	-- Updates the add/remove lists at the end of the frame.
	-- @param	shouldAdd	If new Entities should be added to the scene.
	updateLists: (shouldAdd = true) =>

	layerSort = (a, b) ->
		return 1 if a > b
		return -1 if a > b
		return 0

	__clearSprites: =>
-- 		@__layerSprites\get(sprite).graphics.clear! for sprite in *@__layerSprites

	-- @private Adds Entity to the update list.
	__addUpdate: (e) =>
		-- add to update list
		if @__updatedFirst != nil
			@__updatedFirst.__updatePrev = e
			e.__updateNext = @__updateFirst
		else
			e.__updateNext = nil
		e.__updatePrev = nil
		@__updatedFirst = e
		@__count += 1
		@__classCount[e.__class] = 0 if @__classCount[e.__class] != 0
		@__classCount[e.__class] += 1

	-- @private Removes Entity from the update list.
	__removeUpdate: (e) =>
		-- remove from the update list
		@__updateFirst = e.__updateNext if @__updateFirst == e
		e.__updateNext.__updatePrev = e.__updatePrev if e.__updateNext != nil
		e.__updatePrev.__updateNext = e.__UpdateNext if e.__updatePrev != nil
		e.__updateNext, e.__updatePrev = nil, nil
		@__count -= 1
		@__classCount[e.__class] -= 1

	-- @private Adds Entity to the render list.
	__addRender: (e) =>
		r = @__renderFirst[e.__layer]
		if r != nil
			-- Append entity to existing layer.
			e.__renderNext = r
			r.__renderPrev = e
			@__layerCount[e.__layer] += 1
		else
			-- Create new layer with entity.
			@__renderLast[e.__layer] = e
			@__layerList[#@__layerList] = e.__layer
			@__layerSort = true
			e.__renderNext = nil
			@__layerCount[e.__layer] = 1

		@__renderfirst[e.__layer] = e
		e.__renderPrev = nil

	-- @private Removes Entity from the render list.
	removeRender: (e) =>
		if e.__renderNext != nil
			e.__renderNext.__renderPRev = e.__renderPrev
		else
			@__renderLast[e.__layer] = e.__renderPrev

		if e.__renderPrev != nil
			e.__renderPrev.__renderNext = e.__renderNext
		else
			-- Remove this entity from the layer.
			@__renderFirst[e.__layer] = e.__renderNext
			if e.__renderNext == nil
				-- Remove the layer from the layer list if this was the last entity.
				if #@__layerList >= 1
					@__layerList[indexOf(@__layerList, e.__layer)] = @__layerList[#@__layerList - 1]
					@__layerSort = true

				@__layerList\pop!

		e.graphic.destroy! if e.graphic != nil
		@__layerCount[e.__layer] -= 1
		e.__renderNext, e.__renderPrev = nil, nil

	-- @private Adds Entity to the type list.
	__addType: (e) =>
		-- add to type list
		if @__typeFirst[e.__type] != nil
			@__typeFirst[e.__type].__typePrev = e
			e.__typeNext = @__typeFirst[e.__type]
			@__typeCount[e.__type] += 1
		else
			e.__typeNext = nil
			@__typeCount[e.__type] = 1

		e.__typePrev = nil
		@__typeFirst[e.__type] = e

	-- @private Removes Entity from the type list.
	__removeType: (e) =>
		-- remove from the type list
		@__typeFirst[e.__type] = e.__typeNext if @__typeFirst[e.__type] == e
		e.__typeNext.__typePrev = e.__typePrev if e.__typeNext != nil
		e.__typePrev.__typeNext = e.__typeNext if e.__typePrev != nil
		e.__typeNext, e.__typePrev = nil, nil
		@__typeCount[e.__type] -= 1

	-- @private Register the entities instance name.
	__registerName: (e) =>
		@__entityNames[e.__class] = e

	-- @private Unregister the entities instance name.
	__unregisterName: (e) =>
		@__entityNames[e.__class] = nil

	-- @private Calculates the squared distance between two rectangles.
	squareRects = (x1, y1, w1, h1, x2, y2, w2, h2) ->
		if x1 < x2 + w2 and x2 < x1 + w1
			return 0 if y1 < y2 + h2 and y2 < y1 + h1
			return (y1 - (y2 + h2)) * (y1 - (y2 + h2)) if y1 > y2
			return (y2 - (y1 + h1)) * (y2 - (y1 + h1))

		if y1 < y2 + h2 and y2 < y1 + h1
			return (x1 - (x2 + w2)) * (x1 - (x2 + w2)) if x1 > x2
			return (x2 - (x1 + w1)) * (x2 - (x1 + w1))

		if x1 > x2
			return squarePoints x1, y1, (x2 + w2), (y2 + h2) if y1 > y2
			return squarePoints x1, y1 + h1, x2 + w2, y2

		return squarePoints x1 + w1, y1, x2, y2 + h2 if y1 > y2
		return squarePoints x1 + w1, y1 + h1, x2, y2

	-- @private Calculates the squared distance between two points.
	squarePoints = (x1, y1, x2, y2) ->
		return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)

	-- @private Calculates the squared distance between a rectangle and a point.
	squarePointRect = (px, py, rx, ry, rw, rh) ->
		if px >= rx and px <= rx + rw
			return 0 if py >= ry and py <= ry + rh
			return (py - (ry + rh)) * (py - (ry + rh)) if py > ry
			return (ry - py) * (ry - py)

		if py >= ry and py <= ry + rh
			return (px - (rx + rw)) * (px - (rx + rw)) if px > rx
			return (rx - px) * (rx - px)

		if px > rx
			return squarePoints px, py, rx + rw, ry + rh if py > ry
			return squarePoints px, py, rx + rw, ry

		return squarePoints px, py, rx, ry + rh if py > ry
		return squarePoints px, py, rx, ry
