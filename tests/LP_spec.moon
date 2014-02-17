require "busted"
require "tests.mock_love"

require "LunoPunk.LP"

describe "LP", ->
	it "sign", ->
		-- Negative
		assert.are.equal -1, LP.sign -1
		assert.are.equal -1, LP.sign -15
		-- bounds
		assert.are_not.equal -1, LP.sign 0
		assert.are_not.equal 0, LP.sign -1
		assert.are.equal 0, LP.sign 0
		assert.are_not.equal 0, LP.sign 1
		-- Positive
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
		-- t = 0, return the first value
		assert.are.equal 1, LP.lerp 1, 2, 0
		-- t = 1, return the second value
		assert.are.equal 2, LP.lerp 1, 2, 1
		-- t = .5, return the midpoint between the values
		assert.are.equal 1.5, LP.lerp 1, 2, .5

	it "colorLerp", ->
		color1 = 0x000000
		color2 = 0x101010
		-- t = 0, return the first color
		assert.are.equal 0x000000, LP.colorLerp color1, color2, 0
		-- t = 1, return the second color
		assert.are.equal 0x101010, LP.colorLerp color1, color2, 1
		-- t = .5, return the color half way between the two colors
		assert.are.equal 0x080808, LP.colorLerp color1, color2, .5

	it "approach", ->
		-- No approach
		assert.are.equal 1, LP.approach 1, 2, 0
		-- Contained approach
		assert.are.equal 1, LP.approach 0, 2, 1
		-- <= approach
		assert.are.equal 2, LP.approach 0, 2, 2
		-- approach, but do not go over
		assert.are.equal 2, LP.approach 0, 2, 3

	it "stepTowards", ->
		class xy
			new: => @x, @y = 0, 0

		-- No step
		c = xy!
		LP.stepTowards c, 1, 1, 0
		assert.are.equal 0, c.x
		assert.are.equal 0, c.y

		-- Contained step
		LP.stepTowards c, 2, 2, 1
		assert.are.equal 1, c.x
		assert.are.equal 1, c.y

		-- Bounds step
		LP.stepTowards c, 2, 2, 1
		assert.are.equal 2, c.x
		assert.are.equal 2, c.y

		-- Over step
		LP.stepTowards c, 2, 2, 1
		assert.are.equal 2, c.x
		assert.are.equal 2, c.y

		-- Different x and y
		LP.stepTowards c, 2, 3, 1
		assert.are.equal 2, c.x
		assert.are.equal 3, c.y

		-- Under step (changed bounds)
		LP.stepTowards c, 1, 2, 1
		assert.are.equal 1, c.x
		assert.are.equal 2, c.y
