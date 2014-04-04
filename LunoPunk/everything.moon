-- Auto-generated with ./create_everything.sh on 2014-04-04 01:34:08

-- We tell Moonscript to export classes globally. Thus, we prevent collisions
-- based on namespace since we don't know what is going to be used.
--
-- This provides two options for getting the class, calling require again and
-- assigning it to a local variable. Alternatively, the namespaced version can
-- be used.

import mixin_table from require "moon"

LunoPunk = {}
LunoPunk.debug = {}
LunoPunk.geometry = {}
LunoPunk.graphics = {}
LunoPunk.graphics.atlas = {}
LunoPunk.graphics.prototype = {}
LunoPunk.masks = {}
LunoPunk.math = {}
LunoPunk.tweens = {}
LunoPunk.tweens.misc = {}
LunoPunk.tweens.motion = {}
LunoPunk.tweens.sound = {}
LunoPunk.utils = {}
LunoPunk.utils.mixins = {}

-- Now load each file to the correctly namespaced table
-- mixin_table LunoPunk, if t = assert(require "LunoPunk.Config") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.debug, if t = assert(require "LunoPunk.debug.Console") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.debug, if t = assert(require "LunoPunk.debug.LayerList") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.geometry, if t = assert(require "LunoPunk.geometry.Matrix") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.geometry, if t = assert(require "LunoPunk.geometry.Point") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.geometry, if t = assert(require "LunoPunk.geometry.Rectangle") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.atlas, if t = assert(require "LunoPunk.graphics.atlas.AtlasData") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.atlas, if t = assert(require "LunoPunk.graphics.atlas.AtlasRegion") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.atlas, if t = assert(require "LunoPunk.graphics.atlas.Atlas") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.atlas, if t = assert(require "LunoPunk.graphics.atlas.TextureAtlas") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.atlas, if t = assert(require "LunoPunk.graphics.atlas.TileAtlas") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Animation") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Backdrop") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Canvas") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Emitter") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Graphiclist") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Image") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Particle") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.ParticleType") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.PreRotation") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Spritemap") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Stamp") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Text") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.TiledImage") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.TiledSpritemap") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics, if t = assert(require "LunoPunk.graphics.Tilemap") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.prototype, if t = assert(require "LunoPunk.graphics.prototype.Circle") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.graphics.prototype, if t = assert(require "LunoPunk.graphics.prototype.Rect") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Config") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Engine") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Entity") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Graphic") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.LP") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Mask") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.RenderMode") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Scene") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Screen") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Sfx") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Tweener") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.Tween") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk, if t = assert(require "LunoPunk.World") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Circle") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Grid") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Hitbox") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Imagemask") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Masklist") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Pixelmask") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.Polygon") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.masks, if t = assert(require "LunoPunk.masks.SlopedGrid") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.math, if t = assert(require "LunoPunk.math.Projection") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.math, if t = assert(require "LunoPunk.math.Vector") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens, if t = assert(require "LunoPunk.tweens.TweenEvent") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.misc, if t = assert(require "LunoPunk.tweens.misc.Alarm") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.misc, if t = assert(require "LunoPunk.tweens.misc.AngleTween") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.misc, if t = assert(require "LunoPunk.tweens.misc.ColorTween") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.misc, if t = assert(require "LunoPunk.tweens.misc.MultiVarTween") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.misc, if t = assert(require "LunoPunk.tweens.misc.NumTween") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.misc, if t = assert(require "LunoPunk.tweens.misc.VarTween") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.CircularMotion") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.CubicMotion") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.LinearMotion") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.LinearPath") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.Motion") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.QuadMotion") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.motion, if t = assert(require "LunoPunk.tweens.motion.QuadPath") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.sound, if t = assert(require "LunoPunk.tweens.sound.Fader") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.tweens.sound, if t = assert(require "LunoPunk.tweens.sound.SfxFader") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Color") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Data") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Draw") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Ease") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.EventListener") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Event") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Input") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Joystick") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Key") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.List") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Math") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.moonscript") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils, if t = assert(require "LunoPunk.utils.Touch") then t if type(t) == "table" else {} else {}
mixin_table LunoPunk.utils.mixins, if t = assert(require "LunoPunk.utils.mixins.clone") then t if type(t) == "table" else {} else {}

{ :LunoPunk }
