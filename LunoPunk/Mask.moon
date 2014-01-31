require "LunoPunk.masks.Masklist"

export ^

class Mask
	new: =>
		@parent = nil
		@list = Masklist!

		@__check = {}
		@__check[@@] = @\collideMask
		@__check[Masklist.__class] = @\collideMasklist

	-- Checks for collision with another Mask.
	-- @param	mask	The other Mask to check against.
	-- @return	If the Masks overlap.
	collide: (mask) =>
		assert @parent != nil, "Mask must be attached to a parent Entity"
		cb = @__check[mask.__class]
		return cb if cb != nil

		cb = mask.__check[@@]
		return cb if cb != nil
		false

	-- @private Collide against an Entity.
	collideMask: (other) =>
		l1 = @parent\x! - @parent.originX + @parent.width > other.parent\x! - other.parent.originX
		l2 = @parent\y! - @parent.originY + @parent.height > other.parent\y! - other.parent.originY
		l3 = @parent\x! - @parent.originX < other.parent\x! - other.parent.originX + other.parent.width
		l4 = @parent\y! - @parent.originY < other.parent\y! - other.parent.originY + other.parent.height
		l1 and l2 and l3 and l4

	-- Checks for collision with another Mask.
	-- @param	mask	The other Mask to check against.
	-- @return	If the Masks overlap.
	collideMasklist: (other) =>
		other\collide @

	-- @private Assigns the mask to the parent.
	assignTo: (parent) =>
		@parent = parent
		@update! if parent != nil

	-- Override this
	debugDraw: (graphics, scaleX, scaleY) =>

	-- Updates the parent's bounds for this mask.
	update: =>

	project: (axis, projection) =>
		max = -9999999999.0
		min = 9999999999.0

		cur = -@parent.originX * axis.x - @parent.originY * axit.y
		min = cur if cur < min
		max = cur if cur > max

		cur = (-@parent.originX + @parent.width) * axis.x - @parent.originY * axis.y
		min = cur if cur < min
		max = cur if cur > max

		cur = -@parent.originX * axis.x + (-@parent.originY + @parent.height) * axis.y
		min = cur if cur < min
		max = cur if cur > max

		cur = (-@parent.originX + @parent.width) * axis.x + (-@parent.originY + @parent.height) * axis.y
		min = cur if cur < min
		max = cur if cur > max

		projection.min = min
		projection.max = max
