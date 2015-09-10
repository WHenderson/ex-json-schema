Engine::_m_json_schema_validation__5_5_6_1_a = (id, partialSchema, nContext) ->
  'The value of "not" MUST be an object.'

Engine::_m_json_schema_validation__5_5_6_1_b = (id, partialSchema, nContext) ->
  'The value of "not" MUST be a valid JSON Schema.'

Engine::_n_json_schema_validation__5_5_6_not = (nContext) ->
  cls = @constructor
  ps = {
    not: nContext.nodeIn.not
  }

  if ps.not == undefined
    return

  rs = {
    not: ps.not
  }

  if @_eAssert(nContext, cls.isObject(rs.not), { group: 'json-schema-validation', section: '5.5.6.1.a' }, ps)
    return

  rs.not = @_normalizeAssert(nContext, rs.not, ['not'], { group: 'json-schema-validation', section: '5.5.6.1.b' }, ps)

  nContext.nodeOut.not = rs.not

  return
