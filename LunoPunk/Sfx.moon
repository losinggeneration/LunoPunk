require "LunoPunk.LP"

export ^

-- Sound effect object used to play embedded sounds.
class Sfx
	-- Creates a sound effect from an embedded source. Store a reference to
	-- this object so that you can play the sound using play() or loop().
	-- @param	source		The embedded sound class to use.
	-- @param	complete	Optional callback function for when the sound finishes playing.
	new: (source, complete = nil) =>
		-- Optional callback function for when the sound finishes playing.
		@complete = complete
		-- @__transform = SoundTransform!
		@__volume = 1
		@__pan = 0
		@__position = 0
		@__type = ""

		-- Sound infromation.
		@__type
		@__volume = 1
		@__pan = 0
		@__filteredVol
		@__filteredPan
		@__sound
		@__channel
		-- @__transform
		@__position = 0
		@__looping

		-- Stored Sound objects.
		@@__sounds = {}
		@@__typePlaying = {}
		-- @@__typeTransforms = {}

		assert source != nil, "Invalid source Sound."

		if type(source) == "string"
			@__sound = love.audio.newSource source, "static"
			@@__sounds[source] = @__sound
		else
			className = source.__class.__name
			@__sound = @__sounds[className]
			if @__sound == nil
				@__sound = source
				@@__sounds[className] = source

	-- Plays the sound once.
	-- @param	vol	   Volume factor, a value from 0 to 1.
	-- @param	pan	   Panning factor, a value from -1 to 1.
	-- @param   loop   If the audio should loop infinitely
	play: (volume = 1, pan = 0, loop = false) =>
		return if @__sound == nil
		@stop! if @playing!
		@__pan = LP.clamp pan, -1, 1
		@__volume = (if volume < 0 then 0 else volume)
		@__filteredPan = LP.clamp @__pan + @getPan(@__type), -1, 1
		@__filteredVol = math.max 0, @__volume * @getVolume @_type
		--@__transform.pan = @__filteredPan
		--@__transform.volume = @__filteredVol
		@__sound\setLooping loop
		@__sound\setVolume @__volume
		@__sound\play!

		if @playing!
			addPlaying @
			--@__channel.addEventListener Event.SOUND_COMPLETE, @\onComplete

		@__looping = loop
		@__position = 0

	-- Plays the sound looping. Will loop continuously until you call stop(), play(), or loop() again.
	-- @param	vol		Volume factor, a value from 0 to 1.
	-- @param	pan		Panning factor, a value from -1 to 1.
	loop: (vol = 1, pan = 0) =>
		@play vol, pan, true

	-- Stops the sound if it is currently playing.
	--
	-- @return If the sound was stopped.
	stop: =>
		return false if not @playing!
		removePlaying @
		@__position = @__sound\tell!
		--@__channel.removeEventListener(Event.SOUND_COMPLETE, @\onComplete)
		--@__channel.stop()
		--@__channel = nil
		@__sound\stop!
		true

	-- Resumes the sound from the position stop() was called on it.
	resume: =>
		@__sound\seek @__position
		@__sound\play!

		if @playing!
			addPlaying @
			-- @__channel.addEventListener(Event.SOUND_COMPLETE, onComplete)

		@__position = 0

	-- @private Event handler for sound completion.
	onComplete = (e = nil) =>
		if @__looping
			@loop @__volume, @__pan
		else
			@stop!

		@__position = 0
		@complete! if @complete != nil

	-- @private Add the sound to the global list.
	addPlaying = =>
		list = {}
		if not @@__typePlaying[@__type]
			@@__typePlaying[@__type] = list
		else
			list = @__typePlaying[@__type]

		table.insert list, @

	-- @private Remove the sound from the global list. */
	removePlaying = =>
		@@__typePlaying[@__type] = nil if (@@__typePlaying[@__type])

	-- Alter the volume factor (a value from 0 to 1) of the sound during playback.
	volume: (value) =>
		return @__volume if value == nil
		value = 0 if value < 0
		return value if @__channel == nil or @__volume == value
		@__volume = LP.clamp value, 0, 1
		filteredVol = value * @getVolume @__type
		filteredVol = 0 if filteredVol < 0
		return value if @__filteredVol == filteredVol
		@__filteredVol, @__transform.volume = filteredVol, filteredVol
		@__channel.soundTransform = @__transform
		@__volume

	-- Alter the panning factor (a value from -1 to 1) of the sound during playback.
	pan: (value) =>
		return @__pan if value == nil
		value = LP.clamp value, -1, 1
		return value if @__channel == nil or @__pan == value
		filteredPan = LP.clamp value + @getPan(@__type), -1, 1
		return value if @__filteredPan == filteredPan
		@__pan = value
		@__filteredPan, @__transform.pan = filteredPan, filteredPan
		@__channel.soundTransform = @__transform
		@__pan

	-- Change the sound type. This an arbitrary string you can use to group
	-- sounds to mute or pan en masse.
	type: (value) =>
		return @__type if value == nil or @__type == value
		if @playing!
			@removePlaying!
			@__type = value
			@addPlaying!
			-- reset, in case type has different global settings
			@pan @pan!
			@volume @volume!
		else
			@__type = value

		value

	-- If the sound is currently playing.
	playing: => @__sound.typeOf and @__sound\typeOf("Source") and not @__sound\isStopped!

	-- Position of the currently playing sound, in seconds.
	position: => (if @playing! then @__channel.position else @__position) / 1000

	-- Length of the sound, in seconds.
	length: => @__sound.length / 1000

	-- Return the global pan for a type.
	--
	-- @param	type	The type to get the pan from.
	--
	-- @return	The global pan for the type.
	getPan: (type) ->
--		if @@__typeTransforms.exists type
--			transform = @@__typeTransforms.get type
--			return if transform != nil then transform.pan else 0

		0

	-- Return the global volume for a type.
	--
	-- @param	type	The type to get the volume from.
	--
	-- @return	The global volume for the type.
	getVolume: (type) ->
--		if @@__typeTransforms.exists type
--			transform = @@__typeTransforms.get type
--			return if transform != nil then transform.volume else 1

		1

	-- Set the global pan for a type. Sfx instances of this type will add
	-- this pan to their own.
	--
	-- @param	type	The type to set.
	-- @param	pan		The pan value.
	setPan: (type, pan) ->
		transform = @__typeTransforms.get type
		if (transform == nil)
			transform = SoundTransform!
			@@__typeTransforms.set(type, transform)

		transform.pan = LP.clamp pan, -1, 1

		if @__typePlaying.exists type
			sfx.pan sfx.pan! for sfx in @@__typePlaying.get type

	-- Set the global volume for a type. Sfx instances of this type will
	-- multiply their volume by this value.
	--
	-- @param	type	The type to set.
	-- @param	volume	The volume value.
	setVolume: (type, volume) ->
		transform = @@__typeTransforms.get(type)

		if transform == nil
			transform = SoundTransform!
			@@__typeTransforms.set type, transform

		transform.volume = (if volume < 0 then 0 else volume)

		if @@__typePlaying.exists type
			sfx.volume sfx.volume! for sfx in @@__typePlaying.get type
