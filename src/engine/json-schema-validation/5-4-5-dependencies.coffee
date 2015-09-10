Engine::_m_json_schema_validation__5_4_5_1_a = (id, partialSchema, nContext) ->
  'The value of "dependencies" MUST be an object.'

Engine::_m_json_schema_validation__5_4_5_1_b = (id, partialSchema, nContext) ->
  'Each value of "dependencies" MUST be either an object or an array.'

Engine::_m_json_schema_validation__5_4_5_1_c = (id, partialSchema, nContext) ->
  'If the value in "dependencies" is an object, it MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_5_1_d = (id, partialSchema, nContext) ->
  'If the value in "dependencies" is an array, it MUST have at least one element.'

Engine::_m_json_schema_validation__5_4_5_1_e = (id, partialSchema, nContext) ->
  'If the value in "dependencies" is an array, each element MUST be a string.'

Engine::_m_json_schema_validation__5_4_5_1_f = (id, partialSchema, nContext) ->
  'If the value in "dependencies" is an array, elements in the array MUST be unique.'

Engine::_m_json_schema_validation__5_4_5_2_2_a = (id, partialSchema, vContext) ->
  'is missing dependent members'

##
# 5.4.5.  dependencies
Engine::_n_json_schema_validation__5_4_5_dependencies = (nContext) ->
  cls = @constructor
  ps = {
    dependencies: nContext.nodeIn.dependencies
  }

  if ps.dependencies == undefined
    return

  rs = {
    dependencies: ps.dependencies
  }

  if @_eAssert(nContext, cls.isObject(rs.dependencies), { group: 'json-schema-validation', section: '5.4.5.1.a' }, ps)
    return

  rs.dependencies = do =>
    results = {}
    for own name, dependencies of rs.dependencies
      if @_eAssert(nContext, cls.isObject(dependencies) or cls.isArray(dependencies), { group: 'json-schema-validation', section: '5.4.5.1.b' }, ps)
        continue

      if cls.isObject(dependencies)
        dependencies = @_normalizeAssert(nContext, dependencies, ['dependencies', name], { group: 'json-schema-validation', section: '5.4.5.1.c' }, ps)
        if cls.isEmptyObject(dependencies)
          continue
      else
        if @_eAssert(nContext, dependencies.length != 0, { group: 'json-schema-validation', section: '5.4.5.1.d' }, ps)
          continue

        dependencies = dependencies.filter(
          (dependency, iDependency) =>
            return not @_eAssert(nContext, cls.isString(dependency), { group: 'json-schema-validation', section: '5.4.5.1.e' }, ps)
        )

        if @_eAssert(nContext, cls.areJsonArrayElementsUnique(dependencies), { group: 'json-schema-validation', section: '5.4.5.1.f' }, ps)
          dependencies = cls.jsonArrayFilterDuplicates(dependencies)

        if dependencies.length == 0
          continue

      results[name] = dependencies
    return results

  if cls.isEmptyObject(rs.dependencies)
    return

  nContext.nodeOut.dependencies = rs.dependencies

  return

Engine::_c_json_schema_validation__5_4_5_dependencies = (cContext) ->
  cls = @constructor
  ps = {
    dependencies: cContext.node.dependencies
  }

  if ps.dependencies == undefined
    return

  v = {}

  v.dependencies = do =>
    results = {}
    for own name, subSchema of ps.dependencies
      if cls.isObject(subSchema)
        results[name] = @_compileChild(cContext, subSchema, ['dependencies', name])
      else
        results[name] = subSchema

    return results

  hasDependency = {}.hasOwnProperty.bind(v.dependencies)

  return (vContext) =>
    if cls.isObject(vContext.value)
      hasDependent = {}.hasOwnProperty.bind(vContext.value)

      for own name of vContext.value
        if hasDependency(name)
          dependency = v.dependencies[name]
          if cls.isArray(dependency)
            for dependent in dependency
              @_eAssert(nContext, hasDependent(dependent), { group: 'json-schema-validation', section: '5.4.5.2.2.a' }, ps)
          else
            @_validateChild(vContext, dependency, vContext.value, [])

    return
