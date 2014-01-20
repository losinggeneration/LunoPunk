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
		@__mouseX = nil
		@__mouseY = nil
		@__nearest = nil
		@__sprite = nil
		@__uniqueTypes = nil
		@__updatedFirst = nil

	begin: =>
	-- Changed from end because of issues with the name "end" in Lua
	endScene: =>
	focusGained: =>
	focusLost: =>

	update: =>
	render: =>

	mouseX: => @__mouseX
	mouseY: => @__mouseY
	sprite: => @__sprite

	add: (e) =>
	remove: (e) =>
	removeAll: =>
	addList: (list) =>
	removeList: =>
	addGraphic: (graphic, layer, x, y) =>
	addMask: (mask, type, x, y) =>
	create: (classType, addToScene) =>
	recycle: (e) =>
	clearRecycled: (classType) =>
	clearRecycledAll: =>
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
