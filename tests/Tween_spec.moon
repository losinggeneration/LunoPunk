require "busted"
require "tests.mock_love"

require "LunoPunk.Tween"

-- This is how the Tweener updates
class tween extends Tween
	update: =>
		super!
		@finish! if @__finish

describe "Tween", ->
	setup ->
		-- We used fixed time for testing
		LP.fixed = true

	it "construct", ->
		assert.has.errors -> tween!
		twn = tween 500
		assert.is.False twn.active
		assert.is.Nil twn.ease
		assert.are.equal TweenType.Persist, twn.type
		assert.are.equal 0, twn.t

	it "start", ->
		-- Test call to finish when start is called and duration == 0
		twn = tween 0
		finished = -> assert false, "Tween finished"
		AddEventListener TweenEvent.FINISH, finished
		assert.has.errors -> twn\start!
		-- Don't leave this listener or it will be called in other tests
		RemoveEventListener TweenEvent.FINISH, finished

	it "update (persist)", ->
		twn = tween 5
		twn\start!
		assert.is.True twn.active
		twn\update!
		assert.are.equal 1/5, twn.t
		twn\update!
		assert.are.equal 2/5, twn.t
		-- Finish up the twn
		twn\update!
		twn\update!
		twn\update!
		-- t loops back to 0 to start again
		assert.are.equal 0, twn.t
		assert.is.False twn.active

		twn = tween 2, TweenType.Persist, nil, (t) => t + 1
		twn\update!
		assert.is.False twn.active

	it "update (looping)", ->
		twn = tween 2, TweenType.Looping
		twn\start!
		for i=1, 33
			assert.is.True twn.active
			assert.are.equal (i-1)%2/2, twn.t
			twn\update!

	it "update (oneshot)", ->
		twn = tween 2, TweenType.OneShot
		twn\start!

		assert.is.True twn.active
		assert.are.equal 0, twn.t
		twn\update!

		assert.is.True twn.active
		assert.are.equal 1/2, twn.t
		twn\update!

		assert.is.False twn.active

	it "complete callback", ->
		-- Assert when the callback is called
		twn = tween 2, TweenType.Looping, -> assert false, "Tween callback called"
		twn\start!
		twn\update!
		assert.has.errors -> twn\update!
		twn\update!
		assert.has.errors -> twn\update!

	it "cancel", ->
		-- Assert if the complete callback is called
		twn = tween 2, TweenType.Persist, -> assert false, "Tween callback called"
		twn\start!

		assert.is.True twn.active
		twn\update!
		assert.is.True twn.active
		twn\cancel!
		assert.is.False twn.active
		assert.has_no.errors -> twn\update!
