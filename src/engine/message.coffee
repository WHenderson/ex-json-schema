Engine::_messageCompile = (message, partialSchema, context) ->

  if typeof message == 'object'
    methodName = message.methodName
    if not methodName? and message.group? and message.section?
      methodName = "_m_#{message.group.replace(/[^a-zA-Z0-9]/g, '_')}__#{message.section.replace(/[^a-zA-Z0-9]/g, '_')}"

    if @[methodName]?
      message = @[methodName](message, partialSchema, context)

  return message
