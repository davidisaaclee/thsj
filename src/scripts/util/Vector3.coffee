# Provides procedures on POD 3-vectors, in the form
# {
#   x: <Number>,
#   y: <Number>,
#   z: <Number>
# }

class Vector3
  constructor: (@x, @y, @z) ->

module.exports =
  make: (x, y, z) -> new Vector3 x, y, z

  toArray: ({x, y, z}) -> [x, y, z]

  add: (a, b) ->
    x: a.x + b.x
    y: a.y + b.y
    z: a.z + b.z

  origin: () -> new Vector3(0, 0, 0)