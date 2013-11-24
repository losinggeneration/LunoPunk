#LövePunk
***
A Löve port of the [HaxePunk](http://haxepunk.com), which is a Haxe port of the AS3 library [FlashPunk](http://useflashpunk.net). The implementation is in Moonscript, but should also be usable from Lua as well.

[![Build Status](https://travis-ci.org/LovePunk/LovePunk.png?branch=master)](https://travis-ci.org/LovePunk/LovePunk)

## Release build
None yet

## Development build
The development build of LovePunk can be pulled from the Git repository. The master branch is where development happens, so it may be unstable at times. There is also no API guarantee until a release build is made. At which point the code base is branched.

```bash
git clone github.com/losinggeneration/LovePunk
```
Once the repository is cloned, the LovePunk/LovePunk directory can be copied into a Löve project directory.

main.moon
```moonscript
require "LovePunk.LP"
require "scenes.GameScene"

LP.scene = GameScene!
```

scenes/GameScene.moon
```moonscript
require "LovePunk.Scene"
require "LovePunk.graphics.Image"

class GameScene extends Scene
	new: =>
		super

	begin: =>
		addGraphic Image("graphics/block.png")
```

## Have questions or looking to get involved?

Great! The project needs all the help it can. However, many of the API decisions will still be up to my own judgment early on, but I'm open to suggestions.

* Contact Harley directly
	* Email: losinggeneration@gmail.com
	* Twitter: @losnggeneration

## Credits

* Matt Tuttle for creating HaxePunk.
* Chevy Ray Johnston for creating FlashPunk.

## MIT License

Copyright (C) 2013 Harley Laue

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
