require "busted"
require "tests.mock_love"

require "LunoPunk.Entity"

describe "Entity", ->
	teardown ->
		require "coveralls.init"
		Coveralls\cover "./LunoPunk/Entity.moon"

	it "construct", ->
		