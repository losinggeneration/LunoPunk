export ^

class Event
	new: (type) =>
		@__type = type

	type: => @__formatType @.__name, @__type

	__formatType: (t) => string.format "%s.%s", @@.__name, t