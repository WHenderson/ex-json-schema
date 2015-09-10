Engine::_m_json_schema_validation__5_5_4_1_a = (id, info, nContext) ->
  'The value of "anyOf" MUST be an array.'

Engine::_m_json_schema_validation__5_5_4_1_b = (id, info, nContext) ->
  'The value of "anyOf" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_4_1_c = (id, info, nContext) ->
  'Elements of "anyOf" MUST be objects'

Engine::_m_json_schema_validation__5_5_4_1_d = (id, info, nContext) ->
  'Elements of "anyOf" MUST be valid JSON Schemas'

Engine::_n_json_schema_validation__5_5_4_anyOf = (nContext) ->
  cls = @constructor
  ps = {
    anyOf: nContext.nodeIn.anyOf
  }

  if ps.anyOf == undefined
    return

  ei = {
    partialSchema: ps
  }

  rs = {
    anyOf: ps.anyOf
  }

  if @_eAssert(nContext, cls.isArray(rs.anyOf), { group: 'json-schema-validation', section: '5.5.4.1.a' }, ei)
    return

  rs.anyOf = do =>
    results = []
    for subSchema, iSubSchema in rs.anyOf
      if @_eAssert(nContext, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.5.4.1.c' }, ei)
        continue
      subSchema = @_normalizeAssert(nContext, subSchema, ['anyOf', iSubSchema], { group: 'json-schema-validation', section: '5.5.4.1.d' }, ei)
      results.push(subSchema)
    return results

  if @_eAssert(nContext, rs.anyOf.length != 0, { group: 'json-schema-validation', section: '5.5.4.1.b' }, ei)
    return

  nContext.nodeOut.anyOf = rs.anyOf

  return
