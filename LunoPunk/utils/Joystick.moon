export ^

class JoyButtonState
	BUTTON_ON: 1
	BUTTON_OFF: 2
	BUTTON_PRESSED: 3
	BUTTON_RELEASED: 4

loveJoystick = nil
if LP.__love "0.8"
	loveJoystick = class

else if LP.__love "0.9"
	loveJoystick = class

class Joystick extends loveJoystick
	new: =>
		@test!
		-- Each axis contained in an array
		@__axis = {}
		-- A point containing the joystick's ball value
		@ball = Point!
		-- A map of the buttons and their state
		@buttons = {}
		-- A point containing the joystick's hat value
		@hat = {}
		-- Determines the joystick's deadZone.
		-- Anything under this value will be considered 0 to prevent jitter.
		@deadZone = 0