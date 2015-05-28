_       = require 'underscore'
Vector3 = require 'util/Vector3'

class Player
  constructor: (options) ->
    defaults =
      position: Vector3.make 0, 0, 0
    options = _.defaults options, defaults

    @position = options.position
    @velocity = Vector3.make 0, 0, 0
    @rotation = {x: 0, y: 0, z: 0, w: 0}

  position: null
  velocity: null

  update: (delta) ->
    @position = Vector3.add @position, @velocity

module.exports = Player