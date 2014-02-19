require "busted"
require "tests.mock_love"

require "LunoPunk.utils.Math"

describe "math", ->
	setup ->
		require "coveralls.init"
		Coveralls\start!

	teardown ->
		Coveralls\stop!
		Coveralls\cover "./LunoPunk/utils/Math.moon"

	describe "round", ->
		it "integer", ->
			assert.are.equals 1, Math.round 1
			assert.are.equals 10, Math.round 10

		it "round down", ->
			assert.are.equals 1, Math.round 1.09
			assert.are.equals 1, Math.round 1.1
			assert.are.equals 5, Math.round 5.4
			assert.are.equals 6, Math.round 6.49
			assert.are.equals 10, Math.round 10.49999999

		it "round up", ->
			assert.are.equals 1, Math.round 0.5
			assert.are.equals 2, Math.round 1.5
			assert.are.equals 2, Math.round 1.9
			assert.are.equals 2, Math.round 1.9999