require "LovePunk.LP"
require "LovePunk.utils.Draw"
require "LovePunk.Engine"
require "LovePunk.Scene"

scene = class Rapid extends Scene
	begin: => print "This is just the beginning..."
	-- Print text within the screen
	-- halfWidth - 5 characters * (roughly) 8 pixels each
	render: => Draw.text "Hello LövePunk!", LP.halfWidth! - 5*8, LP.halfHeight!

LP.scene = scene!

Engine!
