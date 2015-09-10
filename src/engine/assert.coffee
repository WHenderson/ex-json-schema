Engine::_assert = (context, condition, level, message, info, innerErrors) ->
  if not condition
    if typeof message == 'object'
      info.errorId = message

    messageText = @_messageCompile(message, info, context)

    context.msg(level, messageText, info, innerErrors)
  return not condition

Engine::_eAssert = (context, condition, message, info, innerErrors) ->
  @_assert(context, condition, 'error', message, info, innerErrors)

Engine::_wAssert = (context, condition, message, info, innerErrors) ->
  @_assert(context, condition, 'warning', message, info, innerErrors)

Engine::_iAssert = (context, condition, message, info, innerErrors) ->
  @_assert(context, condition, 'information', message, info, innerErrors)
