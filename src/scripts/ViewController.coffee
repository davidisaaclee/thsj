_ = require 'underscore'

class ViewController
  constructor: (world, view) ->
    _.mapObject world.orbs.byId, (orb, id) ->
      view.objects[id] = orb.makeMesh()

module.exports = ViewController