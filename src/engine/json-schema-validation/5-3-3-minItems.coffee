Engine::_m_json_schema_validation__5_3_3_1_a = (id, info, nContext) ->
  'The value of "minItems" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_3_3_1_b = (id, info, nContext) ->
  'The value of "minItems" MUST be greater than, or equal to, 0'

Engine::_m_json_schema_validation__5_3_3_2_a = (id, info, vContext) ->
  "has less than #{partialSchema.minItems} elements"

Engine::_n_json_schema_validation__5_3_3_minItems = (nContext) ->
  cls = @constructor
  ps = {
    minItems: nContext.nodeIn.minItems
  }

  if ps.minItems == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isNumber(ps.minItems), { group: 'json-schema-validation', section: '5.3.3.1.a' }, ei)
    return

  if @_eAssert(nContext, ps.minItems >= 0, { group: 'json-schema-validation', section: '5.3.3.1.b' }, ei)
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

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  return (vContext) =>
    if cls.isArray(vContext.value)
      @_eAssert(vContext, vContext.value.length >= ps.minItems, { group: 'json-schema-validation', section: '5.3.3.2.a' }, ei)

    return
