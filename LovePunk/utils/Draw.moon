export ^

class draw
	blendMode = nil
	new: ->
	circle: (x, y, radius, color = 0xFFFFFF) ->
	circlePlus: (x, y, radius, color = 0xFFFFFF, alpha = 1, fill = true, thick = 1) ->
	curve: (x1, y1, x2, y2, x3, y3, thick = 1, color = 0, alpha = 1) ->
	entity: (e, x = 0, y = 0, addEntityPosition = false) ->
	graphic: (g, x = 0, y = 0) ->
	hitbox: (e, outline = true, color = 0xFFFFFF, alpha = 1) ->
	line: (x1, y1, x2, y2, color = 0xFFFFFF) ->
	linePlus: (x1, y1, x2, y2, color = 0xFF000000, alpha = 1, thick = 1) ->
	rect: (x, y, width, height, color = 0xFFFFFF, alpha = 1) ->
	resetTarget: ->
	setTarget: (target, camera = nil, blend = nil) ->
	text: (text, x = 0, y = 0, options = nil) ->

	__drawToScreen = ->

Draw = draw!