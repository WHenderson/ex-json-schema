Engine::_assert = (context, condition, level, message, partialSchema, innerErrors) ->
  if not condition
    messageText = @_messageCompile(message, partialSchema, context)
    info = {
      partialSchema: partialSchema
    }
    if typeof message == 'object'
      info.errorId = message

    context.msg(level, messageText, info, innerErrors)
  return not condition

Engine::_eAssert = (context, condition, message, partialSchema, innerErrors) ->
  @_assert(context, condition, 'error', message, partialSchema, innerErrors)

Engine::_wAssert = (context, condition, message, partialSchema, innerErrors) ->
  @_assert(context, condition, 'warning', message, partialSchema, innerErrors)

Engine::_iAssert = (context, condition, message, partialSchema, innerErrors) ->
  @_assert(context, condition, 'information', message, partialSchema, innerErrors)
