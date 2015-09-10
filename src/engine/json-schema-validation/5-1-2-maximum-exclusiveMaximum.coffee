Engine::_m_json_schema_validation__5_1_2_1_a = (id, partialSchema, nContext) ->
  'The value of "maximum" MUST be a JSON number.'

Engine::_m_json_schema_validation__5_1_2_1_b = (id, partialSchema, nContext) ->
  'The value of "exclusiveMaximum" MUST be a boolean.'

Engine::_m_json_schema_validation__5_1_2_1_c = (id, partialSchema, nContext) ->
  'If "exclusiveMaximum" is present, "maximum" MUST also be present.'

Engine::_m_json_schema_validation__5_1_2_2_a = (id, partialSchema, vContext) ->
  "is more than (#{if partialSchema.exclusiveMaximum then 'exclusive' else 'inclusive'}) maximum #{partialSchema.maximum}"

Engine::_n_json_schema_validation__5_1_2_maximum_exclusiveMaximum = (nContext) ->
  cls = @constructor
  ps = {
    maximum: nContext.nodeIn.maximum
    exclusiveMaximum: nContext.nodeIn.exclusiveMaximum
  }

  if ps.maximum == undefined and ps.exclusiveMaximum == undefined
    return

  if @_eAssert(nContext, ps.maximum == undefined or cls.isNumber(ps.maximum), { group: 'json-schema-validation', section: '5.1.2.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.exclusiveMaximum == undefined or cls.isBoolean(ps.exclusiveMaximum), { group: 'json-schema-validation', section: '5.1.2.1.b' }, ps)
    return

  if @_eAssert(nContext, ps.exclusiveMaximum == undefined or ps.maximum != undefined, { group: 'json-schema-validation', section: '5.1.2.1.c' }, ps)
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

  if ps.exclusiveMaximum
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value < ps.maximum, { group: 'json-schema-validation', section: '5.1.2.2.a' }, ps)

      return
  else
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value <= ps.maximum, { group: 'json-schema-validation', section: '5.1.2.2.a' }, ps)

      return
