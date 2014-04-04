require "busted"
require "tests.mock_love"

import Mask from require "LunoPunk.Mask"
import Masklist from require "LunoPunk.masks.Masklist"
import Entity from require "LunoPunk.Entity"

describe "Mask", ->
	it "Construct", ->
		m = Mask!
		assert.is.Nil m.parent
		assert.are.same m.list, Masklist!

	it "assignTo", ->
		e = Entity!
		m = Mask!
		m\assignTo e
		assert.are.same e, m.parent

		m\assignTo nil
		assert.is.Nil m.parent

	it "collide", ->
		e = Entity!
		m = Mask!

		-- can't call collide before a parent is set
		assert.has.errors -> m\collide nil

		m\assignTo e
		-- Will collide with itself
		assert.is.True m\collide m

		e = with Entity!
			.width = 10
			.height = 10

		m\assignTo e

		m2 = Mask!
		m2\assignTo e

		-- Two masks collide with the same entity is true
		assert.is.True m\collide m2
		assert.is.True m2\collide m

		e2 = with Entity 10, 10
			.width = 10
			.height = 10
		m2\assignTo e2
		-- colliding at point (10, 10)
		assert.is.True m\collide m2
		assert.is.True m2\collide m

		e2\moveBy 1, 1
		-- Not colliding
		assert.is.False m\collide m2
		assert.is.False m2\collide m

		-- Test with hitbox colliding
		e = with Entity 0, 0
			.width = 10
			.hight = 10
			.originX = 10
			.originY = 10

		e2 = with Entity 0, 0
			.width = 10
			.height = 10
			.originX = 15
			.originY = 15

		m\assignTo e
		m2\assignTo e2

		-- Colliding
		assert.is.True m\collide m
		assert.is.True m\collide m2
		assert.is.True m2\collide m

		-- Corner colliding
		e2.originX = 20
		e2.originY = 20
		assert.is.True m\collide m2
		assert.is.True m2\collide m

		e2.originX = 21
		-- Not colliding
		assert.is.False m\collide m2
		assert.is.False m2\collide m

		-- collide with a new mask class
		nmc = class extends Mask
			new: =>
				super!
				super\setup_check super

		-- reset the entity
		e2 = Entity!
		nm = nmc!
		nm\assignTo e2
		-- Reset e
		e = Entity!
		m\assignTo e
		assert.is.True m\collide nm
		assert.is.True nm\collide m

		e = with Entity!
			.width = 10
			.height = 10
		m\assignTo e
		e2 = with Entity!
			.width = 10
			.height = 10
		nm\assignTo e2
		assert.is.True m\collide nm
		assert.is.True nm\collide m

		e2\moveBy 10, 10
		assert.is.True m\collide nm
		assert.is.True m\collide m

		e2\moveBy 1, 1
		assert.is.False m\collide nm
		assert.is.False nm\collide m

	it "project", ->
		e = Entity!
		m = Mask!
		m\assignTo e

		-- projection
		p = { min: 0, max: 0}

		axis = {x: 1, y: 1}
		assert.are.same p, m\project axis

		e.width = 10
		p.max = 10
		assert.are.same p, m\project axis

		e.height = 10
		p.max = 20
		assert.are.same p, m\project axis

		e.originX = 10
		p.min = -10
		p.max = 10
		assert.are.same p, m\project axis

		e.originY = 10
		p.min = -20
		p.max = 0
		assert.are.same p, m\project axis

		axis.y = 2
		p.min = -30
		assert.are.same p, m\project axis
