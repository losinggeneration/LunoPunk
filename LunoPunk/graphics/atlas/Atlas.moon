import AtlasData from require "LunoPunk.graphics.atlas.AtlasData"

-- TODO
class Atlas
	new: =>

	loadImageAsRegion: (source) ->
		data = AtlasData.create source
		data\createRegion Rectangle 0, 0, data\width!, data\height!

{ :Atlas }
