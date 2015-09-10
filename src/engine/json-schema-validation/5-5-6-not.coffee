Engine::_m_json_schema_validation__5_5_6_1_a = (id, info, nContext) ->
  'The value of "not" MUST be an object.'

Engine::_m_json_schema_validation__5_5_6_1_b = (id, info, nContext) ->
  'The value of "not" MUST be a valid JSON Schema.'

Engine::_n_json_schema_validation__5_5_6_not = (nContext) ->
  cls = @constructor
  ps = {
    not: nContext.nodeIn.not
  }

  if ps.not == undefined
    return

  ei = {
    partialSchema: ps
  }

  rs = {
    not: ps.not
  }

  if @_eAssert(nContext, cls.isObject(rs.not), { group: 'json-schema-validation', section: '5.5.6.1.a' }, ei)
    return

  rs.not = @_normalizeAssert(nContext, rs.not, ['not'], { group: 'json-schema-validation', section: '5.5.6.1.b' }, ei)

  nContext.nodeOut.not = rs.not

  return
