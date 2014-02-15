require "busted"
require "tests.mock_love"

require "LunoPunk.LP"

describe "LP", ->
	it "sign", ->
		assert.are.equal -1, LP.sign -1
		assert.are.equal -1, LP.sign -15
		assert.are_not.equal -1, LP.sign 0
		assert.are_not.equal 0, LP.sign -1
		assert.are.equal 0, LP.sign 0
		assert.are_not.equal 0, LP.sign 1
		assert.are.equal 1, LP.sign 1
		assert.are.equal 1, LP.sign 15

	it "clamp", ->
		-- contained
		assert.are.equal 1.5, LP.clamp 1.5, 0, 2
		assert.are.equal 1.9999, LP.clamp 1.9999, 0, 2
		-- Max
		assert.are.equal 2, LP.clamp 2, 0, 2
		assert.are.equal 2, LP.clamp 3, 0, 2
		-- Min
		assert.are.equal 0, LP.clamp 0, 0, 1
		assert.are.equal 0, LP.clamp -1, 0, 1

	it "lerp", ->
		assert.are.equal 1, LP.lerp 1, 2, 0
		assert.are.equal 2, LP.lerp 1, 2, 1
		assert.are.equal 1.5, LP.lerp 1, 2, .5