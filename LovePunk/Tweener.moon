export ^

class Tweener
	new: =>
		@active = true
		@autoClear = false
		@tween = nil

	hasTween: =>
		@tween != nil

	-- Add the tween to the tween list.
	-- 
	-- @param t     The tween to add.
	-- @param start If the tween should start immediately.
	-- 
	-- @return The added tween.
	addTween: (t, start) =>
		t.parent = @ if t.__class == Tween

	clearTweens: =>
	removeTween: (t) =>
	update: =>
	updateTweens: =>