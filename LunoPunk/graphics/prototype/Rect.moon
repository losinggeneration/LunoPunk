import Graphic from require "LunoPunk.Graphic"
import Image from require "LunoPunk.graphics.Image"

class Rect extends Graphic
	new: (width, height, color = 0xFFFFFF) =>
		super!

		@__width = width
		@__height = height
		@__color = color
		createImage @

	-- TODO renderMode
	render: (point, camera) =>
		@__point.x = point.x + @x
		@__point.y = point.y + @y
		@__img\render @__point, camera

	createImage = =>
		@__img = Image.createRect @__width, @__height, @__color

	width: (value) =>
		return @__width if value == nil or value == @__width
		@__width = value
		@__img = createImage @

	height: (value) =>
		return @__height if value == nil or value == @__height
		@__height = value
		@__img = createImage @

	color: (value) =>
		return @__color if value == nil or value == @__color
		@__color = value
		@__img = createImage @

{ :Rect }
