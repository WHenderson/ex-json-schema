##
# Classed used for context during compilation
Engine::CompileContext = CompileContext

Engine::compile = (schema) ->
  nContext = @normalize(schema)

  cContext = new @CompileContext(nContext.nodeOut)
  schemaValidator = @_compileApply(cContext)

  if schemaValidator == undefined
    return @_validate.bind(@, (vContext) -> return)
  else
    return @_validate.bind(@, schemaValidator)

Engine::_compileApply = (cContext) ->
  partialSchemaValidators = do =>
    results = []
    for key, partialSchemaCompiler of @
      if key.slice(0, 3) != '_c_' or typeof partialSchemaCompiler != 'function'
        continue

      partialSchemaValidator = partialSchemaCompiler.call(@, cContext)
      if not partialSchemaValidator?
        continue

      results.push(partialSchemaValidator)

    return results

  if partialSchemaValidators.length == 0
    return

  return (vContext) ->
    for partialSchemaValidator in partialSchemaValidators
      partialSchemaValidator(vContext)

    return

Engine::_compileChild = (cContext, subSchema, path) ->
  childContext = cContext.newChildContext(subSchema, path)
  return @_compileApply(childContext)


