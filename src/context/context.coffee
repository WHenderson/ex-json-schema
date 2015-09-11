class Context
  constructor: (path, parent) ->
    @_path = path ? []
    @_parent = parent ? null

  _error: (message, info = {}, innerErrors = []) ->
    new SchemaError(
      message,
      @,
      info,
      innerErrors
    )

  msg: (level, message, info, innerErrors) ->
    return {
      level: level
      error: @_error(message, info, innerErrors)
    }

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

  pathLocalArray: () ->
    @_path ? []

  pathArray: () ->
    result = []
    context = @
    while context?
      result.unshift.apply(result, context._path)
      context = context._parent

    return result

  pathLocalString: () ->
    cls = @constructor
    return @pathLocalArray().map(cls.pathEscapeSegment).join('/')

  pathString: () ->
    cls = @constructor
    return '/' + @pathArray().map(cls.pathEscapeSegment).join('/')

  newChildContext: (path) ->
    new @constructor(path, @)
