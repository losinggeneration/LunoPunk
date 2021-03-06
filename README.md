# LunoPunk
***
### WARNING!!!
The API is subject to change without warning. This is very much still a WIP.

***
A [Moonscript](http://moonscript.org)/[LÖVE](http://www.love2d.org) port of the [HaxePunk](http://haxepunk.com), which is a Haxe port of the AS3 library [FlashPunk](http://useflashpunk.net). The implementation is in Moonscript, but should also be usable from Lua as well.
*Luno in Esperanto means Moon.*

[![Build Status](https://travis-ci.org/losinggeneration/LunoPunk.png?branch=master)](https://travis-ci.org/losinggeneration/LunoPunk)
[![Coverage Status](https://coveralls.io/repos/losinggeneration/LunoPunk/badge.png?branch=master)](https://coveralls.io/r/losinggeneration/LunoPunk?branch=master)

## Release build
None yet

## Development build
The development build of LunoPunk can be pulled from the Git repository. The master branch is where development happens, so it may be unstable at times. There is also no API guarantee until a release build is made. At which point the code base is branched.

```bash
git clone github.com/losinggeneration/LunoPunk
```
Once the repository is cloned, the LunoPunk/LunoPunk directory can be copied into a project directory.

## Example
*The following example is more-or-less in the examples/rapid directory*
***
*main.moon*
```moonscript
import LP from require "LunoPunk.LP"
import Engine from require "LunoPunk.Engine"
import GameScene from require "scenes.GameScene"

LP.scene = GameScene!

Engine!
```

*scenes/GameScene.moon*
```moonscript
import Scene from require "LunoPunk.Scene"
import Image from require "LunoPunk.graphics.Image"

class GameScene extends Scene
	begin: =>
		@addGraphic Image "graphics/block.png"

{ :GameScene }
```

Compiling to Lua
```bash
export PROJECT_NAME=some_project
export LUAROCKS_PATH=$HOME/.luarocks/share/lua/5.1/
moonc -t $PROJECT_NAME LunoPunk src_dir main.moon
cp -r $LUAROCKS_PATH/moon* $PROJECT_NAME/
cd $PROJECT_NAME
zip -9r ../$PROJECT_NAME.love .
```

## Have questions or looking to get involved?

Great! The project needs all the help it can. However, many of the API decisions will still be up to my own judgment early on, but I'm open to suggestions.

* Contact Harley directly
	* Email: losinggeneration@gmail.com
	* Twitter: [@losnggeneration](http://twitter.com/losnggeneration)

## Credits/Thanks

* Matt Tuttle for creating HaxePunk.
* Chevy Ray Johnston for creating FlashPunk.
* leaf corcoran for creating Moonscript.
* The Prosody IM team from which some code was used for the Coveralls support.

## MIT License

Copyright (C) 2013-2014 Harley Laue

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
