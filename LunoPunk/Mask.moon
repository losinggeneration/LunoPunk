class Mask
	new: =>
		@parent = nil

	-- Checks for collision with another Mask.
	-- @param	mask	The other Mask to check against.
	-- @return	If the Masks overlap.
	collide: (mask) =>
		@__assertParentAttached!
		if other\collide
			other\collide @
		else
			@__collideMask @

	__assertParentAttached: =>
		assert @parent != nil, "Mask must be attached to a parent Entity"

	-- @private Collide against an Entity.
	__collideMask: (other) =>
		l1 = @parent\x! - @parent.originX + @parent.width >= other.parent\x! - other.parent.originX
		l2 = @parent\y! - @parent.originY + @parent.height >= other.parent\y! - other.parent.originY
		l3 = @parent\x! - @parent.originX <= other.parent\x! - other.parent.originX + other.parent.width
		l4 = @parent\y! - @parent.originY <= other.parent\y! - other.parent.originY + other.parent.height
		l1 and l2 and l3 and l4

	-- @private Assigns the mask to the parent.
	__assignTo: (parent) =>
		@parent = parent
		@update! unless parent == nil

	-- Override this
	debugDraw: (graphics, scaleX, scaleY) =>

	-- Updates the parent's bounds for this mask.
	update: =>

	project: (axis = {x: 1, y: 1}, projection) =>
		max = -9999999999.0
		min = 9999999999.0

		cur = -@parent.originX * axis.x - @parent.originY * axis.y
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

		{ :min, :max }

{ :Mask }
