Three = require 'three'
_     = require 'underscore'
Rx    = require 'rx'

World = require 'model/World'
Orb   = require 'model/Orb'


initializeScene = (options) ->
  defaults =
    parentElement: document.body
    width: window.innerWidth
    height: window.innerHeight
  options = _.defaults options, defaults

  scene = new Three.Scene()
  renderer = new Three.WebGLRenderer()
  renderer.setSize options.width, options.height
  options.parentElement.appendChild renderer.domElement

  scene: scene
  renderer: renderer


initializePlayer = () ->
  camera = new Three.PerspectiveCamera \
    50,
    (window.innerWidth / window.innerHeight),
    0.1,
    1000

  playerLight = new Three.PointLight 0xffffff, 1, 50

  player = new Three.Object3D()
  player.add camera
  player.add playerLight

  object: player
  camera: camera


class MainView
  # parentElement
  # width
  # height
  constructor: (options) ->
    {@scene, @renderer} = initializeScene options
    @player = initializePlayer()
    @objects = {}

    scope = this
    Object.observe @objects, (changes) =>
      _.forEach changes, (change) =>
        switch change.type
          when 'add'
            console.log 'adding object', change.name
            @scene.add change.object[change.name]
          when 'delete'
            @scene.remove change.object[change.name]

    @objects['player'] = @player.object

    # begin drawing
    draw = () =>
      window.requestAnimationFrame draw
      @renderer.render @scene, @player.camera
    draw()

module.exports = MainView