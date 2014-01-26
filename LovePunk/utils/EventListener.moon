require "LovePunk.utils.List"

export ^

class eventlistener
	new: =>
		@__listeners = {}

	add: (type, f) =>
		@__listeners[type] = List! if @__listeners[type] == nil
		@__listeners[type]\push f

	dispatch: (event) =>
		return if @__listeners[type] == nil
		for e in @__listeners[type]\pairs!
			e!

EventListener = eventlistener!

AddEventListener = (type, f) -> EventListener\add type, f
DispatchEvent = (event) -> EventListener\dispatch event\type! if event.type != nil