Engine::_m_json_schema_validation__5_5_5_1_a = (id, info, nContext) ->
  'The value of "oneOf" MUST be an array.'

Engine::_m_json_schema_validation__5_5_5_1_b = (id, info, nContext) ->
  'The value of "oneOf" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_5_1_c = (id, info, nContext) ->
  'Elements of "oneOf" MUST be objects'

Engine::_m_json_schema_validation__5_5_5_1_d = (id, info, nContext) ->
  'Elements of "oneOf" MUST be valid JSON Schemas'

Engine::_m_json_schema_validation__5_5_5_2_a = (id, info, vContext) ->
  if info.details.matches.length == 0
    'does not match "oneOf" schemas'
  else
    'matches more than "oneOf" schemas'

Engine::_n_json_schema_validation__5_5_5_oneOf = (nContext) ->
  cls = @constructor
  ps = {
    oneOf: nContext.nodeIn.oneOf
  }

  if ps.oneOf == undefined
    return

  ei = {
    partialSchema: ps
  }

  rs = {
    oneOf: ps.oneOf
  }

  if @_eAssert(nContext, cls.isArray(rs.oneOf), { group: 'json-schema-validation', section: '5.5.5.1.a' }, ei)
    return

  rs.oneOf = do =>
    results = []
    for subSchema, iSubSchema in rs.oneOf
      if @_eAssert(nContext, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.5.5.1.c' }, ei)
        continue
      subSchema = @_normalizeAssert(nContext, subSchema, ['oneOf', iSubSchema], { group: 'json-schema-validation', section: '5.5.5.1.d' }, ei)
      results.push(subSchema)
    return results

  if @_eAssert(nContext, rs.oneOf.length != 0, { group: 'json-schema-validation', section: '5.5.5.1.b' }, ei)
    return

  nContext.nodeOut.oneOf = rs.oneOf

  return

Engine::_c_json_schema_validation__5_5_5_oneOf = (cContext) ->
  cls = @constructor
  ps = {
    oneOf: cContext.node.oneOf
  }

  if ps.oneOf == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }


  v = {
  }

  v.oneOf = do =>
    results = []
    for subSchema, iSubSchema in ps.oneOf
      validator = @_compileChild(cContext, subSchema, ['oneOf', iSubSchema])

      results.push({
        index: iSubSchema
        subSchema: subSchema
        validator: validator
      })

    return results

  return (vContext) =>
    matches = []
    innerErrors = []
    for info, iValidator in v.oneOf
      vChildContext = @_validateDiscreteChild(vContext, info.validator, vContext.value, [])
      if vChildContext.success()
        matches.push({
          index: info.index
          subSchema: info.subSchema
        })
      else
        innerErrors.push.apply(innerErrors, vChildContext.localErrors)

    @_eAssert(
      vContext,
      matches.length == 1,
      { group: 'json-schema-validation', section: '5.5.4.2.a' },
      {
        partialSchema: ps
        cContext: cContext
        details: {
          matches: matches
        }
      },
      innerErrors
    )

    return
