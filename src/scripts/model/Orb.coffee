Three = require 'three'
_ = require 'underscore'

numberOfOrbs = 0

class Orb
  constructor: (options) ->
    defaults =
      position:
        x: 0
        y: 0
        z: 0
      size: 5
      color: 0xffffff

    {@position, @size, @color} = _.defaults options, defaults
    @id = 'orb' + numberOfOrbs++

  # Creates a 3D mesh object for this orb.
  makeMesh: () ->
    geometry = new Three.SphereGeometry 1, 15, 10
    material = new Three.MeshPhongMaterial {color: @color}
    mesh = new Three.Mesh geometry, material
    console.log @position.x, @position.y, @position.z
    mesh.position.set @position.x, @position.y, @position.z
    return mesh

module.exports = Orb