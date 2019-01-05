import Point from require "LunoPunk.geometry.Point"

-- TODO
class atlasdata
	new: =>

	create: (source) ->
		atlasdata!

	-- Creates a new AtlasRegion
	-- @param	rect	Defines the rectangle of the tile on the tilesheet
	-- @param	center	Positions the local center point to pivot on
	--
	-- @return The new AtlasRegion object.
	createRegion: (rect, center) =>
		r = rect\clone!
		p = Point center.x, center.y unless center != nil
-- 		tileIndex = @__tilesheet\addTileRect r, p
		AtlasRegion @, tileIndex, rect

	width: => @__width
	height: => @__height

AtlasData = atlasdata!

{ :AtlasData }
