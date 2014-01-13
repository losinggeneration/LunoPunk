--[[
DO NOT MAKE CHANGES TO THIS FILE!

This file will purposefully overwritten when moonc is run. However it provides
an easy way to do Moonscript development without having to use moonc to compile
to Lua.
]]--
assert(require "luarocks.loader")
moonscript = assert(require "moonscript")

assert(moonscript.loadfile("main.moon"))()
