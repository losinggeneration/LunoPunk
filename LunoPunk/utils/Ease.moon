export ^

-- Static class with useful easer functions that can be used by Tweens.
--
-- Operation of in/out easers:
--
-- in(t)
--		return t
-- out(t)
-- 		return 1 - in(1 - t)
-- inOut(t)
-- 		return (t <= .5) ? in(t * 2) / 2 : out(t * 2 - 1) / 2 + .5
class ease
	-- Easing constants.
	B1 = 1 / 2.75
	B2 = 2 / 2.75
	B3 = 1.5 / 2.75
	B4 = 2.5 / 2.75
	B5 = 2.25 / 2.75
	B6 = 2.625 / 2.75
	PI = math.pi
	PI2 = math.pi / 2
	EL = 2 * PI / 0.45

	-- Quadratic in.
	quadIn: (t) ->t^2

	-- Quadratic out.
	quadOut: (t) -> -t * (t - 2)

	-- Quadratic in and out.
	quadInOut: (t) -> if t <= .5 then t^2 * 2 else 1 - t * (t-1) * 2

	-- Cubic in.
	cubeIn: (t) -> t^3

	-- Cubic out.
	cubeOut: (t) -> 1 + t * (t-1)^2

	-- Cubic in and out.
	cubeInOut: (t) -> if t <= .5 then t^3 * 4 else 1 + t * (t-1)^2 * 4

	-- Quart in.
	quartIn: (t) -> t^4

	-- Quart out.
	quartOut: (t) ->
		t -= 1
		1 - t^4

	-- Quart in and out.
	quartInOut: (t) -> if t <= .5
			t^4 * 8
		else
			t = t * 2 - 2
			(1 - t^4) / 2 + .5

	-- Quint in.
	quintIn: (t) -> t^5

	-- Quint out.
	quintOut: (t) ->
		t -= 1
		t^5 + 1

	-- Quint in and out.
	quintInOut: (t) ->
		t *= 2
		if t < 1
			(t^5) / 2
		else
			t -= 2
			(t^5 + 2) / 2

	-- Sine in.
	sineIn: (t) -> -math.cos(PI2 * t) + 1

	-- Sine out.
	sineOut: (t) -> math.sin(PI2 * t)

	-- Sine in and out.
	sineInOut: (t) -> -math.cos(PI * t) / 2 + .5

	-- Bounce in.
	bounceIn: (t)->
		t = 1 - t
		return 1 - 7.5625 * t * t if t < B1
		return 1 - (7.5625 * (t - B3) * (t - B3) + .75) if t < B2
		return 1 - (7.5625 * (t - B5) * (t - B5) + .9375) if t < B4
		return 1 - (7.5625 * (t - B6) * (t - B6) + .984375)

	-- Bounce out.
	bounceOut: (t)->
		return 7.5625 * t * t if t < B1
		return 7.5625 * (t - B3) * (t - B3) + .75 if t < B2
		return 7.5625 * (t - B5) * (t - B5) + .9375 if t < B4
		return 7.5625 * (t - B6) * (t - B6) + .984375

	-- Bounce in and out.
	bounceInOut: (t)->
		if t < .5
			t = 1 - t * 2
			return (1 - 7.5625 * t * t) / 2 if t < B1
			return (1 - (7.5625 * (t - B3) * (t - B3) + .75)) / 2 if t < B2
			return (1 - (7.5625 * (t - B5) * (t - B5) + .9375)) / 2 if t < B4
			return (1 - (7.5625 * (t - B6) * (t - B6) + .984375)) / 2

		t = t * 2 - 1
		return (7.5625 * t * t) / 2 + .5 if t < B1
		return (7.5625 * (t - B3) * (t - B3) + .75) / 2 + .5 if t < B2
		return (7.5625 * (t - B5) * (t - B5) + .9375) / 2 + .5 if t < B4
		return (7.5625 * (t - B6) * (t - B6) + .984375) / 2 + .5

	-- Circle in.
	circIn: (t) -> -(math.sqrt(1 - t^2) - 1)

	-- Circle out.
	circOut: (t) -> math.sqrt(1 - (t - 1)^2)

	-- Circle in and out.
	circInOut: (t)-> if t <= .5
			(math.sqrt(1 - t^2 * 4) - 1) / -2
		else
			(math.sqrt(1 - (t * 2 - 2)^2) + 1) / 2

	-- Exponential in.
	expoIn: (t) -> math.pow(2, 10 * (t - 1))

	-- Exponential out.
	expoOut: (t) -> -math.pow(2, -10 * t) + 1

	-- Exponential in and out.
	expoInOut: (t)-> if t < .5
			math.pow(2, 10 * (t * 2 - 1)) / 2
		else
			(-math.pow(2, -10 * (t * 2 - 1)) + 2) / 2

	-- Back in.
	backIn: (t) -> t^2 * (2.70158 * t - 1.70158)

	-- Back out.
	backOut: (t)->
		t2 = t - 1
		1 - (t) * (t2) * (-2.70158 * t2 - 1.70158)

	-- Back in and out.
	backInOut: (t)->
		t *= 2
		return t^2 * (2.70158 * t - 1.70158) / 2 if t < 1
		t -= 2
		return (1 - (t + 1) * (t) * (-2.70158 * t - 1.70158)) / 2 + .5

Ease = ease!