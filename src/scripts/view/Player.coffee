# define [
#   'threeCore', 'underscore'
#   'view/CharacterController'
# ], (Three, _, CharacterController) ->

#   class Player
#     constructor: (options) ->
#       defaults =
#         position: {x: 0, y: 0, z: 0}

#       options = _.defaults options, defaults
#       @obj3d = new Three.Object3D()

#       Object.defineProperty this, 'position', \
#         get: -> @obj3d.position
#         set: (vec) -> @obj3d.position.copy vec

#       @position = new Three.Vector3 \
#         options.position.x,
#         options.position.y,
#         options.position.z

#       @camera =
#         new Three.PerspectiveCamera \
#           75,
#           (window.innerWidth / window.innerHeight),
#           0.1,
#           1000

#       @obj3d.add @camera

#       CharacterController.attachTo @obj3d

#     # backing top-level Three.js Object3D instance
#     obj3d: null

#     camera: null

#     position:
#       set: (x, y, z) -> @obj3d.position.set x, y, z
#       get: () -> @obj3d.position

#     update: (input) ->
