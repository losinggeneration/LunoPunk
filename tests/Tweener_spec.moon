require "busted"
require "tests.mock_love"

require "LunoPunk.Tweener"
require "LunoPunk.Tween"

describe "Tweener", ->
	it "construct", ->
		t = Tweener!
		assert.is.True, t.active
		assert.is.False, t.autoClear

	it "addTween", ->
		tweener = Tweener!
		tween = Tween 500
		tweener\addTween tween, true
		assert.is.True, tween.active
		-- A tween instance can only be added once
		assert.has.errors -> tweener\addTween tween, true
		-- A new tween can be added
		assert.has_no.errors -> tweener\addTween Tween 500, true
		tween = tweener\addTween Tween 500, false
		assert.is.False tween.active

	it "removeTween", ->

	it "clearTweens", ->

	it "updateTweens", ->

	it "hasTween", ->