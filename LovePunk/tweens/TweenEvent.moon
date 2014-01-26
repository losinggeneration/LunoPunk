require "LovePunk.utils.Event"

export ^

class TweenEvent extends Event
	start = "start"
	update = "update"
	finish = "finish"

	START: -> super.__formatType TweenEvent, start
	UPDATE: -> super.__formatType TweenEvent, update
	FINISH: -> super.__formatType TweenEvent, finish
