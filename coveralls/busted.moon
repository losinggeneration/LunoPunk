require "coveralls.init"

output = ->
	defout = (assert require "busted.output.TAP")!
	formatted_status = defout.formatted_status

	defout.formatted_status = (statuses, options, ms) ->
		Coveralls\send!
		return formatted_status statuses, options, ms if formatted_status

	defout

return output!