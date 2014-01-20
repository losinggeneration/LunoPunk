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

		if LP.renderMode == RenderMode.Hardware
			clearSprites!
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
	addGraphic: (graphic, layer = LP.BASELAYER, x = 0, y = 0) =>
		e = Entity x, y, graphic

		e.layer = layer if layer != LP.BASELAYER
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

	bringToFront: (e) =>
	sendToBack: (e) =>
	bringForward: (e) =>
	sendBackward: (e) =>
	isAtFront: (e) =>
	isAtBack: (e) =>
	collideRect: (type, rX, rY, rWidth, rHeight) =>
	collidePoint: (type, pX, pY) =>
	collideLine: (type, fromX, fromY, toX, toY, precision, p) =>
	collideRectInto: (type, rX, rY, rWidth, rHeight, into) =>
	collideCircleInto: (type, circleX, circleY, radius, into) =>
	collidePointInt: (type, pX, pY, into) =>
	nearestToRect: (type, x, y, width, height) =>
	nearestToEntity: (type, e, useHitboxes) =>
	nearestToClass: (type, e, classType, useHitboxes) =>
	nearestToPoint: (type, x, y, useHitboxes) =>
	count: => @__count --TODO
	typeCount: (type) =>
	classCount: (c) =>
	layerCount: (layer) =>
	first: => @__updatedFirst --TODO
	layers: => @__layers --TODO
	typeFirst: (type) =>
	classFirst: (c) =>
	layerFirst: (layer) =>
	layerLast: (layer) =>
	getSpriteByLayer: (layer) =>
	getFarthest: => @__farthest --TODO
	getNearest: => @__nearest --TODO
	getLayerFarthest: => @__layerFarthest --TODO
	getLayerNearest: => @__layerNearest --TODO
	getUniqueTypes: => @__uniqueTypes --TODO
	getType: (type, into) =>
	getClass: (c, into) =>
	getLayer: (layer, into) =>
	getAll: (into) =>
	getInstance: (name) =>
	updateLists: (shouldAdd) =>
