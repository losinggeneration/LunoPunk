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
		assert.are.equal true, e.visible
		assert.are.equal true, e.collidable
		assert.are.equal false, e.followCamera

		-- Follow Camera coverage
		e.followCamera = true
		assert.are.equal 0, e\x!
		assert.are.equal 0, e\y!
		LP.camera.x += 1
		assert.are.equal 1, e\x!
		assert.are.equal 0, e\y!
		LP.camera.y -= 1
		assert.are.equal -1, e\y!
		e.followCamera = false
		assert.are.equal 0, e\x!
		assert.are.equal 0, e\y!

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

	-- TODO finish
	it "accessors", ->
		e = Entity!
		assert.are.equal 0, e\halfWidth!
		e.width = 10
		assert.are.equal 5, e\halfWidth!

		assert.are.equal 0, e\halfHeight!
		e.height = 20
		assert.are.equal 10, e\halfHeight!

		assert.are.equal 5, e\centerX!
		assert.are.equal 10, e\centerY!
		e.originX = 10
		assert.are.equal -5, e\centerX!
		e.originY = 10
		assert.are.equal 0, e\centerY!
		e\x 5
		assert.are.equal 0, e\centerX!
		e\y 10
		assert.are.equal 10, e\centerY!

		assert.are.equal -5, e\left!
		assert.are.equal 5, e\right!
		assert.are.equal 0, e\top!
		assert.are.equal 20, e\bottom!

	it "collidable", ->
		pending "Will write tests tomorrow"
		e = with Entity 5, 5
			.width = 10
			.height = 10

		-- Collider
		c = with Entity 5, 5
			.width = 10
			.height = 10

		-- No Scene
		assert.is.Nil e\collide c, 10, 10

		-- Not collidable
		e.collidable = false
		assert.is.Nil e\collide e, 10, 10