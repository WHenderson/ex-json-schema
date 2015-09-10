Engine::_m_json_schema_validation__5_2_2_1_a = (id, partialSchema, nContext) ->
  'The value of "minLength" keyword MUST be an integer'

Engine::_m_json_schema_validation__5_2_2_1_b = (id, partialSchema, nContext) ->
  'The value of "minLength" MUST be greater than, or equal to, 0'

Engine::_m_json_schema_validation__5_2_2_2_a = (id, partialSchema, vContext) ->
  "is shorter than #{partialSchema.minLength} characters"

Engine::_n_json_schema_validation__5_2_2_minLength = (nContext) ->
  cls = @constructor
  ps = {
    minLength: nContext.nodeIn.minLength
  }

  if ps.minLength == undefined
    return

  if @_eAssert(nContext, cls.isInteger(ps.minLength), { group: 'json-schema-validation', section: '5.2.2.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.minLength >= 0, { group: 'json-schema-validation', section: '5.2.2.1.b' }, ps)
    return

  if ps.minLength == 0
    return

  nContext.nodeOut.minLength = ps.minLength

  return


Engine::_c_json_schema_validation__5_2_2_minLength = (cContext) ->
  cls = @constructor
  ps = {
    minLength: cContext.node.minLength
  }

  if ps.minLength == undefined
    return

  return (vContext) =>
    if cls.isString(vContext.value)
      @_eAssert(vContext, cls.stringLength(vContext.value) >= ps.minLength, { group: 'json-schema-validation', section: '5.2.1.2.a' }, ps)

    return
