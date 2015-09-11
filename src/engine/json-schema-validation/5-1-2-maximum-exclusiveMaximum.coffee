Engine::_m_json_schema_validation__5_1_2_1_a = (id, info, nContext) ->
  'The value of "maximum" MUST be a JSON number.'

Engine::_m_json_schema_validation__5_1_2_1_b = (id, info, nContext) ->
  'The value of "exclusiveMaximum" MUST be a boolean.'

Engine::_m_json_schema_validation__5_1_2_1_c = (id, info, nContext) ->
  'If "exclusiveMaximum" is present, "maximum" MUST also be present.'

Engine::_m_json_schema_validation__5_1_2_2_a = (id, info, vContext) ->
  "is more than (#{if info.partialSchema.exclusiveMaximum then 'exclusive' else 'inclusive'}) maximum #{info.partialSchema.maximum}"

Engine::_n_json_schema_validation__5_1_2_maximum_exclusiveMaximum = (nContext) ->
  cls = @constructor
  ps = {
    maximum: nContext.nodeIn.maximum
    exclusiveMaximum: nContext.nodeIn.exclusiveMaximum
  }

  if ps.maximum == undefined and ps.exclusiveMaximum == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, ps.maximum == undefined or cls.isNumber(ps.maximum), { group: 'json-schema-validation', section: '5.1.2.1.a' }, ei)
    return

  if @_eAssert(nContext, ps.exclusiveMaximum == undefined or cls.isBoolean(ps.exclusiveMaximum), { group: 'json-schema-validation', section: '5.1.2.1.b' }, ei)
    return

  if @_eAssert(nContext, ps.exclusiveMaximum == undefined or ps.maximum != undefined, { group: 'json-schema-validation', section: '5.1.2.1.c' }, ei)
    return

  nContext.nodeOut.maximum = ps.maximum
  nContext.nodeOut.exclusiveMaximum = ps.exclusiveMaximum ? false

  return

Engine::_c_json_schema_validation__5_1_2_maximum_exclusiveMaximum = (cContext) ->
  cls = @constructor
  ps = {
    maximum: cContext.node.maximum
    exclusiveMaximum: cContext.node.exclusiveMaximum
  }

  if ps.maximum == undefined and ps.exclusiveMaximum == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  if ps.exclusiveMaximum
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value < ps.maximum, { group: 'json-schema-validation', section: '5.1.2.2.a' }, ei)

      return
  else
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value <= ps.maximum, { group: 'json-schema-validation', section: '5.1.2.2.a' }, ei)

      return
