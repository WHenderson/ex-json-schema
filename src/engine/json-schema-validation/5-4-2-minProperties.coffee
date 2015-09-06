Engine::_m_json_schema_validation__5_4_2_1_a = (id, partialSchema, context) ->
  'The value of "minProperties" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_4_2_1_b = (id, partialSchema, context) ->
  'The value of "minProperties" MUST be greater than, or equal to, 0.'

Engine::_n_json_schema_validation__5_4_2_minProperties = (context) ->
  cls = @constructor
  ps = {
    minProperties: context.nodeIn.minProperties
  }

  if ps.minProperties == undefined
    return

  if @_eAssert(context, cls.isInteger(ps.minProperties), { group: 'json-schema-validation', section: '5.4.2.1.a' }, ps)
    return

  if @_eAssert(context, ps.minProperties >= 0, { group: 'json-schema-validation', section: '5.4.2.1.b' }, ps)
    return

  if ps.minProperties == 0
    return

  context.nodeOut.minProperties = ps.minProperties

  return
