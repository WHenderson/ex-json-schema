Engine::_m_json_schema_validation__5_3_3_1_a = (id, partialSchema, context) ->
  'The value of "minItems" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_3_3_1_b = (id, partialSchema, context) ->
  'The value of "minItems" MUST be greater than, or equal to, 0'

Engine::_n_json_schema_validation__5_3_3_minItems = (context) ->
  cls = @constructor
  ps = {
    minItems: context.nodeIn.minItems
  }

  if ps.minItems == undefined
    return

  if @_eAssert(context, cls.isNumber(ps.minItems), { group: 'json-schema-validation', section: '5.3.3.1.a' }, ps)
    return

  if @_eAssert(context, ps.minItems >= 0, { group: 'json-schema-validation', section: '5.3.3.1.b' }, ps)
    return

  if ps.minItems == 0
    return

  context.nodeOut.minItems = ps.minItems

  return
