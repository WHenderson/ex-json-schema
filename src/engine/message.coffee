Engine::_messageCompile = (message, info, context) ->
  if typeof message == 'function'
    message = message.call(@, info, context)

  return message
