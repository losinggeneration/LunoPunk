require "busted"
require "tests.mock_love"

require "LunoPunk.Tweener"
require "LunoPunk.Tween"

describe "Tweener", ->
	setup ->
		require "coveralls.init"
		Coveralls\start!

	teardown ->
		Coveralls\stop!
		Coveralls\cover "./LunoPunk/Tweener.moon"

	it "construct", ->
		t = Tweener!
		assert.is.True, t.active
		assert.is.False, t.autoClear

	it "addTween", ->
		tweener = Tweener!
		tween = Tween 500
		t = tweener\addTween tween, true
		assert.is.True, tween.active
		assert.are.same tween, t
		-- A tween instance can only be added once
		assert.has.errors -> tweener\addTween tween, true
		-- A new tween can be added
		assert.has_no.errors -> tweener\addTween Tween 500, true
		tween = tweener\addTween Tween 500, false
		assert.is.False tween.active

	it "removeTween", ->
		tweener = Tweener!

		-- Non-objects are erros
		assert.has.errors -> tweener\removeTween nil
		assert.has.errors -> tweener\removeTween 5
		assert.has.errors -> tweener\removeTween "Tween"

		-- try removing a tween that hasn't been added
		assert.has.errors -> tweener\removeTween Tween 5

		tweens = {i, tweener\addTween Tween 5 for i=1, 10}

		-- remove an added tween
		t = tweener\removeTween tweens[1]
		assert.are.same tweens[1], t
		-- try to remove it again
		assert.has.errors -> tweener\removeTween tweens[1]

		-- remove another
		t = tweener\removeTween tweens[3]
		assert.are.same tweens[3], t

		-- clear the two removed from the table
		table.remove tweens, 3
		table.remove tweens, 1

		-- and remove all tweens
		for t in *tweens
			rt = tweener\removeTween t
			assert.are.same t, rt
			assert.is.False rt.active

	it "clearTweens", ->

	it "updateTweens", ->

	it "hasTween", ->