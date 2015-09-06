Engine::_m_json_schema_validation__5_5_6_1_a = (id, partialSchema, context) ->
  'The value of "not" MUST be an object.'

Engine::_m_json_schema_validation__5_5_6_1_b = (id, partialSchema, context) ->
  'The value of "not" MUST be a valid JSON Schema.'

Engine::_n_json_schema_validation__5_5_6_not = (context) ->
  cls = @constructor
  ps = {
    not: context.nodeIn.not
  }

  if ps.not == undefined
    return

  rs = {
    not: ps.not
  }

  if @_eAssert(context, cls.isObject(rs.not), { group: 'json-schema-validation', section: '5.5.6.1.a' }, ps)
    return

  rs.not = @_normalizeAssert(context, rs.not, ['not'], { group: 'json-schema-validation', section: '5.5.6.1.b' }, ps)

  context.nodeOut.not = rs.not

  return
