Engine::_m_json_schema_validation__5_3_2_1_a = (id, partialSchema, nContext) ->
  'The value of "maxItems" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_3_2_1_b = (id, partialSchema, nContext) ->
  'The value of "maxItems" MUST be greater than, or equal to, 0'

Engine::_m_json_schema_validation__5_3_2_2_a = (id, partialSchema, vContext) ->
  "has more than #{partialSchema.maxItems} elements"

Engine::_n_json_schema_validation__5_3_2_maxItems = (nContext) ->
  cls = @constructor
  ps = {
    maxItems: nContext.nodeIn.maxItems
  }

  if ps.maxItems == undefined
    return

  if @_eAssert(nContext, cls.isNumber(ps.maxItems), { group: 'json-schema-validation', section: '5.3.2.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.maxItems >= 0, { group: 'json-schema-validation', section: '5.3.2.1.b' }, ps)
    return

  nContext.nodeOut.maxItems = ps.maxItems

  return

Engine::_c_json_schema_validation__5_3_2_maxItems = (cContext) ->
  cls = @constructor
  ps = {
    maxItems: cContext.node.maxItems
  }

  if ps.maxItems == undefined
    return

  return (vContext) =>
    if cls.isArray(vContext.value)
      @_eAssert(vContext, vContext.value.length <= ps.maxItems, { group: 'json-schema-validation', section: '5.3.2.2.a' }, ps)

    return
