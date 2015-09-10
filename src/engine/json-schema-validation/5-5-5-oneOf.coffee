Engine::_m_json_schema_validation__5_5_5_1_a = (id, partialSchema, nContext) ->
  'The value of "oneOf" MUST be an array.'

Engine::_m_json_schema_validation__5_5_5_1_b = (id, partialSchema, nContext) ->
  'The value of "oneOf" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_5_1_c = (id, partialSchema, nContext) ->
  'Elements of "oneOf" MUST be objects'

Engine::_m_json_schema_validation__5_5_5_1_d = (id, partialSchema, nContext) ->
  'Elements of "oneOf" MUST be valid JSON Schemas'

Engine::_n_json_schema_validation__5_5_5_oneOf = (nContext) ->
  cls = @constructor
  ps = {
    oneOf: nContext.nodeIn.oneOf
  }

  if ps.oneOf == undefined
    return

  rs = {
    oneOf: ps.oneOf
  }

  if @_eAssert(nContext, cls.isArray(rs.oneOf), { group: 'json-schema-validation', section: '5.5.5.1.a' }, ps)
    return

  rs.oneOf = do =>
    results = []
    for subSchema, iSubSchema in rs.oneOf
      if @_eAssert(nContext, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.5.5.1.c' }, ps)
        continue
      subSchema = @_normalizeAssert(nContext, subSchema, ['oneOf', iSubSchema], { group: 'json-schema-validation', section: '5.5.5.1.d' }, ps)
      results.push(subSchema)
    return results

  if @_eAssert(nContext, rs.oneOf.length != 0, { group: 'json-schema-validation', section: '5.5.5.1.b' }, ps)
    return

  nContext.nodeOut.oneOf = rs.oneOf

  return
