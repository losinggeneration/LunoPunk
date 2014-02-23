-- Busted mock for Löve 0.8.0

require "busted"

loveTbl = {
  _modules: {
    joystick: nil
    audio: nil
    keyboard: nil
    event: nil
    thread: nil
    physics: nil
    filesystem: nil
    font: nil
    graphics: nil
    timer: nil
    mouse: nil
    sound: nil
    image: nil
  }
  keyboard: {
    setKeyRepeat: ->
    getKeyRepeat: ->
    isDown: ->
  }
  boot: ->
  image: {
    newImageData: ->
  }
  _version_codename: 'Rubber Piggy'
  handlers: {
    joystickreleased: ->
    quit: ->
    joystickpressed: ->
    focus: ->
    keypressed: ->
    keyreleased: ->
    mousereleased: ->
    mousepressed: ->
  }
  sound: {
    newDecoder: ->
    newSoundData: ->
  }
  joystick: {
    getAxes: ->
    getNumBalls: ->
    getAxis: ->
    getNumAxes: ->
    getName: ->
    close: ->
    getNumJoysticks: ->
    open: ->
    isDown: ->
    getNumHats: ->
    getBall: ->
    isOpen: ->
    getNumButtons: ->
    getHat: ->
  }
  init: ->
  _exe: 'true'
  font: {
    newRasterizer: ->
    newGlyphData: ->
  }
  timer: {
    sleep: ->
    getDelta: ->
    getMicroTime: ->
    getFPS: ->
    step: ->
    getTime: ->
  }
  arg: {
    parse_option: ->
    getLow: ->
    options: {
      game: {
        a: '1'
        arg: {
          "tmp"
        }
        set: 'true'
      }
      console: {
        a: '0'
      }
    }
    parse_options: ->
  }
  _version: '0.8.0'
  path: {
    normalslashes: ->
    leaf: ->
    abs: ->
    getfull: ->
    endslash: ->
  }
  _version_major: '0'
  thread: {
    getThreads: ->
    getThread: ->
    newThread: ->
  }
  _os: 'Linux'
  errhand: ->
  _version_revision: '0'
  nogame: ->
  physics: {
    newCircleShape: ->
    newFixture: ->
    newMouseJoint: ->
    newWeldJoint: ->
    newDistanceJoint: ->
    newWorld: ->
    newRevoluteJoint: ->
    newWheelJoint: ->
    setMeter: ->
    newRectangleShape: ->
    newFrictionJoint: ->
    newBody: ->
    getMeter: ->
    newGearJoint: ->
    newChainShape: ->
    getDistance: ->
    newRopeJoint: ->
    newPulleyJoint: ->
    newPrismaticJoint: ->
    newEdgeShape: ->
    newPolygonShape: ->
  }
  _curthread: nil
  run: ->
  releaseerrhand: ->
  createhandlers: ->
  filesystem: {
    getAppdataDirectory: ->
    newFile: ->
    getWorkingDirectory: ->
    remove: ->
    setRelease: ->
    isDirectory: ->
    getSaveDirectory: ->
    setIdentity: ->
    write: ->
    init: ->
    isFile: ->
    newFileData: ->
    setSource: ->
    getLastModified: ->
    read: ->
    exists: ->
    getUserDirectory: ->
    lines: ->
    enumerate: ->
    load: ->
    mkdir: ->
  }
  _version_compat: {
    "0.8.0"
  }
  graphics: {
    getFont: ->
    getColorMode: ->
    isCreated: ->
    setIcon: ->
    getMaxPointSize: ->
    setCaption: ->
    checkMode: ->
    getScissor: ->
    newPixelEffect: ->
    _transformGLSLErrorMessages: ->
    newQuad: ->
    drawTest: ->
    reset: ->
    setLineWidth: ->
    present: ->
    setPointSize: ->
    newImageFont: ->
    getPointSize: ->
    getColor: ->
    shear: ->
    setScissor: ->
    getLineStyle: ->
    clear: ->
    setInvertedStencil: ->
    setLineStyle: ->
    draw: ->
    getLineWidth: ->
    toggleFullscreen: ->
    getMode: ->
    newCanvas: ->
    setMode: ->
    setNewFont: ->
    triangle: ->
    print: ->
    getModes: ->
    isSupported: ->
    setPoint: ->
    newImage: ->
    newSpriteBatch: ->
    _effectCodeToGLSL: ->
    newScreenshot: ->
    newStencil: ->
    getCanvas: ->
    newFont1: ->
    point: ->
    arc: ->
    polygon: ->
    rotate: ->
    hasFocus: ->
    setColor: ->
    translate: ->
    scale: ->
    getBackgroundColor: ->
    pop: ->
    push: ->
    setPixelEffect: ->
    circle: ->
    quad: ->
    rectangle: ->
    line: ->
    newFont: ->
    getWidth: ->
    setLine: ->
    getBlendMode: ->
    setDefaultImageFilter: ->
    getCaption: ->
    setCanvas: ->
    setBlendMode: ->
    getHeight: ->
    setStencil: ->
    printf: ->
    setFont: ->
    printf1: ->
    setPointStyle: ->
    print1: ->
    newParticleSystem: ->
    getDefaultImageFilter: ->
    getPointStyle: ->
    drawq: ->
    getPixelEffect: ->
    setBackgroundColor: ->
    setColorMode: ->
  }
  audio: {
    rewind: ->
    getVolume: ->
    getNumSources: ->
    setDistanceModel: ->
    getOrientation: ->
    setPosition: ->
    newSource1: ->
    setOrientation: ->
    play: ->
    setVelocity: ->
    newSource: ->
    getDistanceModel: ->
    stop: ->
    resume: ->
    getPosition: ->
    setVolume: ->
    pause: ->
    getVelocity: ->
  }
  mouse: {
    isVisible: ->
    getX: ->
    setGrab: ->
    setPosition: ->
    setVisible: ->
    isGrabbed: ->
    isDown: ->
    getPosition: ->
    getY: ->
  }
  _version_minor: '8'
  event: {
    poll: ->
    push: ->
    quit: ->
    pump: ->
    clear: ->
    wait: ->
  }
}
export love = mock loveTbl
love
