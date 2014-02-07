file = assert io.open "mock_love.lua", "w+"

fprint = (...) =>
	@\write ...
	@\write "\n"

print_tbl = (t, indent = 0) ->
	for k, v in pairs t
		file\write string.rep "  ", indent
		switch type v
			when "table"
				fprint file, k .. " = {"
				print_tbl v, indent+1
				fprint file, string.rep("  ", indent) .. "},"
			when "function"
				fprint file, k .. " = function() end,"
			when "userdata"
				fprint file, k .. " = nil,"
			else
				switch type k
					when "number"
						fprint file, string.format '"%s",', tostring(v)
					else
						fprint file, k .. " = '" .. tostring(v) .. "',"

fprint file, string.format [[-- Busted mock for Löve %s

require "busted"

local loveTbl = {]], love._version

print_tbl love, 1

fprint file, "}"

fprint file, [[love = mock(loveTbl)
return love]]

file\close!
os.exit!