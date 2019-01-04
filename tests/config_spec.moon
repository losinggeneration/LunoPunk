require "busted"
require "tests.mock_love"

import config, extract_love_version, set_love_title from require "LunoPunk.Config"

LunoPunk = nil

setVersion = (str) ->
	love.getVersion = -> string.match str, "(%d+).(%d+).?(%d+)"
	LunoPunk = extract_love_version str

check_love = (str, release, major, minor, patch) ->
	setVersion str
	assert.are.equal release, LunoPunk.love_version.release
	assert.are.equal tonumber(major), tonumber(LunoPunk.love_version.major)
	assert.are.equal tonumber(minor), tonumber(LunoPunk.love_version.minor)
	assert.are.equal tonumber(patch), tonumber(LunoPunk.love_version.patch)

describe "Config", ->

	before_each ->
		setVersion "0.8.0"

	it "extract_love_version", ->
		check_love "0.8.0", "0.8", 0, 8, 0
		check_love "0.9.0", "0.9", 0, 9, 0
		check_love "0.10.0", "0.10", 0, 10, 0

	it "set_love_title", ->
		versiond_check = (version) ->
			setVersion version
			t = set_love_title!
			assert.are.equal "LunoPunk (development)", t
			t = set_love_title nil, true
			assert.are.equal "LunoPunk", t

			t = set_love_title "FuBar"
			assert.are.equal "FuBar (development)", t
			t = set_love_title "FuBar", true
			assert.are.equal "FuBar", t

		love.graphics.setCaption = ->
		versiond_check "0.8.0"
		versiond_check "0.9.0"

	pending "config"

