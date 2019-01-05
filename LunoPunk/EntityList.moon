import Entity from require 'LunoPunk.Entity'

-- A group of entities which can be added to or removed from the Scene and
-- moved together. Also supports object pooling.
-- TODO fix all of EntityList
class EntityList extends Entity
	new: =>
		@entities = {} -- Array
		@__recycled = {} -- List
		super!

	count: => #@entities

	-- Add an Entity to this EntityList and its Scene.
	-- @param	entity		The Entity to be added.
	-- @param	index		Position to insert the Entity, default last.
	-- @return	The Entity.
	add: (entity, index = -1) =>
		if index < 0
			entities.push(entity)
		else
			entities.insert(index, entity)
		if type != "" entity.type = type
		if scene != nil
			@__scene\add entity
		entity.parent = @
		entity.layer = layer
		entity.camera = camera
		entity

	-- Remove an Entity from this EntityList and its Scene.
	-- @param	entity		The Entity to be removed.
	-- @return	The Entity.
	remove: (entity) =>
		entities.remove(entity)
		if (scene != nil)
			scene.remove(entity)
		entity.parent = nil
		entity

	pop: =>
		entity = @entities.pop()
		if entity != nil
			if @__scene != nil
				@__scene\remove entity
			entity.parent = nil
		entity

	-- Call a function on all Entities in an EntityList.
	apply: (f) =>
		f(entity) for entity in *@entities

	-- Call a function on all Entities in an EntityList and return its value.
	map: (f) =>
		{f(entity) for entity in *@entities}

	added: =>
		super!
		if @__scene != nil
			for entity in @entities
				@__scene\add entity

	removed: =>
		if @__scene != nil
			for entity in entities
				@__scene\remove entity
		super!

	setType: (value) =>
		if value != ""
			entity.type = value for entity in *@entities
		@__type = value
		value

	setLayer: (value) =>
		originalLayer = layer
		value = super(value)
		for entity in *@entities
			entity.layer = entity.layer - originalLayer + value
		value

	setCamera: (value) =>
		entity.camera = value for entity in *@entities
		camera = value
		camera

	-- Returns a new Entity, or a stored recycled Entity if one exists.
	-- @param	addToScene			Add it to the Scene immediately.
	-- @param	constructorArgs		List of the entity constructor arguments (optional).
	-- @return	The new Entity object.
	create: (cls, constructorArgs) =>
		entity = @__recycled.pop!
		if entity == nil or entity.scene != nil
			if entity != nil
				@recycle(entity)

			-- TODO implement me
			--if constructorArgs != nil
				--entity = Type.createInstance(cls, constructorArgs)
			--else
				--entity = Type.createInstance(cls, [])
		entity.active = true

		@add(entity)

	-- Removes the Entity from the EntityList at the end of the frame and
	-- recycles it. The recycled Entity can then be fetched again by calling the
	-- create() function.
	-- @param	e		The Entity to recycle.
	-- @return	The recycled Entity.
	recycle: (entity) =>
		@remove(entity)
		entity.active = false
		@remove(entity)

	-- Clears stored reycled Entities of the Class type.
	clearRecycled: => @__recycled\clear!

{ :EntityList }
