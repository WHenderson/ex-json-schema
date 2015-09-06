Engine::_m_json_schema_validation__5_4_1_1_a = (id, partialSchema, context) ->
  'The value of "maxProperties" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_4_1_1_b = (id, partialSchema, context) ->
  'The value of "maxProperties" MUST be greater than, or equal to, 0.'

Engine::_n_json_schema_validation__5_4_1_maxProperties = (context) ->
  cls = @constructor
  ps = {
    maxProperties: context.nodeIn.maxProperties
  }

  if ps.maxProperties == undefined
    return

  if @_eAssert(context, cls.isInteger(ps.maxProperties), { group: 'json-schema-validation', section: '5.4.1.1.a' }, ps)
    return

  if @_eAssert(context, ps.maxProperties >= 0, { group: 'json-schema-validation', section: '5.4.1.1.b' }, ps)
    return

  context.nodeOut.maxProperties = ps.maxProperties

  return
