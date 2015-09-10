Engine::_m_json_schema_validation__5_4_1_1_a = (id, info, nContext) ->
  'The value of "maxProperties" keyword MUST be an integer.'

Engine::_m_json_schema_validation__5_4_1_1_b = (id, info, nContext) ->
  'The value of "maxProperties" MUST be greater than, or equal to, 0.'

Engine::_m_json_schema_validation__5_4_1_2_a = (id, info, vContext) ->
  "has more than #{partialSchema.maxProperties} properties"

Engine::_n_json_schema_validation__5_4_1_maxProperties = (nContext) ->
  cls = @constructor
  ps = {
    maxProperties: nContext.nodeIn.maxProperties
  }

  if ps.maxProperties == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isInteger(ps.maxProperties), { group: 'json-schema-validation', section: '5.4.1.1.a' }, ei)
    return

  if @_eAssert(nContext, ps.maxProperties >= 0, { group: 'json-schema-validation', section: '5.4.1.1.b' }, ei)
    return

  nContext.nodeOut.maxProperties = ps.maxProperties

  return

Engine::_c_json_schema_validation__5_4_1_maxProperties = (cContext) ->
  cls = @constructor
  ps = {
    maxProperties: cContext.nodeIn.maxProperties
  }

  if ps.maxProperties == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  return (vContext) =>
    if cls.isObject(vContext.value)
      @_eAssert(vContext, Object.keys(vContext.value).length <= ps.maxProperties, { group: 'json-schema-validation', section: '5.4.1.2.a' }, ei)

    return
