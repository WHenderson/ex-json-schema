class NormalizeContext extends Context
  constructor: (schema, path, parent) ->
    super(path, parent)

    @nodeIn = schema
    @nodeOut = {}

    @errors = []

  newChildContext: (node, path) ->
    new @constructor(node, path, @)

  msg: (level, message, info, innerErrors) ->
    error = super(level, message, info, innerErrors)
    if level == 'error'
      @errors.push(error)

    return error
