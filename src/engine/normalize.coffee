##
# Classed used for context during normalization
Engine::NormalizeContext = NormalizeContext

##
# Method used for normalizing a schema
# @param {Object} schema is a valid json schema
# @return {Object} normalized json schema
Engine::normalize = (schema) ->
  context = new @NormalizeContext(schema)
  @_normalizeApply(context)
  return context

##
# Method to normalize a child schema
# @param {Context} context of normalization
# @param {Object} schema is a valid json schema
# @param {String|Number} path from context to the specified sub-schema
# @param {String|Method} errorMessage if the child fails normalization
# @param {Object} errorInfo which may contain relevant information for generation of an errorMessage
# @returns {Object} normalized json schema
Engine::_normalizeChild = (context, schema, path, errorMessage, errorInfo) ->
  childContext = context.newChildContext(schema, path)

  @_normalizeApply(childContext)

  if childContext.errors.length != 0
    context.msgError(@_messageCompile(errorMessage, errorInfo, context), errorInfo, childContext.errors)

  return childContext

##
# Method to apply normalization methods against a context
# @param {NormalizeContext} context of normalization
# @returns undefined
Engine::_normalizeApply = (context) ->
  for key, val of @
    if key.slice(0, 3) == '_n_' and typeof val == 'function'
      val.call(@, context)
  return
