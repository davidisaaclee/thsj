define ['rx', 'underscore'], (Rx, _) ->
  # Merges a variable number of streams of objects by combining their fields.
  objectMerge: (initial, streams...) ->
    Rx.Observable.merge.apply this, streams
      .scan initial, _.extend