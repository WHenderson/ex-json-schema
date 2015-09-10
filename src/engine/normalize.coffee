##
# Classed used for context during normalization
Engine::NormalizeContext = NormalizeContext

##
# Method used for normalizing a schema
# @param {Object} schema is a valid json schema
# @return {NormalContext} Context containing normalized json schema
Engine::normalize = (schema) ->
  nContext = new @NormalizeContext(schema)
  @_normalizeApply(nContext)
  return nContext

##
# Method to normalize a child schema
# @param {Context} context of normalization
# @param {Object} schema is a valid json schema
# @param {String|Number} path from context to the specified sub-schema
# @returns {Object} normalized json schema
Engine::_normalizeChild = (nContext, schema, path) ->
  childContext = nContext.newChildContext(schema, path)

  @_normalizeApply(childContext)

  return childContext

##
# Method to apply normalization methods against a context
# @param {NormalizeContext} context of normalization
# @returns undefined
Engine::_normalizeApply = (nContext) ->
  for key, partialSchemaNormalizer of @
    if key.slice(0, 3) == '_n_' and typeof partialSchemaNormalizer == 'function'
      partialSchemaNormalizer.call(@, nContext)
  return

##
# Method to normalize a child schema whilst asserting that it has no errors
# @param {Context} context of normalization
# @param {Object} schema is a valid json schema
# @param {String|Number} path from context to the specified sub-schema
# @param {String|Method|Object} errorMessage if the child fails normalization
# @param {Object} partialSchema which may contain relevant information for generation of an errorMessage
# @returns {Object} resulting schema
Engine::_normalizeAssert = (nContext, schema, path, errorMessage, partialSchema) ->
  childContext = @_normalizeChild(nContext, schema, path)
  @_eAssert(nContext, childContext.errors.length == 0, errorMessage, partialSchema, childContext.errors)
  return childContext.nodeOut
