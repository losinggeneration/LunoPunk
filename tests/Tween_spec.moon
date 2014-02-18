require "busted"
require "tests.mock_love"

require "LunoPunk.Tween"

describe "Tween", ->
	it "construct", ->
		assert.has.errors -> Tween!
		tween = Tween 500
		assert.is.False tween.active
		assert.is.Nil tween.ease
		assert.are.equal TweenType.Persist, tween.type
		assert.are.equal 0, tween.t

	it "update (persist)", ->
		-- Löve is stubbed, so we used fixed time
		LP.fixed = true

		tween = Tween 5
		tween\start!
		assert.is.True tween.active
		tween\update!
		assert.are.equal 1/5, tween.t
		tween\update!
		assert.are.equal 2/5, tween.t
		-- Finish up the tween
		tween\update!
		tween\update!
		tween\update!
		-- t loops back to 0 to start again
		assert.are.equal 0, tween.t
		assert.is.False tween.active

		tween = Tween 2, TweenType.Persist, nil, (t) => t + 1
		tween\update!
		assert.is.False tween.active

	it "update (looping)", ->

	it "update (oneshot)", ->

	it "complete callback", ->

	it "cancel", ->
