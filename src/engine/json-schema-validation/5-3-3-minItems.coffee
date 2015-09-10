Engine::_m_json_schema_validation__5_3_3_1_a = (id, partialSchema, nContext) ->
  'The value of "minItems" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_3_3_1_b = (id, partialSchema, nContext) ->
  'The value of "minItems" MUST be greater than, or equal to, 0'

Engine::_m_json_schema_validation__5_3_3_2_a = (id, partialSchema, vContext) ->
  "has less than #{partialSchema.minItems} elements"

Engine::_n_json_schema_validation__5_3_3_minItems = (nContext) ->
  cls = @constructor
  ps = {
    minItems: nContext.nodeIn.minItems
  }

  if ps.minItems == undefined
    return

  if @_eAssert(nContext, cls.isNumber(ps.minItems), { group: 'json-schema-validation', section: '5.3.3.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.minItems >= 0, { group: 'json-schema-validation', section: '5.3.3.1.b' }, ps)
    return

  if ps.minItems == 0
    return

  nContext.nodeOut.minItems = ps.minItems

  return

Engine::_c_json_schema_validation__5_3_3_minItems = (cContext) ->
  cls = @constructor
  ps = {
    minItems: cContext.node.minItems
  }

  if ps.minItems == undefined
    return

  return (vContext) =>
    if cls.isArray(vContext.value)
      @_eAssert(vContext, vContext.value.length >= ps.minItems, { group: 'json-schema-validation', section: '5.3.3.2.a' }, ps)

    return
