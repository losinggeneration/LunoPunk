class Math
	-- Round to the nearest integer if the fractional part of x is >= 5
	-- e.g. 1.5 => 2
	-- 1.45 => 1
	round: (x) ->
		i, f = math.modf x
		return i if math.modf(f*10) < 5
		i + 1

{ :Math }
