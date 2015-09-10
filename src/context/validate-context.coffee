class ValidateContext extends Context
  constructor: (@value, path, parent, discrete = false) ->
    super(path, parent)

    @messages = []
    @errors = if discrete then [] else (parent?.errors ? [])

  newChildContext: (value, path) ->
    new @constructor(value, path, @)

  newDiscreteChildContext: (value, path) ->
    new @constructor(value, path, @, true)

  msg: (level, message, info, innerErrors) ->
    message = super(level, message, info, innerErrors)
    @messages.push(message)
    if message.level == 'error'
      @errors.push(message.error)

    return message
