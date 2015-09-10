Engine::_m_json_schema_validation__5_4_5_1_a = (id, info, nContext) ->
  'The value of "dependencies" MUST be an object.'

Engine::_m_json_schema_validation__5_4_5_1_b = (id, info, nContext) ->
  'Each value of "dependencies" MUST be either an object or an array.'

Engine::_m_json_schema_validation__5_4_5_1_c = (id, info, nContext) ->
  'If the value in "dependencies" is an object, it MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_5_1_d = (id, info, nContext) ->
  'If the value in "dependencies" is an array, it MUST have at least one element.'

Engine::_m_json_schema_validation__5_4_5_1_e = (id, info, nContext) ->
  'If the value in "dependencies" is an array, each element MUST be a string.'

Engine::_m_json_schema_validation__5_4_5_1_f = (id, info, nContext) ->
  'If the value in "dependencies" is an array, elements in the array MUST be unique.'

Engine::_m_json_schema_validation__5_4_5_2_2_a = (id, info, vContext) ->
  "is missing #{info.details.missing} as required by #{info.details.provided}"

##
# 5.4.5.  dependencies
Engine::_n_json_schema_validation__5_4_5_dependencies = (nContext) ->
  cls = @constructor
  ps = {
    dependencies: nContext.nodeIn.dependencies
  }

  if ps.dependencies == undefined
    return

  ei = {
    partialSchema: ps
  }

  rs = {
    dependencies: ps.dependencies
  }

  if @_eAssert(nContext, cls.isObject(rs.dependencies), { group: 'json-schema-validation', section: '5.4.5.1.a' }, ei)
    return

  rs.dependencies = do =>
    results = {}
    for own name, dependencies of rs.dependencies
      if @_eAssert(nContext, cls.isObject(dependencies) or cls.isArray(dependencies), { group: 'json-schema-validation', section: '5.4.5.1.b' }, ei)
        continue

      if cls.isObject(dependencies)
        dependencies = @_normalizeAssert(nContext, dependencies, ['dependencies', name], { group: 'json-schema-validation', section: '5.4.5.1.c' }, ei)
        if cls.isEmptyObject(dependencies)
          continue
      else
        if @_eAssert(nContext, dependencies.length != 0, { group: 'json-schema-validation', section: '5.4.5.1.d' }, ei)
          continue

        dependencies = dependencies.filter(
          (dependency, iDependency) =>
            return not @_eAssert(nContext, cls.isString(dependency), { group: 'json-schema-validation', section: '5.4.5.1.e' }, ei)
        )

        if @_eAssert(nContext, cls.areJsonArrayElementsUnique(dependencies), { group: 'json-schema-validation', section: '5.4.5.1.f' }, ei)
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

  ei = {
    partialSchema: ps
    cContext: cContext
  }

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
              @_eAssert(
                nContext,
                hasDependent(dependent),
                { group: 'json-schema-validation', section: '5.4.5.2.2.a' },
                {
                  partialSchema: ps
                  details: {
                    provided: name
                    missing: dependent
                  }
                  cContext: cContext
                }
              )
          else
            @_validateChild(vContext, dependency, vContext.value, [])

    return
