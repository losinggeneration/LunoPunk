require "LovePunk.utils.List"

export ^

class eventlistener
	new: =>
		@__listeners = {}

	add: (type, f) =>
		@__listeners[type] = List! if @__listeners[type] == nil
		@__listeners[type]\push f

	remove: (type, f) =>
		l = @__listeners[type]
		return if l == nil
		for i, v in l\ipairs!
			if v == f
				l\remove i
				break

	dispatch: (event) =>
		return if @__listeners[type] == nil
		for e in @__listeners[type]\pairs!
			e!

EventListener = eventlistener!

AddEventListener = (type, f) -> EventListener\add type, f
RemoveEventListener = (type, f) -> EventListener\remove type, f
DispatchEvent = (event) -> EventListener\dispatch event\type! if event.type != nil