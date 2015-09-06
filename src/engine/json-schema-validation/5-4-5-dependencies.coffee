Engine::_m_json_schema_validation__5_4_5_1_a = (id, partialSchema, context) ->
  'The value of "dependencies" MUST be an object.'

Engine::_m_json_schema_validation__5_4_5_1_b = (id, partialSchema, context) ->
  'Each value of "dependencies" MUST be either an object or an array.'

Engine::_m_json_schema_validation__5_4_5_1_c = (id, partialSchema, context) ->
  'If the value in "dependencies" is an object, it MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_5_1_d = (id, partialSchema, context) ->
  'If the value in "dependencies" is an array, it MUST have at least one element.'

Engine::_m_json_schema_validation__5_4_5_1_e = (id, partialSchema, context) ->
  'If the value in "dependencies" is an array, each element MUST be a string.'

Engine::_m_json_schema_validation__5_4_5_1_f = (id, partialSchema, context) ->
  'If the value in "dependencies" is an array, elements in the array MUST be unique.'

##
# 5.4.5.  dependencies
Engine::_n_json_schema_validation__5_4_5_dependencies = (context) ->
  cls = @constructor
  ps = {
    dependencies: context.nodeIn.dependencies
  }

  if ps.dependencies == undefined
    return

  rs = {
    dependencies: ps.dependencies
  }

  if @_eAssert(context, cls.isObject(rs.dependencies), { group: 'json-schema-validation', section: '5.4.5.1.a' }, ps)
    return

  rs.dependencies = do =>
    results = {}
    for own name, dependencies of rs.dependencies
      if @_eAssert(context, cls.isObject(dependencies) or cls.isArray(dependencies), { group: 'json-schema-validation', section: '5.4.5.1.b' }, ps)
        continue

      if cls.isObject(dependencies)
        dependencies = @_normalizeAssert(context, dependencies, ['dependencies', name], { group: 'json-schema-validation', section: '5.4.5.1.c' }, ps)
        if cls.isEmptyObject(dependencies)
          continue
      else
        if @_eAssert(context, dependencies.length != 0, { group: 'json-schema-validation', section: '5.4.5.1.d' }, ps)
          continue

        dependencies = dependencies.filter(
          (dependency, iDependency) =>
            return not @_eAssert(context, cls.isString(dependency), { group: 'json-schema-validation', section: '5.4.5.1.e' }, ps)
        )

        if @_eAssert(context, cls.areJsonArrayElementsUnique(dependencies), { group: 'json-schema-validation', section: '5.4.5.1.f' }, ps)
          dependencies = cls.jsonArrayFilterDuplicates(dependencies)

        if dependencies.length == 0
          continue

      results[name] = dependencies
    return results

  if cls.isEmptyObject(rs.dependencies)
    return

  context.nodeOut.dependencies = rs.dependencies

  return

