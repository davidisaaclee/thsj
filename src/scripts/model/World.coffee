_       = require 'underscore'

Orb     = require 'model/Orb'
Player  = require 'model/Player'
Vector3 = require 'util/Vector3'

class World
  constructor: ->
    @orbs =
      byId: {}
      chunks: {}
    @players = {}

    numberOfPlayers = 0
    @nextPlayerId = () -> 'Player' + numberOfPlayers++

  addOrb: (orb) ->
    @orbs.byId[orb.id] = orb
    chunk = @chunker.coordToChunkId \
      orb.position.x,
      orb.position.y,
      orb.position.z
    if not @orbs.chunks[chunk]?
      @orbs.chunks[chunk] = []
    @orbs.chunks[chunk].push orb

  spawnPlayer: (options) ->
    defaults =
      position: Vector3.make 0, 0, 0
    options = _.defaults options, defaults

    player = new Player options
    player.id = @nextPlayerId()
    @players[player.id] = player
    
    return player

  # utility for calculating chunk IDs
  chunker:
    chunkSideLength: 5
    coordToChunkId: (x, y, z) ->
      roundTo = (n, to) -> n - (n %% to)

      'x' + (roundTo x, @chunkSideLength) +
      'y' + (roundTo y, @chunkSideLength) +
      'z' + (roundTo z, @chunkSideLength)
    chunkOrigin: (chunkId) -> null

module.exports = World