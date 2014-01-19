export ^

class Screen
	new: =>
	addFilter: (filter) =>
	capture: =>
		-- TODO return LovePunk.graphics.Image
	init: =>
	redraw: =>
	refresh: =>
	resize: =>
	swap: =>
	update: =>

	get_angle = => @_angle * LP.DEG
	get_color = => @_color
	get_mouseX = => @_sprite.mouseX
	get_mouseY = => @_sprite.mouseY
	-- return bool
	-- TODO STUB
	get_smoothing = => false
	-- value float
	-- return float
	set_angle = (value) =>
	-- value int
	-- return int
	set_color = (value) =>
	-- value int
	-- return int
	set_originX = (value) =>
	-- value int
	-- return int
	set_originY = (value) =>
	-- value float
	-- return float
	set_scale = (value) =>
	-- value float
	-- return float
	set_scaleX = (value) =>
	-- value float
	-- return float
	set_scaleY = (value) =>
	-- value bool
	-- return bool
	set_smoothing = (value) => false
	-- value int
	-- return int
	set_x = (value) =>
	-- value int
	-- return int
	set_y = (value) =>
	-- bd Bitmap
	disposeBitmap = (bd) =>
