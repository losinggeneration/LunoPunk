import Entity from require 'LunoPunk.Entity'

class Cursor extends Entity
	-- Constructor.
	-- @param	graphic		Graphic to assign to the Entity.
	-- @param	mask		Mask to assign to the Entity.
	new: (image) =>
		img = Image(image)
		img.smooth = true
		super 0, 0, img

	-- Updates the entitiy coordinates to match the cursor.
	-- TODO verify this
	update: =>
		super!
		x = @scene!.mouseX
		y = @scene!.mouseY

	-- TODO verify this
	render: (camera) =>
		img = Image!
		if img != nil
			-- scale to 1
			img.scaleX = 1 / camera.screenScaleX
			img.scaleY = 1 / camera.screenScaleY

		super camera

	-- Shows the custom cursor
	show: => @visible = true

	-- Hides the custom cursor
	hide: => @visible = false

{ :Camera }
