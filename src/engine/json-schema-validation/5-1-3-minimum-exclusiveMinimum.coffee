Engine::_m_json_schema_validation__5_1_3_1_a = (id, partialSchema, nContext) ->
  'The value of "minimum" MUST be a JSON number.'

Engine::_m_json_schema_validation__5_1_3_1_b = (id, partialSchema, nContext) ->
  'The value of "exclusiveMinimum" MUST be a boolean.'

Engine::_m_json_schema_validation__5_1_3_1_c = (id, partialSchema, nContext) ->
  'If "exclusiveMinimum" is present, "minimum" MUST also be present.'

Engine::_m_json_schema_validation__5_1_3_2_a = (id, partialSchema, vContext) ->
  "is less than (#{if partialSchema.exclusiveMinimum then 'exclusive' else 'inclusive'}) minimum #{partialSchema.minimum}"

Engine::_n_json_schema_validation__5_1_3_minimum_exclusiveMinimum = (nContext) ->
  cls = @constructor
  ps = {
    minimum: nContext.nodeIn.minimum
    exclusiveMinimum: nContext.nodeIn.exclusiveMinimum
  }

  if ps.minimum == undefined and ps.exclusiveMinimum == undefined
    return

  if @_eAssert(nContext, ps.minimum == undefined or cls.isNumber(ps.minimum), { group: 'json-schema-validation', section: '5.1.3.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.exclusiveMinimum == undefined or cls.isBoolean(ps.exclusiveMinimum), { group: 'json-schema-validation', section: '5.1.3.1.b' }, ps)
    return

  if @_eAssert(nContext, ps.exclusiveMinimum == undefined or ps.minimum != undefined, { group: 'json-schema-validation', section: '5.1.3.1.c' }, ps)
    return

  nContext.nodeOut.minimum = ps.minimum
  nContext.nodeOut.exclusiveMinimum = ps.exclusiveMinimum ? false

  return

Engine::_c_json_schema_validation__5_1_3_minimum_exclusiveMinimum = (cContext) ->
  cls = @constructor
  ps = {
    minimum: cContext.node.minimum
    exclusiveMinimum: cContext.node.exclusiveMinimum
  }

  if ps.minimum == undefined and ps.exclusiveMinimum == undefined
    return

  if ps.exclusiveMinimum
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value > ps.minimum, { group: 'json-schema-validation', section: '5.1.3.2.a' }, ps)

      return
  else
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value >= ps.minimum, { group: 'json-schema-validation', section: '5.1.3.2.a' }, ps)

      return
