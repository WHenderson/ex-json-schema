class NormalizeContext extends Context
  constructor: (schema, path, parent) ->
    super(path, parent)

    @nodeIn = schema
    @nodeOut = {}

    @messages = parent?.errors ? []
    @errors = []

  newChildContext: (node, path) ->
    new @constructor(node, path, @)

  msg: (level, message, info, innerErrors) ->
    message = super(level, message, info, innerErrors)
    @messages.push(message)
    if message.level == 'error'
      @errors.push(message.error)

    return message
