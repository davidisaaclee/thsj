define [], () ->
  update: (object, field, val) ->
    object[field] = val
    return object