require "busted"
require "tests.mock_love"

require "LunoPunk.Entity"

describe "Entity", ->
	setup ->
		require "coveralls.init"
		Coveralls\start!

	teardown ->
		Coveralls\stop!
		Coveralls\cover "./LunoPunk/Entity.moon"

	it "construct", ->
		