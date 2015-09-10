##
# Class used for context during validation
Engine::ValidateContext = ValidateContext


Engine::_validateChild = (vContext, validator, value, path) ->
  vContext = vContext.newChildContext(value, path)

  validator(vContext)

  return vContext

Engine::_validateDiscreteChild = (vContext, validator, value, path) ->
  vContext = vContext.newDiscreteChildContext(value, path)

  if validator?
    validator(vContext)

  return vContext

Engine::_validate = (validator, value) ->
  vContext = new @ValidateContext(value)

  validator(vContext)

  return vContext
