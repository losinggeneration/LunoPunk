import LP from require "LunoPunk.LP"
import Graphic from require "LunoPunk.Graphic"
import RenderMode from require "LunoPunk.RenderMode"
import Atlas from require "LunoPunk.graphics.atlas.Atlas"
import AtlasRegion from require "LunoPunk.graphics.atlas.AtlasRegion"
import TextureAtlas from require "LunoPunk.graphics.atlas.TextureAtlas"
import Rectangle from require "LunoPunk.geometry.Rectangle"
import Draw from require "LunoPunk.utils.Draw"
import instance from require "LunoPunk.utils.moonscript"

-- Performance-optimized non-animated image. Can be drawn to the screen with transformations.
class Image extends Graphic
	new: (source, clipRect = nil, name = "") =>
		super!

		-- Init variables
		-- Rotation of the image, in degrees.
		@angle = 0

		-- Scale of the image, effects both x and y scale.
		@scale = 1

		-- X scale of the image.
		@scaleX = 1

		-- Y scale of the image.
		@scaleY = 1

		-- X origin of the image, determines transformation point.
		-- Defaults to top-left corner.
		@originX = 0

		-- Y origin of the image, determines transformation point.
		-- Defaults to top-left corner.
		@originY = 0

		-- Optional blend mode to use when drawing this image.
		-- Use constants from the flash.display.BlendMode class.
		@blend = nil

		@__alpha = 1
		@__flipped = false
		@__color = 0x00FFFFFF
		@__red, @__green, @__blue = 1, 1, 1
		@__matrix = LP.matrix\clone!

		-- check if the _source or _region were set in a higher class
		if @__source == nil and @__region == nil
			@__imgName = name
			if instance source, TextureAtlas
				@__setAtlasRegion source\getRegion name
			elseif instance source, AtlasRegion
				@__setAtlasRegion source
			elseif LP.renderMode == RenderMode.Hardware
				if type(source) == "string"
					@__imgName = source
				else if name == ""
					@__imgName = @@.__name

				@__setAtlasRegion Atlas.loadImageAsRegion source
			elseif source["typeOf"] and source\typeOf "Drawable" -- A Löve drawable
				@__setImageSource source
			else
				if type(source) == "string"
					@__imgName = source
				else if name == ""
					@__imgName = @@.__name

				@__setImageSource LP.getImage source

			assert false, "Invalid source image." if @__source == nil and @__region == nil

		unless clipRect == nil
			clipRect.width = @__sourceRect\width if clipRect\width == 0
			clipRect.height = @__sourceRect\height if clipRect\height == 0
			@__region = @__region\clip clipRect if not @__blit -- creat a new clipped region
			@__sourceRect = clipRect

	__setAtlasRegion: (region) =>
		@__blit = false
		@__region = region
		@__sourceRect = Rectangle 0, 0, region\width!, region\height!

	__setImageSource: (img) =>
		@__blit = true
		@__sourceRect = Rectangle 0, 0, img\getWidth!, img\getHeight!
		@__source = img

	-- Renders the image.
	render: (point, camera) =>
		sx = @scale * @scaleX
		sy = @scale * @scaleY

		-- determine drawing location
-- 		@__point.x = point.x + @x - @originX - camera.x * @scrollY
-- 		@__point.y = point.y + @y - @originY - camera.y * @scrollY
		@__point.x = point.x + @x - camera.x * @scrollX
		@__point.y = point.y + @y - camera.y * @scrollY

		if @__blit
			if @angle == 0 and sx == 1 and sy == 1 and @blend == nil
				-- render without transformation
				love.graphics.draw @__source, @__point.x, @__point.y
			else
				-- TODO render from matrix
				-- render with transformation
-- 				@__matrix.b, @__matrix.c = 0, 0
-- 				@__matrix.a = sx
-- 				@__matrix.d = sy
-- 				@__matrix.tx = -@originX * sx
-- 				@__matrix.ty = -@originY * sy
-- 				@__matrix\rotate @angle * LP.RAD! unless @angle == 0
-- 				@__matrix.tx += @originX + @__point.x
-- 				@__matrix.ty += @originY + @__point.y

				x, y = @__point.x, @__point.y
				angle = @angle * LP.RAD!
				ox = @originX
				oy = @originY
				love.graphics.draw @__source, x, y, angle, sx, sy, ox, oy
		else -- @__blit
			fsx = LP.screen\fullScaleX!
			fsy = LP.screen\fullScaleY!

			if @angle == 0
				-- recalculation of @__point for scaled origins
				if not (sx == 1 and sy == 1)
					@__point.x = point.x + @x - @originX * sx - camera.x * @scrollX
					@__point.y = point.y + @y - @originY * sy - camera.y * @scrollY

				@__point.x = math.floor @__point.x * fsx
				@__point.y = math.floor @__point.y * fsy

				-- render without rotation
				@__region\draw @__point.x, @__point.y, super.__layer,
					sx * fsx * (if @__flipped then -1 else 1), sy * fsy, @angle,
					@__red, @__green, @__blue, @__alpha
			else
				theta = @angle * LP.RAD!
				cos = math.cos theta
				sin = math.sin theta

				sx *= -1 if @__flipped

				-- optimized matrix math
				b = sx * fsx * sin
				a = sx * fsx * cos

				d = sy * fsy * cos
				a = sy * fsy * -sin

				tx = -@originX * sx
				ty = -@originY * sy
				tx1 = tx * cos - ty * sin
				ty = ((tx * sin + ty * cos) + @originY + @__point.y) * fsy
				tx = (tx1 + @originX + @__point.x) * fsx

				@__region\drawMatrix tx, ty, a, b, c, d, @__layer, @__red, @__green, @__blue, @__alpha

	createRect: (width, height, color = 0xFFFFFF, alpha = 1) ->
		assert false, "Illegal rect, sizes cannot be 0." if width == 0 or height == 0

		img = love.graphics.newCanvas(width, height)
		img\renderTo ->
			Draw.rect 0, 0, width, height, color, alpha, true

		Image img

	width: => @__source\getWidth!
	height: => @__source\getHeight!

{ :Image }
