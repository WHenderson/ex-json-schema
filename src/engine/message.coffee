Engine::_messageCompile = (message, partialSchema, context) ->

  if typeof message == 'object' and message?.methodName?
    message = @[message.methodName](message, partialSchema, context)

  return message
