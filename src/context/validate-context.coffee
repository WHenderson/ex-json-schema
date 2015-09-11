class ValidateContext extends Context
  constructor: (@value, path, parent, discrete = false) ->
    super(path, parent)

    @messages = []
    @localErrors = []
    @errors = if discrete or not parent?.errors? then @localErrors else parent.errors

  newChildContext: (value, path) ->
    new @constructor(value, path, @)

  newDiscreteChildContext: (value, path) ->
    new @constructor(value, path, @, true)

  msg: (level, message, info, innerErrors) ->
    message = super(level, message, info, innerErrors)
    @messages.push(message)
    if message.level == 'error'
      @localErrors.push(message.error)
      if @localErrors != @errors
        @errors.push(message.error)

    return message

  success: () ->
    return @localErrors.length == 0
