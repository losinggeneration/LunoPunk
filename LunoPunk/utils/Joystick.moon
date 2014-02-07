export ^

class JoyButtonState
	BUTTON_ON: 1
	BUTTON_OFF: 2
	BUTTON_PRESSED: 3
	BUTTON_RELEASED: 4

loveJoystick = nil

if LP.__love "0.8"
	loveJoystick = class
		new: =>
			@@joysticks = {}
			@joystick = nil

		__loveOpen: =>
			i = 1
			for k, v in pairs @@joysticks
				break if k != i
				i += 1
			return if i > love.joystick.getNumJoysticks!
			@@joysticks[i] = true
			@connected = true
			@joystick = i

		close: =>
			return if not @connected
			love.joystick.close @joystick
			@joystick = nil
			@connected = false

		__loveButton: (button) => love.joystick.isDown @joystick button


else if LP.__love "0.9"
	loveJoystick = class
		new: =>
			@@joysticks = love.joystick.getJoysticks! if @@joysticks == nil
			@@opened = {}

		__loveOpen: =>
			i = 1
			for k, v in pairs @@opened
				break if k != i
				i += 1

			if i > #@@joysticks
				print "No more joysticks"

			return if i > #@@joysticks
			@@opened[i] = @@joysticks[i]
			@__number = i
			@joystick = @@joysticks
			@connected = true

			@buttons[i] = JoyButtonState.BUTTON_OFF for i=1, @joystick\getButtonCount!
			@__last_buttons = {k, v for k, v in pairs @buttons}

		close: =>
			@@opened[@__number] = nil
			@joystick = nil
			@__number = 0
			@connected = false

		__loveButton: (button) => @joystick\isDown button

class Joystick extends loveJoystick
	new: =>
		super!
		-- Each axis contained in an array
		@__axis = {}
		-- A point containing the joystick's ball value
		@ball = Point!
		-- A map of the buttons and their state
		@buttons = {}
		-- A map of the buttons and their state from the previous update
		@__last_buttons = {}
		-- A point containing the joystick's hat value
		@hat = {}
		-- Determines the joystick's deadZone.
		-- Anything under this value will be considered 0 to prevent jitter.
		@deadZone = 0
		-- If the joystick is currently connected.
		@connected = false

		@__loveOpen!

	-- If the joystick button is held down.
	-- @param button The button index to check.
	check: (button) => @buttons[button] == JoyButtonState.BUTTON_ON

	-- Returns the axis value (from 0 to 1)
	-- @param a The axis index to retrieve starting at 0
	getAxis: (a) => @__axis[a]

	-- If the joystick button was pressed this frame.
	-- @param button The button index to check.
	pressed: (button) => @buttons[button] == JoyButtonState.BUTTON_PRESSED

	-- If the joystick button was released this frame.
	-- @param button The button index to check.
	released: (button) => @buttons[button] == JoyButtonState.BUTTON_PRESSED

	-- Updates the joystick's state.
	update: =>
		updateButtons @
		updateAxes @
		updateBalls @
		updateHats @

	updateButtons = =>
		@__last_buttons = {k, v for k, v in pairs @buttons}
		for i=1, #@buttons
			button = @__loveButton i
			if button
				if @__last_buttons[i] == JoyButtonState.BUTTON_PRESSED or @__last_buttons[i] == JoyButtonState.BUTTON_ON
					@buttons[i] = JoyButtonState.BUTTON_ON
				else
					@buttons[i] = JoyButtonState.BUTTON_PRESSED
			else
				if @__last_buttons[i] == JoyButtonState.BUTTON_PRESSED or @__last_buttons[i] == JoyButtonState.BUTTON_ON
					@buttons[i] = JoyButtonState.BUTTON_RELEASED
				else
					@buttons[i] = JoyButtonState.BUTTON_OFF

	updateAxes = =>

	updateBalls = =>

	updateHats = =>