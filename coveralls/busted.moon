require "coveralls.init"

output = ->
	Coveralls.service_name = Coveralls.Local if os.getenv 'LOCAL'
	Coveralls.service_name = Coveralls.Debug if os.getenv 'COVERALLS_DEBUG'
	defout = (assert require "busted.output.TAP")!
	formatted_status = defout.formatted_status
	header = defout.header

	defout.header = (desc, test_count) ->
		Coveralls\start!
		return header desc, test_count

	defout.formatted_status = (statuses, options, ms) ->
		Coveralls\stop!
		Coveralls\coverDir Coveralls.dirname, Coveralls.ext
		Coveralls\send!
		return formatted_status statuses, options, ms if formatted_status

	defout

return output!