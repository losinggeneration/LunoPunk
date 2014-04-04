require "busted"
require "tests.mock_love"

import instance from require "LunoPunk.utils.moonscript"
import Tween  from require "LunoPunk.Tween"
moon = require "moon"

c = class
tw = Tween 5
t = class extends Tween
t2 = class extends t

describe "utils.moonscript", ->
	describe "instance", ->
		it "Sanity check", ->
			assert.are.same Tween, moon.type(class extends Tween).__parent
			assert.are.same Tween.__class, tw.__class

		it "Same class", ->
			assert.True instance Tween, Tween

		it "Object is not a 'class' object", ->
			assert.False instance Tween, class

		it "'class' object is not an instance object", ->
			assert.False instance class, Tween

		it "Extends", ->
			assert.True instance class extends Tween, Tween

		it "Parent doesn't extend a child", ->
			assert.False instance Tween, class extends Tween

		it "object is the class", ->
			assert.True instance tw, Tween

		it "class is the object", ->
			assert.True instance Tween, tw

		it "Instance is the object", ->
			assert.True instance t, tw

		it "object is not the instance", ->
			assert.False instance tw, t

		it "Object is not a 'class' object", ->
			assert.False instance c, t

		it "'class' object is not an instance object", ->
			assert.False instance t, c

		it "Instance is the object", ->
			assert.True instance t, Tween

		it "Object is not the instance", ->
			assert.False instance Tween, t

		it "Extends is the object", ->
			assert.True instance t2, Tween

		it "object is not an extended object", ->
			assert.False instance Tween, t2

		it "Extends is not a 'class' object", ->
			assert.False instance t2, c

		it "generic", ->
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
