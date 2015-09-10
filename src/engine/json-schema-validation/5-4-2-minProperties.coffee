Engine::_m_json_schema_validation__5_4_2_1_a = (id, partialSchema, nContext) ->
  'The value of "minProperties" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_4_2_1_b = (id, partialSchema, nContext) ->
  'The value of "minProperties" MUST be greater than, or equal to, 0.'

Engine::_m_json_schema_validation__5_4_2_2_a = (id, partialSchema, vContext) ->
  "has less than #{partialSchema.minProperties} properties"

Engine::_n_json_schema_validation__5_4_2_minProperties = (nContext) ->
  cls = @constructor
  ps = {
    minProperties: nContext.nodeIn.minProperties
  }

  if ps.minProperties == undefined
    return

  if @_eAssert(nContext, cls.isInteger(ps.minProperties), { group: 'json-schema-validation', section: '5.4.2.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.minProperties >= 0, { group: 'json-schema-validation', section: '5.4.2.1.b' }, ps)
    return

  if ps.minProperties == 0
    return

  nContext.nodeOut.minProperties = ps.minProperties

  return

Engine::_c_json_schema_validation__5_4_1_minProperties = (cContext) ->
  cls = @constructor
  ps = {
    minProperties: cContext.nodeIn.minProperties
  }

  if ps.minProperties == undefined
    return

  return (vContext) =>
    if cls.isObject(vContext.value)
      @_eAssert(vContext, Object.keys(vContext.value).length >= ps.minProperties, { group: 'json-schema-validation', section: '5.4.2.2.a' }, ps)

    return
