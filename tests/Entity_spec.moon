require "busted"
require "tests.mock_love"

require "LunoPunk.Entity"
require "LunoPunk.Graphic"
require "LunoPunk.Mask"
require "LunoPunk.utils.moonscript"

describe "Entity", ->
	it "construct", ->
		e = Entity!
		assert.are.equal true, e.active
		assert.are.equal false, e.autoClear
		assert.are.equal 0, e\x!
		assert.are.equal 0, e\y!
		assert.are.equal 0, e.originX
		assert.are.equal 0, e.originY
		assert.are.equal 0, e.width
		assert.are.equal 0, e.height
		assert.are.equal 0, e.bottom
		assert.are.equal 0, e.centerX
		assert.are.equal 0, e.centerY
		assert.are.equal true, e.visible
		assert.are.equal true, e.collidable
		assert.are.equal false, e.followCamera

		e = Entity 10, 15
		assert.are.equal 10, e\x!
		assert.are.equal 15, e\y!
		assert.are.equal 0, e.originX
		assert.are.equal 0, e.originY
		assert.are.equal 0, e.width
		assert.are.equal 0, e.height

		g = Graphic!
		g.x, g.y = 25, 30
		e = Entity 10, 15, g
		assert.are.equal g, e\graphic!
		assert.are.equal 10, e\x!
		assert.are.equal 15, e\y!
		assert.are.equal 0, e.originX
		assert.are.equal 0, e.originY
		assert.are.equal 0, e.width
		assert.are.equal 0, e.height

		m = Mask!
		e = Entity 10, 15, g, m
		assert.are.equal m, e\mask!
		assert.are.equal 10, e\x!
		assert.are.equal 15, e\y!
		assert.are.equal 0, e.originX
		assert.are.equal 0, e.originY
		assert.are.equal 0, e.width
		assert.are.equal 0, e.height