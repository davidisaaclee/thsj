define [
  'rx', 'underscore', 'fulltilt'
  'util/ObjectUtil'
], (Rx, _, Fulltilt, ObjectUtil) ->
  directionKeyCodes =
    up: 87
    down: 83
    left: 65
    right: 68

  keyEventToDirection = (sig) ->
    sig
      .map (elm) -> elm.keyCode
      .filter (elm) -> _.contains (_.values directionKeyCodes), elm
      .map (elm) -> (_.invert directionKeyCodes)[elm]

  directionDown =
    keyEventToDirection (Rx.Observable.fromEvent document, 'keydown')
      .map (dir) -> {direction: dir, pressed: true}

  directionUp =
    keyEventToDirection (Rx.Observable.fromEvent document, 'keyup')
      .map (dir) -> {direction: dir, pressed: false}

  updateDirectionalState = (keyState, inp) ->
    ObjectUtil.update keyState, inp.direction, inp.pressed

  initialDirectionalState =
    up: false
    down: false
    left: false
    right: false

  hashBoolList = (boolList) ->
    boolList.reduce ((acc, elm, idx) ->
      (if elm then Math.pow(2, idx) else 0) + acc), 0

  # {up: Boolean, down: Boolean, left: Boolean, right: Boolean}
  directions =
    (directionDown.merge directionUp)
      .scan initialDirectionalState, updateDirectionalState
      .distinctUntilChanged (keyState) -> hashBoolList _.values keyState

  selectKeyDown = (characters...) ->
    Rx.Observable.fromEvent document, 'keydown'
      .map ({which}) -> {char: String.fromCharCode which}
      .filter ({char}) -> _.contains characters, char.toLowerCase()

  selectKeyUp = (characters...) ->
    Rx.Observable.fromEvent document, 'keyup'
      .map ({which}) -> {char: String.fromCharCode which}
      .filter ({char}) -> _.contains characters, char.toLowerCase()

  selectKey = (characters...) ->
    keyups = selectKeyUp.apply this, characters
      .map (val) -> _.extend val, {isDown: false}
    keydowns = selectKeyDown.apply this, characters
      .map (val) -> _.extend val, {isDown: true}

    initialState = {}
    initialState[c] = false for c in characters

    keyups.merge keydowns
      .scan initialState, (acc, {char, isDown}) ->
        acc[char.toLowerCase()] = isDown
        acc

  # mouse =
  #   Rx.Observable.fromEvent document, 'mousemove'
  #     .map ({clientX, clientY}) -> {x: clientX, y: clientY}

  mouseDown =
    Rx.Observable.fromEvent document, 'mousedown'
      .map ({pageX, pageY}) ->
        isDown: true
        position:
          x: pageX
          y: pageY
  mouseUp =
    Rx.Observable.fromEvent document, 'mouseup'
      .map ({pageX, pageY}) ->
        isDown: false
        position:
          x: pageX
          y: pageY
  mouseButton =
    mouseDown.merge(mouseUp).distinctUntilChanged()

  mouseMove =
    Rx.Observable.fromEvent document, 'mousemove'
      .map ({pageX, pageY}) -> {x: pageX, y: pageY}

  initialMouseState =
    isDown: false
    position:
      x: 0
      y: 0

  mouse =
    Rx.Observable.merge mouseButton, (mouseMove.map (evt) -> {position: evt})
      .scan initialMouseState, (st, evt) -> _.extend st, evt

  # promise = Fulltilt.getDeviceOrientation {type: 'world'}
  # deviceOrientation = null
  # promise
  #   .then (ctlr) ->
  #     ctlr.listen () ->
  #       info = ctlr.getScreenAdjustedEuler()
  #       evt = new CustomEvent 'fulltilt', {detail: info}
  #       document.dispatchEvent evt
  #   .catch (msg) -> console.error msg

  if window.DeviceOrientationEvent
    o = new Fulltilt.DeviceOrientation {type: 'world'}
    o.listen () ->
      evt = new CustomEvent 'fulltilt', {detail: o.getScreenAdjustedQuaternion()}
      document.dispatchEvent evt

  touchmoveStream = Rx.Observable.fromEvent document, 'touchmove'
    .map ({pageX, pageY}) -> {x: pageX, y: pageY, type: 'move'}

  touchstartStream = Rx.Observable.fromEvent document, 'touchstart'
    .map ({pageX, pageY}) -> {x: pageX, y: pageY, type: 'start'}

  touchdownStream = touchmoveStream.merge touchstartStream

  touchupStream = Rx.Observable.fromEvent document, 'touchend'
    .map ({pageX, pageY}) -> {x: pageX, y: pageY, type: 'end'}

  touchPointer = touchdownStream.merge touchupStream

  orientation =
    if window.DeviceOrientationEvent
      Rx.Observable.fromEvent document, 'fulltilt'
        .map ({detail}) -> detail
    else
      Rx.Observable.just alpha: 0, beta: 0, gamma: 0

  # exports
  directions: directions
  mouse: mouse
  selectKeyUp: selectKeyUp
  selectKeyDown: selectKeyDown
  selectKey: selectKey
  orientation: orientation
  touchPointer: touchPointer
  mouseButton: mouseButton