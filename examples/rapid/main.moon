require "LunoPunk.LP"
require "LunoPunk.utils.Draw"
require "LunoPunk.Engine"
require "LunoPunk.Scene"

scene = class Rapid extends Scene
	begin: => print "This is just the beginning..."
	-- Print text within the screen
	-- halfWidth - 5 characters * (roughly) 8 pixels each
	render: => Draw.text "Hello LövePunk!", LP.halfWidth! - 5*8, LP.halfHeight!

LP.scene = scene!

Engine!
