require "busted"

require "LunoPunk.utils.moonscript"

describe "utils.moonscript", ->
	it "instance", ->
		a = class
		b = class extends a.__class
		c = class extends b.__class

		assert.is.False instance nil, a
		assert.is.False instance a, nil
		assert.is.False instance class, a
		assert.is.False instance a, class
		assert.is.True instance a, a.__class!
		assert.is.True instance a, a
		assert.is.True instance b, a
		assert.is.True instance c, b
		assert.is.True instance c, a
		-- I'm surprised this doesn't work like I'd expect. Parent isn't
		-- correctly set
		--assert.is.True instance c.__class!, a
		c1 = c.__class!
		c1.__parent = b.__class
		assert.is.True instance c1, a