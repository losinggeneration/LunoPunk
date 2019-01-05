import Text from require "LunoPunk.graphics.Text"
import Color from require "LunoPunk.utils.Color"

if love._version_major == 0 and love._version_minor == 8
	love.graphics._getLineWidth = love.graphics.getLineWidth
	love.graphics._setLineWidth = love.graphics.setLineWidth
	love.graphics.getLineWidth = -> love.graphics.varlinewidth or 1
	love.graphics.setLineWidth = (w) ->
		love.graphics.varlinewidth = w
		love.graphics._setLineWidth w

class draw
	blendMode = nil
	new: ->

	circle: (x, y, radius, color = 0xFFFFFF, alpha = 1, fill = true, thick = 1) ->
		restore = setupVars color, alpha, thick
		love.graphics.circle (if fill == true then "fill" else "line"), x, y, radius
		restore!

	-- TODO
	curve: (x1, y1, x2, y2, x3, y3, thick = 1, color = 0, alpha = 1) ->
	-- TODO
	entity: (e, x = 0, y = 0, addEntityPosition = false) ->
	-- TODO
	graphic: (g, x = 0, y = 0) ->
	hitbox: (e, outline = true, color = 0xFFFFFF, alpha = 1) ->
		draw.rect e.originX, e.originY, e.height, e.width, color, alpha, not outline, 1

	line: (x1, y1, x2, y2, color = 0xFF000000, alpha = 1, thick = 1) ->
		restore = setupVars color, alpha, thick
		love.graphics.line x1, y1, x2, y2
		restore!

	rect: (x, y, width, height, color = 0xFFFFFF, alpha = 1, fill = true, thick = 1) ->
		restore = setupVars color, alpha, thick
		love.graphics.rectangle (if fill == true then "fill" else "line"), x, y, width, height
		restore!

	-- TODO
	resetTarget: ->
	setTarget: (target, camera = nil, blend = nil) ->

	text: (text, x = 0, y = 0, options = nil) ->
		color = 0xFFFFFF
		if options
			color = options.color if options.color

		restore = setupVars color
		love.graphics.print text, x, y
		restore!

	setupVars = (color, alpha = 1, thick = 1) ->
		old_color = {love.graphics.getColor!}
		old_thick = love.graphics.getLineWidth!

		c = Color color
		rgb = c\rgb!
		rgb[#rgb] = 255 * alpha
		love.graphics.setColor rgb
		love.graphics.setLineWidth thick

		-- Restore old values
		->
			love.graphics.setColor old_color
			love.graphics.setLineWidth old_thick

Draw = draw!

{ :Draw }
