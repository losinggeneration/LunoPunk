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

	it "convertColor", ->
		rgb = LP.convertColor 0x1f2f3f
		assert.are.equal rgb[1], 0x1f
		assert.are.equal rgb[2], 0x2f
		assert.are.equal rgb[3], 0x3f

	it "getColorRGB", ->
		assert.are.equal 0x1f2f3f, LP.getColorRGB 0x1f, 0x2f, 0x3f

	it "lerp", ->
		assert.are.equal 1, LP.lerp 1, 2, 0
		assert.are.equal 2, LP.lerp 1, 2, 1
		assert.are.equal 1.5, LP.lerp 1, 2, .5

	it "colorLerp", ->
		color1 = 0x000000
		color2 = 0x101010
		assert.are.equal 0x000000, LP.colorLerp color1, color2, 0
		assert.are.equal 0x101010, LP.colorLerp color1, color2, 1

	it "approach", ->
		assert.are.equal 1, LP.approach 1, 2, 0
		assert.are.equal 1, LP.approach 0, 2, 1
		assert.are.equal 2, LP.approach 0, 2, 2
		assert.are.equal 2, LP.approach 0, 2, 3
