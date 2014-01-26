require "busted"

require "LovePunk.utils.List"

describe "list", ->
	l = nil
	before_each ->
		l = List!
		l\push i*2 for i=1, 10

	it "push/pop/peek/last", ->
		assert.are.equal 2, l\pop!
		assert.are.equal 4, l\pop!
		l\push 10 -- last element
		assert.are.equal 6, l\peek!
		assert.are.equal 10, l\last!

	it "iterate", ->
		for i, v in l\pairs!
			assert.are.equal i*2, l\pop!