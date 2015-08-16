class Context
  constructor: (path, parent) ->
    @path = path ? []
    @parent = parent ? null

    @messages = []

  _error = (message, info) ->
    new SchemaError(
      message,
      info
    )

  msg: (level, message, info) ->
    error = @_error(message, info)
    @messages.push({
      level: level
      error: error
    })
    return error

  msgError: (message, info) ->
    @msg('error', message, info)

  msgWarning: (message, info) ->
    @msg('warning', message, info)

  msgInformation: (message, info) ->
    @msg('information', message, info)

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
      result.unshift.apply(result, context)
      context = context.parent

    return result

  pathLocalString: () ->
    cls = @constructor
    return '/' + @pathLocal().map(cls.pathEscapeSegment).join('/')

  pathGlobalString: () ->
    cls = @constructor
    return '/' + @pathGlobal().map(cls.pathEscapeSegment).join('/')

  newChildContext: (path) ->
    new @constructor(path, @)
