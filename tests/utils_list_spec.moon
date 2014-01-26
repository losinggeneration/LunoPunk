require "busted"

require "LovePunk.utils.List"

describe "list", ->
	l = nil
	before_each ->
		l = List!
		l\push i*2 for i=1, 10

	it "push/pop/peek/last", ->
		assert.are.equal 20, l\pop!
		assert.are.equal 18, l\pop!
		l\push 10 -- last element
		assert.are.equal 10, l\peek!
		assert.are.equal 10, l\last!

	it "ipairs", ->
		for i, v in l\ipairs!
			assert.are.equal i*2, l\index i

		assert.are.equal 10, l\len!

	it "ripairs", ->
		for i, v in l\ripairs!
			assert.are.equal i*2, l\index i

		assert.are.equal 10, l\len!

	it "pairs", ->
		i = 0
		len = l\len! -- original length
		for v in l\pairs!
			i += 1
			assert.are.equal i*2, l\index i

		assert.are.equal len, i -- I should be the original length
		assert.are.equal 10, l\len!

	it "rpairs", ->
		i = l\len!
		for v in l\rpairs!
			assert.are.equal i*2, l\index i
			i -= 1

		assert.are.equal 0, i
		assert.are.equal 10, l\len!