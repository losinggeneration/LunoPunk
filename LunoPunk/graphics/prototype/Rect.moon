require "LunoPunk.Graphic"
require "LunoPunk.graphics.Image"

export ^

class Rect extends Graphic
	new: (width, height, color = 0xFFFFFF) =>
		super!

		@__width = width
		@__height = height
		@__color = color
		createImage @

	render: (point, camera) =>
		@__point.x = point.x + @x
		@__point.y = point.y + @y
		@__img\render @__point, camera

	createImage = =>
		@__img = Image.createRect @__width, @__height, @__color

	width: (value) =>
		return value if value == nil or value == @__width
		@__width = value
		@__img = createImage @

	height: (value) =>
		return value if value == nil or value == @__height
		@__height = value
		@__img = createImage @

	color: (value) =>
		return value if value == nil or value == @__color
		@__color = value
		@__img = createImage @
