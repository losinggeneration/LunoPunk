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