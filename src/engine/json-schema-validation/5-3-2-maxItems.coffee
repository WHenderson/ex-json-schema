Engine::_m_json_schema_validation__5_3_2_1_a = (id, partialSchema, context) ->
  'The value of "maxItems" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_3_2_1_b = (id, partialSchema, context) ->
  'The value of "maxItems" MUST be greater than, or equal to, 0'

Engine::_n_json_schema_validation__5_3_2_maxItems = (context) ->
  cls = @constructor
  ps = {
    maxItems: context.nodeIn.maxItems
  }

  if ps.maxItems == undefined
    return

  if @_eAssert(context, cls.isNumber(ps.maxItems), { group: 'json-schema-validation', section: '5.3.2.1.a' }, ps)
    return

  if @_eAssert(context, ps.maxItems >= 0, { group: 'json-schema-validation', section: '5.3.2.1.b' }, ps)
    return

  context.nodeOut.maxItems = ps.maxItems

  return
