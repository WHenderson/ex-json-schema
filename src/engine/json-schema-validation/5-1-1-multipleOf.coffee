Engine::_m_json_schema_validation__5_1_1_1_a = (id, partialSchema, context) ->
  'The value of \"multipleOf\" MUST be a JSON number'

Engine::_m_json_schema_validation__5_1_1_1_b = (id, partialSchema, context) ->
  'The value of \"multipleOf\" MUST be strictly greater than 0'

Engine::_n_json_schema_validation__5_1_1_multipleOf = (context) ->
  cls = @constructor
  ps = {
    multipleOf: context.nodeIn.multipleOf
  }

  if ps.multipleOf == undefined
    return

  if @_eAssert(context, cls.isNumber(ps.multipleOf), { shortName: 'json-schema-validation', section: '5.1.1.1.a', methodName: '_m_json_schema_validation__5_1_1_1_a' }, ps)
    return

  if @_eAssert(context, ps.multipleOf > 0, { shortName: 'json-schema-validation', section: '5.1.1.1.b', methodName: '_m_json_schema_validation__5_1_1_1_b' }, ps)
    return

  context.nodeOut.multipleOf = ps.multipleOf

  return
