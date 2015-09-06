Engine::_m_json_schema_validation__5_2_2_1_a = (id, partialSchema, context) ->
  'The value of "minLength" keyword MUST be an integer'

Engine::_m_json_schema_validation__5_2_2_1_b = (id, partialSchema, context) ->
  'The value of "minLength" MUST be greater than, or equal to, 0'

Engine::_n_json_schema_validation__5_2_2_minLength = (context) ->
  cls = @constructor
  ps = {
    minLength: context.nodeIn.minLength
  }

  if ps.minLength == undefined
    return

  if @_eAssert(context, cls.isInteger(ps.minLength), { group: 'json-schema-validation', section: '5.2.2.1.a' }, ps)
    return

  if @_eAssert(context, ps.minLength >= 0, { group: 'json-schema-validation', section: '5.2.2.1.b' }, ps)
    return

  if ps.minLength == 0
    return

  context.nodeOut.minLength = ps.minLength

  return
