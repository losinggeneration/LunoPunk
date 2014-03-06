require "busted"
require "tests.mock_love"

require "LunoPunk.Entity"
require "LunoPunk.Graphic"
require "LunoPunk.Mask"
require "LunoPunk.utils.moonscript"

entity_sanity_check = ->
	e = Entity!
	assert.are.equal 0, e\x!
	assert.are.equal 0, e\y!
	e

describe "Entity", ->
	e = nil
	before_each ->
		e = entity_sanity_check!

	it "construct", ->
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

	it "accessors", ->
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

		-- No scene
		assert.is.False e\onCamera!

		l = 5
		assert.is.Nil e\scene!
		assert.are.equal 10, e\layer!
		assert.are.equal l, e\layer l
		assert.are.equal 10, e\layer 10
		e\layer l
		assert.are.equal LP.BASELAYER!, e\layer false

		t = "Entity"
		assert.are.equal '', e\type!
		assert.are.equal t, e\type t
		assert.are.equal t, e\type!
		assert.are.equal t, e\type nil
		assert.are.equal '', e\type ''

		m = Mask!
		assert.is.Nil e\mask!
		assert.are.equal m, e\mask m
		assert.are.equal m, e\mask!
		assert.are.equal e, m.parent
		assert.are.equal m, e\mask nil
		assert.is.Nil e\mask false
		assert.is.Nil m.parent
		assert.is.Nil e\mask!

		g = Graphic!
		assert.is.Nil e\graphic!
		assert.are.equal g, e\graphic g
		assert.are.equal g, e\graphic!
		assert.is.Nil e\graphic false

		s = Scene!
		assert.is.Nil e\scene!
		assert.is.Nil e\world!
		assert.are.equal s, e\scene s
		assert.are.equal s, e\scene!
		assert.are.equal s, e\world!
		assert.is.Nil e\scene false
		assert.are.equal s, e\world s
		e\scene false

		-- Come back to some that branch if scene is set
		e\scene s
		assert.are.equal t, e\type t
		-- Hits a branch if e\type! is not ""
		assert.are.equal t, e\type t
		assert.are.equal l, e\layer l
		-- Hits a branch if e\layer! is not nil
		assert.are.equal l, e\layer l

		pending "Entity\\onCamera after scene is set"


	it "collidable", ->
		e = with Entity 5, 5
			.width = 10
			.height = 10
			\type "Entity"

		-- Collider
		c = with Entity 5, 5
			.width = 10
			.height = 10
			\type "Entity"

		-- No Scene
		assert.is.Nil e\collide "Entity", 10, 10

		LP.scene = Scene!
		LP.scene\add e
		LP.scene\add c
		LP.scene\updateLists!

		-- Not collidable
		e.collidable = false
		assert.is.Nil e\collide "Entity", 10, 10

		-- A collision
		e.collidable = true
		assert.are.equal c, e\collide "Entity", 10, 10
		assert.are.equal e, c\collide "Entity", 10, 10

		-- Bounds
		assert.are.equal c, e\collide "Entity", 5 - c.width, 5
		assert.are.equal c, e\collide "Entity", 5, 5 - c.height
		assert.are.equal e, c\collide "Entity", 5, 5
		assert.are.equal c, e\collide "Entity", 15, 15
		assert.are.equal e, c\collide "Entity", 15, 15

		-- Not a collision
		assert.is.Nil e\collide "Entity", 4 - c.width, 5
		assert.is.Nil e\collide "Entity", 5, 4 - c.height
		assert.is.Nil c\collide "Entity", 4 - e.width, 5
		assert.is.Nil c\collide "Entity", 5, 4 - e.height
		assert.is.Nil e\collide "Entity", 16, 15
		assert.is.Nil e\collide "Entity", 15, 16
		assert.is.Nil c\collide "Entity", 16, 15
		assert.is.Nil c\collide "Entity", 15, 16

		-- Mask collision
		m = Mask!
		e\mask Mask!
		c\mask Mask!
		assert.are.equal c, e\collide "Entity", 10, 10
		assert.are.equal e, c\collide "Entity", 10, 10

		-- Not a collision
		assert.is.Nil e\collide "Entity", 30, 30
		assert.is.Nil e\collide "Entity", 16, 16
		assert.are.equal c, e\collide "Entity", 15, 15

	it "moveBy", ->
		e\moveBy 1, 0
		assert.are.equal 1, e\x!
		assert.are.equal 0, e\y!

		e\moveBy 0, 1
		assert.are.equal 1, e\x!
		assert.are.equal 1, e\y!

		e\moveBy 1, 1
		assert.are.equal 2, e\x!
		assert.are.equal 2, e\y!

		e\moveBy -1, -1
		assert.are.equal 1, e\x!
		assert.are.equal 1, e\y!

		e\moveBy 0, 0
		assert.are.equal 1, e\x!
		assert.are.equal 1, e\y!

		pending "Entity\\moveBy solidType and sweep"

	it "moveTo", ->
		e\moveTo 5, 0
		assert.are.equal 5, e\x!
		assert.are.equal 0, e\y!

		e\moveTo 0, 5
		assert.are.equal 0, e\x!
		assert.are.equal 5, e\y!

		e\moveTo 0, 0
		assert.are.equal 0, e\x!
		assert.are.equal 0, e\y!

		pending "Entity\\moveTo solidType and sweep"

	it "moveTowards", ->
		e\moveTowards 5, 0, 2
		assert.are.equal 2, e\x!
		assert.are.equal 0, e\y!

		e\moveTowards 5, 0, 2
		assert.are.equal 4, e\x!
		assert.are.equal 0, e\y!

		e\moveTowards 5, 0, 2
		assert.are.equal 5, e\x!
		assert.are.equal 0, e\y!

		e\moveTowards 5, 0, 2
		assert.are.equal 5, e\x!
		assert.are.equal 0, e\y!

		e\moveTowards 5, 5, 2
		assert.are.equal 5, e\x!
		assert.are.equal 2, e\y!

		e\moveTowards 5, 5, 2
		assert.are.equal 5, e\x!
		assert.are.equal 4, e\y!

		e\moveTowards 5, 5, 2
		assert.are.equal 5, e\x!
		assert.are.equal 5, e\y!

		e\moveTowards 7, 7, 1
		assert.are.equal 6, e\x!
		assert.are.equal 6, e\y!

	it "moveAtAngle", ->
		e\moveAtAngle 0, 1
		assert.are.equal 1, e\x!
		assert.are.equal 0, e\y!

		e\moveAtAngle 90, 1
		assert.are.equal 1, e\x!
		assert.are.equal 1, e\y!

		e\moveAtAngle 30, 2
		assert.are.equal 3, e\x!
		assert.are.equal 2, e\y!

		e\moveAtAngle -90, 1
		assert.are.equal 3, e\x!
		assert.are.equal 1, e\y!

		e\moveAtAngle 180, 1
		assert.are.equal 2, e\x!
		assert.are.equal 1, e\y!


	it "clamp hitbox", ->
		e = with Entity 0, 0
			.width = 25
			.height = 25

		-- Horizontal clamp
		e\clampHorizontal 0, 25
		assert.are.equal 0, e\x!

		e\clampHorizontal 0, 20
		assert.are.equal -5, e\x!

		e\clampHorizontal 0, 25
		assert.are.equal 0, e\x!

		e\clampHorizontal 5, 30
		assert.are.equal 5, e\x!

		e\clampHorizontal 5, 20
		assert.are.equal -5, e\x!
		e\x 0

		-- Vertical clamp
		e\clampVertical 0, 25
		assert.are.equal 0, e\y!

		e\clampVertical 0, 20
		assert.are.equal -5, e\y!

		e\clampVertical 0, 25
		assert.are.equal 0, e\y!

		e\clampVertical 5, 30
		assert.are.equal 5, e\y!

		e\clampVertical 5, 20
		assert.are.equal -5, e\y!

	it "centerGraphicInRect", ->
		g = Graphic!
		e = with Entity!
			.width = 10
			.height = 10
			\graphic g

		assert.are_not.equal e\halfWidth!, e\graphic!.x
		assert.are_not.equal e\halfHeight!, e\graphic!.y
		e\centerGraphicInRect!
		assert.are.equal e\halfWidth!, e\graphic!.x
		assert.are.equal e\halfHeight!, e\graphic!.y

