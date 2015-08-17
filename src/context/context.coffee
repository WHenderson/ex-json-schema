class Context
  constructor: (path, parent) ->
    @path = path ? []
    @parent = parent ? null

    @messages = []

  _error: (message, info, innerErrors) ->
    new SchemaError(
      message,
      @,
      info,
      innerErrors
    )

  msg: (level, message, info, innerErrors) ->
    error = @_error(message, info)
    @messages.push({
      level: level
      error: error
    })
    return error

  msgError: (message, info, innerErrors) ->
    @msg('error', message, info, innerErrors)

  msgWarning: (message, info, innerErrors) ->
    @msg('warning', message, info, innerErrors)

  msgInformation: (message, info, innerErrors) ->
    @msg('information', message, info, innerErrors)

  @pathEscapeSegment: (segment) ->
    segment.toString().replace(/~/g, '~0').replace(/\//g, '~1')

  @pathUnescapeSegment: (segment) ->
    segment.replace(/~1/g, '/').replace(/~0/g, '~')

  pathLocal: () ->
    @path ? []

  pathGlobal: () ->
    result = []
    context = @
    while context?
      result.unshift.apply(result, context.path)
      context = context.parent

    return result

  pathLocalString: () ->
    cls = @constructor
    return @pathLocal().map(cls.pathEscapeSegment).join('/')

  pathGlobalString: () ->
    cls = @constructor
    return @pathGlobal().map(cls.pathEscapeSegment).join('/')

  newChildContext: (path) ->
    new @constructor(path, @)
