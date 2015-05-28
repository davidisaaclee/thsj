# define ['threeCore'], (Three) ->
#   state =
#     mouseCaptured: false
#     viewObject: null

#   setupMouse = (camera) ->
#     camera.rotation.set 0, 0, 0
#     pitchObject = new Three.Object3D()
#     pitchObject.add camera

#     yawObject = new Three.Object3D()
#     yawObject.add pitchObject

#     state.viewObject = yawObject

#     PI_2 = Math.PI / 2
#     onMouseMove = (evt) ->
#       if state.mouseCaptured
#         movementX = event.movementX || event.mozMovementX || event.webkitMovementX || 0
#         movementY = event.movementY || event.mozMovementY || event.webkitMovementY || 0

#         yawObject.rotation.y -= movementX * 0.002
#         pitchObject.rotation.x -= movementY * 0.002

#         pitchObject.rotation.x = Math.max -PI_2, (Math.min PI_2, pitchObject.rotation.x)

#     document.addEventListener 'mousemove', onMouseMove, false

#   setup = (camera) ->
#     havePointerLook =
#       ((document[sel] != undefined) \
#         for sel in [
#           'pointerLockElement'
#           'mozPointerLockElement'
#           'webkitPointerLockElement'
#         ]).some (a) -> a

#     if havePointerLook
#       element = document.body

#       onPointerLock = (evt) ->
#         state.mouseCaptured = !state.mouseCaptured

#       document.addEventListener lockChange, onPointerLock, false \
#         for lockChange in ['pointerlockchange', 'mozpointerlockchange', 'webkitpointerlockchange']

#       setupMouse camera
#       state.viewObject

#   requestLock = () ->
#     element = document.body

#     if state.mouseCaptured
#       document.exitPointerLock =
#         document.exitPointerLock ||
#         document.mozExitPointerLock ||
#         document.webkitExitPointerLock
#       document.exitPointerLock()
#     else
#       element.requestPointerLock =
#         element.requestPointerLock ||
#         element.mozRequestPointerLock ||
#         element.webkitRequestPointerLock

#       element.requestPointerLock()

#   # exports
#   requestLock: requestLock
#   setup: setup
#   getViewObject: () -> state.viewObject