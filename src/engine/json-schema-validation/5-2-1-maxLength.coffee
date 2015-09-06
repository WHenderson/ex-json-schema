Engine::_m_json_schema_validation__5_2_1_1_a = (id, partialSchema, context) ->
  'The value of "maxLength" keyword MUST be an integer'

Engine::_m_json_schema_validation__5_2_1_1_b = (id, partialSchema, context) ->
  'The value of "maxLength" MUST be greater than, or equal to, 0'

Engine::_n_json_schema_validation__5_2_1_maxLength = (context) ->
  cls = @constructor
  ps = {
    maxLength: context.nodeIn.maxLength
  }

  if ps.maxLength == undefined
    return

  if @_eAssert(context, cls.isInteger(ps.maxLength), { group: 'json-schema-validation', section: '5.2.1.1.a' }, ps)
    return

  if @_eAssert(context, ps.maxLength >= 0, { group: 'json-schema-validation', section: '5.2.1.1.b' }, ps)
    return

  context.nodeOut.maxLength = ps.maxLength

  return
