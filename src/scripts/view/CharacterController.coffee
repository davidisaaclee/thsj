Three = require 'three'
Rx = require 'rx'
_ = require 'underscore'
InputObservables = require 'util/InputObservables'
ObjectUtil = require 'util/ObjectUtil'


setup = (object, directionsStream) ->
  directionsStream
    .subscribe ({up, down, left, right}) ->
      object['velocity'] = up * -0.1

module.exports =
  attachTo: setup