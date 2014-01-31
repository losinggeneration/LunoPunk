-- Auto-generated with ./create_everything.sh on 2014-01-30 23:40:09

export ^

-- We tell Moonscript to export classes globally. Thus, we prevent collisions
-- based on namespace since we don't know what is going to be used.
--
-- This provides two options for getting the class, calling require again and
-- assigning it to a local variable. Alternatively, the namespaced version can
-- be used.

LunoPunk = {}
LunoPunk.debug = {}
LunoPunk.geometry = {}
LunoPunk.graphics = {}
LunoPunk.graphics.atlas = {}
LunoPunk.graphics.prototype = {}
LunoPunk.masks = {}
LunoPunk.tweens = {}
LunoPunk.tweens.misc = {}
LunoPunk.tweens.motion = {}
LunoPunk.tweens.sound = {}
LunoPunk.utils = {}
LunoPunk.utils.mixins = {}

-- Now load each file to the correctly namespaced table
LunoPunk.debug.Console = require "LunoPunk.debug.Console"
LunoPunk.debug.LayerList = require "LunoPunk.debug.LayerList"
LunoPunk.Engine = require "LunoPunk.Engine"
LunoPunk.Entity = require "LunoPunk.Entity"
LunoPunk.geometry.Matrix = require "LunoPunk.geometry.Matrix"
LunoPunk.geometry.Point = require "LunoPunk.geometry.Point"
LunoPunk.geometry.Rectangle = require "LunoPunk.geometry.Rectangle"
LunoPunk.Graphic = require "LunoPunk.Graphic"
LunoPunk.graphics.Animation = require "LunoPunk.graphics.Animation"
LunoPunk.graphics.atlas.AtlasData = require "LunoPunk.graphics.atlas.AtlasData"
LunoPunk.graphics.atlas.AtlasRegion = require "LunoPunk.graphics.atlas.AtlasRegion"
LunoPunk.graphics.atlas.Atlas = require "LunoPunk.graphics.atlas.Atlas"
LunoPunk.graphics.atlas.TextureAtlas = require "LunoPunk.graphics.atlas.TextureAtlas"
LunoPunk.graphics.atlas.TileAtlas = require "LunoPunk.graphics.atlas.TileAtlas"
LunoPunk.graphics.Backdrop = require "LunoPunk.graphics.Backdrop"
LunoPunk.graphics.Canvas = require "LunoPunk.graphics.Canvas"
LunoPunk.graphics.Emitter = require "LunoPunk.graphics.Emitter"
LunoPunk.graphics.Graphiclist = require "LunoPunk.graphics.Graphiclist"
LunoPunk.graphics.Image = require "LunoPunk.graphics.Image"
LunoPunk.graphics.Particle = require "LunoPunk.graphics.Particle"
LunoPunk.graphics.ParticleType = require "LunoPunk.graphics.ParticleType"
LunoPunk.graphics.PreRotation = require "LunoPunk.graphics.PreRotation"
LunoPunk.graphics.prototype.Circle = require "LunoPunk.graphics.prototype.Circle"
LunoPunk.graphics.prototype.Rect = require "LunoPunk.graphics.prototype.Rect"
LunoPunk.graphics.Spritemap = require "LunoPunk.graphics.Spritemap"
LunoPunk.graphics.Stamp = require "LunoPunk.graphics.Stamp"
LunoPunk.graphics.Text = require "LunoPunk.graphics.Text"
LunoPunk.graphics.TiledImage = require "LunoPunk.graphics.TiledImage"
LunoPunk.graphics.TiledSpritemap = require "LunoPunk.graphics.TiledSpritemap"
LunoPunk.graphics.Tilemap = require "LunoPunk.graphics.Tilemap"
LunoPunk.LP = require "LunoPunk.LP"
LunoPunk.Mask = require "LunoPunk.Mask"
LunoPunk.masks.Circle = require "LunoPunk.masks.Circle"
LunoPunk.masks.Grid = require "LunoPunk.masks.Grid"
LunoPunk.masks.Hitbox = require "LunoPunk.masks.Hitbox"
LunoPunk.masks.Imagemask = require "LunoPunk.masks.Imagemask"
LunoPunk.masks.Masklist = require "LunoPunk.masks.Masklist"
LunoPunk.masks.Pixelmask = require "LunoPunk.masks.Pixelmask"
LunoPunk.masks.Polygon = require "LunoPunk.masks.Polygon"
LunoPunk.masks.SlopedGrid = require "LunoPunk.masks.SlopedGrid"
LunoPunk.RenderMode = require "LunoPunk.RenderMode"
LunoPunk.Scene = require "LunoPunk.Scene"
LunoPunk.Screen = require "LunoPunk.Screen"
LunoPunk.Sfx = require "LunoPunk.Sfx"
LunoPunk.Tweener = require "LunoPunk.Tweener"
LunoPunk.Tween = require "LunoPunk.Tween"
LunoPunk.tweens.misc.Alarm = require "LunoPunk.tweens.misc.Alarm"
LunoPunk.tweens.misc.AngleTween = require "LunoPunk.tweens.misc.AngleTween"
LunoPunk.tweens.misc.ColorTween = require "LunoPunk.tweens.misc.ColorTween"
LunoPunk.tweens.misc.MultiVarTween = require "LunoPunk.tweens.misc.MultiVarTween"
LunoPunk.tweens.misc.NumTween = require "LunoPunk.tweens.misc.NumTween"
LunoPunk.tweens.misc.VarTween = require "LunoPunk.tweens.misc.VarTween"
LunoPunk.tweens.motion.CircularMotion = require "LunoPunk.tweens.motion.CircularMotion"
LunoPunk.tweens.motion.CubicMotion = require "LunoPunk.tweens.motion.CubicMotion"
LunoPunk.tweens.motion.LinearMotion = require "LunoPunk.tweens.motion.LinearMotion"
LunoPunk.tweens.motion.LinearPath = require "LunoPunk.tweens.motion.LinearPath"
LunoPunk.tweens.motion.Motion = require "LunoPunk.tweens.motion.Motion"
LunoPunk.tweens.motion.QuadMotion = require "LunoPunk.tweens.motion.QuadMotion"
LunoPunk.tweens.motion.QuadPath = require "LunoPunk.tweens.motion.QuadPath"
LunoPunk.tweens.sound.Fader = require "LunoPunk.tweens.sound.Fader"
LunoPunk.tweens.sound.SfxFader = require "LunoPunk.tweens.sound.SfxFader"
LunoPunk.tweens.TweenEvent = require "LunoPunk.tweens.TweenEvent"
LunoPunk.utils.Color = require "LunoPunk.utils.Color"
LunoPunk.utils.Data = require "LunoPunk.utils.Data"
LunoPunk.utils.Draw = require "LunoPunk.utils.Draw"
LunoPunk.utils.Ease = require "LunoPunk.utils.Ease"
LunoPunk.utils.EventListener = require "LunoPunk.utils.EventListener"
LunoPunk.utils.Event = require "LunoPunk.utils.Event"
LunoPunk.utils.Input = require "LunoPunk.utils.Input"
LunoPunk.utils.Joystick = require "LunoPunk.utils.Joystick"
LunoPunk.utils.Key = require "LunoPunk.utils.Key"
LunoPunk.utils.List = require "LunoPunk.utils.List"
LunoPunk.utils.Math = require "LunoPunk.utils.Math"
LunoPunk.utils.mixins.clone = require "LunoPunk.utils.mixins.clone"
LunoPunk.utils.moonscript = require "LunoPunk.utils.moonscript"
LunoPunk.utils.Touch = require "LunoPunk.utils.Touch"
LunoPunk.World = require "LunoPunk.World"
