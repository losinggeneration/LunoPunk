require "busted"
require "tests.mock_love"

import EventListener from require "LunoPunk.utils.EventListener"

describe "EventListener", ->
	e = EventListener

	after_each -> e\remove "test"

	it "add/remove", ->
		-- Add a couple
		el1 = -> assert false, "EventListener1"
		e\add "test", el1
		el2 = -> assert false, "EventListener2"
		e\add "test", el2
		assert.are.equal 2, e.__listeners["test"]\len!

		-- Remove each
		e\remove "test", el1
		assert.are.equal 1, e.__listeners["test"]\len!
		-- Check a non-existant callback
		assert.is.Nil e\remove "test", 'fu'
		e\remove "test", el2
		assert.are.equal 0, e.__listeners["test"]\len!
		assert.has_no.errors -> e\dispatch "test"

		-- Remove all with remove "", nil
		e\add "test", el1
		e\add "test", el2
		assert.are.equal 2, e.__listeners["test"]\len!
		e\remove "test"
		assert.is.Nil e.__listeners["test"]

		-- Test when the no events are added
		assert.is.Nil e\remove "test", 'nil'

	it "single dispatch", (done) ->
		s = spy.new ->
		e\add "test", s

		e\dispatch "test"
		assert.spy(s).was.called!

	it "multi dispatch", (done) ->
		s1 = spy.new ->
		e\add "test", s1
		s2 = spy.new ->
		e\add "test", s2

		e\dispatch "test"
		assert.spy(s1).was.called!
		assert.spy(s2).was.called!
