export ^

class AtlasRegion
	new: (parent, tileindex, rect) =>
		@__parent = parent
		@__tileIndex = tileindex
		@rect = rect\clone!
		@rotated = false

	tileIndex: => @__tileIndex
	width: => @rect.width
	height: => @rect.height

	clip: =>