import List from require "LunoPunk.utils.List"

class eventlistener
	new: =>
		@__listeners = {}

	add: (type, f) =>
		@__listeners[type] = List! if @__listeners[type] == nil
		@__listeners[type]\push f

	remove: (type, f) =>
		if f == nil
			@__listeners[type] = nil
			return nil

		l = @__listeners[type]
		return nil if l == nil
		for i, v in l\ipairs!
			if v == f
				return l\remove i

		nil

	dispatch: (type, ...) =>
		return if @__listeners[type] == nil
		for e in @__listeners[type]\pairs!
			e type, ...

EventListener = eventlistener!

AddEventListener = (type, f) -> EventListener\add type, f
RemoveEventListener = (type, f) -> EventListener\remove type, f
DispatchEvent = (event, ...) -> EventListener\dispatch event\type!, ... unless event.type == nil

{ :EventListener, :AddEventListener, :RemoveEventListener, :DispatchEvent }
