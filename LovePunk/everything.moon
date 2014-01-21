-- Auto-generated with ./create_everything.sh on 2014-01-21 00:04:33

export ^

-- We tell Moonscript to export classes globally. Thus, we prevent collisions
-- based on namespace since we don't know what is going to be used.
--
-- This provides two options for getting the class, calling require again and
-- assigning it to a local variable. Alternatively, the namespaced version can
-- be used.

LovePunk = {}
LovePunk.debug = {}
LovePunk.geometry = {}
LovePunk.graphics = {}
LovePunk.graphics.atlas = {}
LovePunk.graphics.prototype = {}
LovePunk.masks = {}
LovePunk.tweens = {}
LovePunk.tweens.misc = {}
LovePunk.tweens.motion = {}
LovePunk.tweens.sound = {}
LovePunk.utils = {}

-- Now load each file to the correctly namespaced table
LovePunk.debug.Console = require "LovePunk.debug.Console"
LovePunk.debug.LayerList = require "LovePunk.debug.LayerList"
LovePunk.Engine = require "LovePunk.Engine"
LovePunk.Entity = require "LovePunk.Entity"
LovePunk.geometry.Rectangle = require "LovePunk.geometry.Rectangle"
LovePunk.Graphic = require "LovePunk.Graphic"
LovePunk.graphics.Animation = require "LovePunk.graphics.Animation"
LovePunk.graphics.atlas.AtlasData = require "LovePunk.graphics.atlas.AtlasData"
LovePunk.graphics.atlas.AtlasRegion = require "LovePunk.graphics.atlas.AtlasRegion"
LovePunk.graphics.atlas.Atlas = require "LovePunk.graphics.atlas.Atlas"
LovePunk.graphics.atlas.TextureAtlas = require "LovePunk.graphics.atlas.TextureAtlas"
LovePunk.graphics.atlas.TileAtlas = require "LovePunk.graphics.atlas.TileAtlas"
LovePunk.graphics.Backdrop = require "LovePunk.graphics.Backdrop"
LovePunk.graphics.Canvas = require "LovePunk.graphics.Canvas"
LovePunk.graphics.Emitter = require "LovePunk.graphics.Emitter"
LovePunk.graphics.Graphiclist = require "LovePunk.graphics.Graphiclist"
LovePunk.graphics.Image = require "LovePunk.graphics.Image"
LovePunk.graphics.Particle = require "LovePunk.graphics.Particle"
LovePunk.graphics.ParticleType = require "LovePunk.graphics.ParticleType"
LovePunk.graphics.PreRotation = require "LovePunk.graphics.PreRotation"
LovePunk.graphics.prototype.Circle = require "LovePunk.graphics.prototype.Circle"
LovePunk.graphics.prototype.Rect = require "LovePunk.graphics.prototype.Rect"
LovePunk.graphics.Spritemap = require "LovePunk.graphics.Spritemap"
LovePunk.graphics.Stamp = require "LovePunk.graphics.Stamp"
LovePunk.graphics.Text = require "LovePunk.graphics.Text"
LovePunk.graphics.TiledImage = require "LovePunk.graphics.TiledImage"
LovePunk.graphics.TiledSpritemap = require "LovePunk.graphics.TiledSpritemap"
LovePunk.graphics.Tilemap = require "LovePunk.graphics.Tilemap"
LovePunk.LP = require "LovePunk.LP"
LovePunk.Mask = require "LovePunk.Mask"
LovePunk.masks.Circle = require "LovePunk.masks.Circle"
LovePunk.masks.Grid = require "LovePunk.masks.Grid"
LovePunk.masks.Hitbox = require "LovePunk.masks.Hitbox"
LovePunk.masks.Imagemask = require "LovePunk.masks.Imagemask"
LovePunk.masks.Masklist = require "LovePunk.masks.Masklist"
LovePunk.masks.Pixelmask = require "LovePunk.masks.Pixelmask"
LovePunk.masks.Polygon = require "LovePunk.masks.Polygon"
LovePunk.masks.SlopedGrid = require "LovePunk.masks.SlopedGrid"
LovePunk.RenderMode = require "LovePunk.RenderMode"
LovePunk.Scene = require "LovePunk.Scene"
LovePunk.Screen = require "LovePunk.Screen"
LovePunk.Sfx = require "LovePunk.Sfx"
LovePunk.Tweener = require "LovePunk.Tweener"
LovePunk.Tween = require "LovePunk.Tween"
LovePunk.tweens.misc.Alarm = require "LovePunk.tweens.misc.Alarm"
LovePunk.tweens.misc.AngleTween = require "LovePunk.tweens.misc.AngleTween"
LovePunk.tweens.misc.ColorTween = require "LovePunk.tweens.misc.ColorTween"
LovePunk.tweens.misc.MultiVarTween = require "LovePunk.tweens.misc.MultiVarTween"
LovePunk.tweens.misc.NumTween = require "LovePunk.tweens.misc.NumTween"
LovePunk.tweens.misc.VarTween = require "LovePunk.tweens.misc.VarTween"
LovePunk.tweens.motion.CircularMotion = require "LovePunk.tweens.motion.CircularMotion"
LovePunk.tweens.motion.CubicMotion = require "LovePunk.tweens.motion.CubicMotion"
LovePunk.tweens.motion.LinearMotion = require "LovePunk.tweens.motion.LinearMotion"
LovePunk.tweens.motion.LinearPath = require "LovePunk.tweens.motion.LinearPath"
LovePunk.tweens.motion.Motion = require "LovePunk.tweens.motion.Motion"
LovePunk.tweens.motion.QuadMotion = require "LovePunk.tweens.motion.QuadMotion"
LovePunk.tweens.motion.QuadPath = require "LovePunk.tweens.motion.QuadPath"
LovePunk.tweens.sound.Fader = require "LovePunk.tweens.sound.Fader"
LovePunk.tweens.sound.SfxFader = require "LovePunk.tweens.sound.SfxFader"
LovePunk.tweens.TweenEvent = require "LovePunk.tweens.TweenEvent"
LovePunk.utils.Data = require "LovePunk.utils.Data"
LovePunk.utils.Draw = require "LovePunk.utils.Draw"
LovePunk.utils.Ease = require "LovePunk.utils.Ease"
LovePunk.utils.Input = require "LovePunk.utils.Input"
LovePunk.utils.Joystick = require "LovePunk.utils.Joystick"
LovePunk.utils.Key = require "LovePunk.utils.Key"
LovePunk.utils.moonscript = require "LovePunk.utils.moonscript"
LovePunk.utils.Touch = require "LovePunk.utils.Touch"
LovePunk.World = require "LovePunk.World"
