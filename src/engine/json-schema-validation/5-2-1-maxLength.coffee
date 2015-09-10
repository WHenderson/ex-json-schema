Engine::_m_json_schema_validation__5_2_1_1_a = (id, partialSchema, nContext) ->
  'The value of "maxLength" keyword MUST be an integer'

Engine::_m_json_schema_validation__5_2_1_1_b = (id, partialSchema, nContext) ->
  'The value of "maxLength" MUST be greater than, or equal to, 0'

Engine::_m_json_schema_validation__5_2_1_2_a = (id, partialSchema, vContext) ->
  "is longer than #{partialSchema.maxLength} characters"

Engine::_n_json_schema_validation__5_2_1_maxLength = (nContext) ->
  cls = @constructor
  ps = {
    maxLength: nContext.nodeIn.maxLength
  }

  if ps.maxLength == undefined
    return

  if @_eAssert(nContext, cls.isInteger(ps.maxLength), { group: 'json-schema-validation', section: '5.2.1.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.maxLength >= 0, { group: 'json-schema-validation', section: '5.2.1.1.b' }, ps)
    return

  nContext.nodeOut.maxLength = ps.maxLength

  return

Engine::_c_json_schema_validation__5_2_1_maxLength = (cContext) ->
  cls = @constructor
  ps = {
    maxLength: cContext.node.maxLength
  }

  if ps.maxLength == undefined
    return

  return (vContext) =>
    if cls.isString(vContext.value)
      @_eAssert(vContext, cls.stringLength(vContext.value) <= ps.maxLength, { group: 'json-schema-validation', section: '5.2.1.2.a' }, ps)

    return
