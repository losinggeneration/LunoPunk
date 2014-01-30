require "LovePunk.Graphic"
require "LovePunk.RenderMode"
require "LovePunk.graphics.atlas.Atlas"
require "LovePunk.graphics.atlas.AtlasRegion"
require "LovePunk.graphics.atlas.TextureAtlas"
require "LovePunk.geometry.Rectangle"

export ^

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
		@__matrix = LP.matrix

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
			elseif source["type"] and source\type! == "Image" -- Löve Image
				@__setImageSource source
			else
				if type(source) == "string"
					@__imgName = source
				else if name == ""
					@__imgName = @@.__name

				@__setImageSource LP.getImage source

			assert false, "Invalid source image." if @__source == nil and @__region == nil

		if clipRect != nil
			clipRect.width = @__sourceRect\width! if clipRect\width! == 0
			clipRect.height = @__sourceRect\height! if clipRect\height! == 0
			@__region = @__region\clip clipRect if not @__blit -- creat a new clipped region
			@__sourceRect = clipRect


	__setAtlasRegion: (region) =>
		@__blit = false
		@__region = region
		@__sourceRect = Rectangle 0, 0, region\width!, region\height!

	__setImageSource: (img) =>
		@__blit = false
		@__sourceRect = Rectangle 0, 0, img\getWidth!, img\getHeight!
		@__source = img

	-- Renders the image.
	render: (point, camera) =>
