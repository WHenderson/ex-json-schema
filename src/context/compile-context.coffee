class CompileContext extends Context
  constructor: (schema, path, parent) ->
    super(path, parent)

    @node = schema

    @errors = []

  newChildContext: (subSchema, path) ->
    new @constructor(subSchema, path, @)

  msg: (level, message, info, innerErrors) ->
    error = super(level, message, info, innerErrors)
    if level == 'error'
      @errors.push(error)

    return error
