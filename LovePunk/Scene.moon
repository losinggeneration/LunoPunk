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

	add: (e) =>
	addGraphic: (graphic, layer, x, y) =>
	addList: (list) =>
	addMask: (mask, type, x, y) =>
	begin: =>
	bringForward: (e) =>
	bringToFront: (e) =>
	classCount: (c) =>
	classFirst: (c) =>
	clearRecycled: (classType) =>
	clearRecycledAll: =>
	collideCircle: (type, circleX, circleY, radius, into) =>
	collideLine: (type, fromX, fromY, toX, toY, precision, p) =>
	collidePoint: (type, pX, pY) =>
	collidePoint: (type, pX, pY, into) =>
	collideRect: (type, rX, rY, rWidth, rHeight) =>
	collideRect: (type, rX, rY, rWidth, rHeight, into) =>
	create: (classType, addToScene) =>
	end: =>
	focusGained: =>
	focusLost: =>
	getAll: (into) =>
	getClass: (c, into) =>
	getInstance: (name) =>
	getLayer: (layer, into) =>
	getSpriteByLayer: (layer) =>
	getType: (type, into) =>
	isAtBack: (e) =>
	isAtFront: (e) =>
	layerCount: (layer) =>
	layerFirst: (layer) =>
	layerLast: (layer) =>
	nearestToClass: (type, e, classType, useHitboxes) =>
	nearestToEntity: (type, e, useHitboxes) =>
	nearestToPoint: (type, x, y, useHitboxes) =>
	nearestToRect: (type, x, y, width, height) =>
	recycle: (e) =>
	remove: (e) =>
	removeAll: =>
	removeList: =>
	render: =>
	sendBackward: (e) =>
	sendToBack: (e) =>
	typeCount: (type) =>
	typeFirst: (type) =>
	update: =>
	updateLists: (shouldAdd) =>
