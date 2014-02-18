require "LunoPunk.utils.Event"

export ^

class TweenEvent extends Event
	@START: "TweenEvent.start"
	@UPDATE: "TweenEvent.update"
	@FINISH: "TweenEvent.finish"
