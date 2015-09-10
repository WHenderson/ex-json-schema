class ValidateContext extends Context
  constructor: (@value, path, parent) ->
    super(path, parent)

    @errors = []

  newChildContext: (value, path) ->
    new @constructor(value, path, @)

  newDiscreteChildContext: (value, path) ->
    new @constructor(value, path, @)

  msg: (level, message, info, innerErrors) ->
    error = super(level, message, info, innerErrors)
    if level == 'error'
      @errors.push(error)

    return error
