--[[
DO NOT MAKE CHANGES TO THIS FILE!

This file will purposefully overwritten when moonc is run. However it provides
an easy way to do Moonscript development without having to use moonc to compile
to Lua.
]]--

--[[
License (MIT)

Copyright (C) 2013 by Leaf Corcoran

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the "Software"), to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions
of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
]]--
assert(require "luarocks.loader")

-- Below is basically the moon program which is shipped with Moonscript, thus the license
local moonscript = assert(require "moonscript")
local util = assert(require "moonscript.util")
local errors = assert(require "moonscript.errors")

local chunk, err = moonscript.loadfile("main.moon")

if err then
	assert(false, err)
end

local trace
xpcall(function() chunk() end, function(e)
	err = e
	trace = debug.traceback("", 2)
end)

local function assert_moonscript_error(...)
	local msg = table.concat({...}, "\t")
	assert(false, msg)
end

if err then
	local truncated = errors.truncate_traceback(util.trim(trace))
	local rewritten = errors.rewrite_traceback(truncated, err)

	if rewritten then
		assert_moonscript_error(rewritten)
	else
		assert_moonscript_error(table.concat({err, util.trim(trace)}, "\n"))
	end
end
