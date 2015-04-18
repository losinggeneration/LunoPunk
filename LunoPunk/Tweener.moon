class Tweener
	new: =>
		@active = true
		@autoClear = false
		@__tween = nil

	update: =>

	-- Add the tween to the tween list.
	--
	-- @param t     The tween to add.
	-- @param start If the tween should start immediately.
	--
	-- @return The added tween.
	addTween: (t, start) =>
		import Tween from require "LunoPunk.Tween"

		assert t.__parent == nil, "Cannot add a Tween object more than once."

		t.__parent = @ if t.__class == Tween
		t.__next = @__tween

		@__tween.__prev = t unless @__tween == nil
		@__tween = t

		@__tween\start! if start

		t

	-- Remove the tween from the tween list.
	--
	-- @param	t		The tween to remove.
	--
	-- @return	The removed tween.
	removeTween: (t) =>
		assert t.__parent == @, "Core object does not contain Tween."

		t.__next.__prev = t.__prev unless t.__next == nil

		if t.__prev == nil
			@__tween = if t.__next == nil then nil else t.__next
		else
			t.__prev.__next = t.__prev

		t.__next, t.__prev = nil, nil
		t.active = false
		t.__parent = nil

		t

	-- Remove all tweens from the tween list.
	clearTweens: =>
		t = @__tween
		n = nil
		while t != nil
			n = t.__next
			@removeTween t
			t = n

	-- Update all contained tweens.
	updateTweens: =>
		t = @__tween
		while t != nil
			if t.active
				t\update!
				t\finish! if t.__finish
			t = t.__next

	hasTween: => @__tween != nil

{ :Tweener }
