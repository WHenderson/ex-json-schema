Engine::_m_json_schema_validation__5_5_5_1_a = (id, info, nContext) ->
  'The value of "oneOf" MUST be an array.'

Engine::_m_json_schema_validation__5_5_5_1_b = (id, info, nContext) ->
  'The value of "oneOf" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_5_1_c = (id, info, nContext) ->
  'Elements of "oneOf" MUST be objects'

Engine::_m_json_schema_validation__5_5_5_1_d = (id, info, nContext) ->
  'Elements of "oneOf" MUST be valid JSON Schemas'

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
