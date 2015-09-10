class CompileContext extends Context
  constructor: (schema, path, parent) ->
    super(path, parent)

    @node = schema

    @messages = parent?.messages ? []

  newChildContext: (subSchema, path) ->
    new @constructor(subSchema, path, @)

  msg: (level, message, info, innerErrors) ->
    message = super(level, message, info, innerErrors)
    @messages.push(message)

    return message
