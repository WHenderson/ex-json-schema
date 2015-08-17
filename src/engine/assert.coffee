Engine::_assert = (context, condition, level, message, info) ->
  if not condition
    message = @_messageCompile(message, info, context)
    context.msg(level, message, info)
  return not condition

Engine::_eAssert = (context, condition, message, info) ->
  @_assert(context, condition, 'error', message, info)

Engine::_wAssert = (context, condition, message, info) ->
  @_assert(context, condition, 'warning', message, info)

Engine::_iAssert = (context, condition, message, info) ->
  @_assert(context, condition, 'information', message, info)
