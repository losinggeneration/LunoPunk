class Event
	@ACTIVATE: "Event.activate"
	@DEACTIVATE: "Event.deactivate"
	@RESIZE: "Event.resize"

	new: (type) =>
		@__type = type

	type: => @__type

{ :Event }
