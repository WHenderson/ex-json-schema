Engine::_m_json_schema_validation__5_1_2_1_a = (id, partialSchema, context) ->
  'The value of "maximum" MUST be a JSON number.'

Engine::_m_json_schema_validation__5_1_2_1_b = (id, partialSchema, context) ->
  'The value of "exclusiveMaximum" MUST be a boolean.'

Engine::_m_json_schema_validation__5_1_2_1_c = (id, partialSchema, context) ->
  'If "exclusiveMaximum" is present, "maximum" MUST also be present.'

Engine::_n_json_schema_validation__5_1_2_maximum_exclusiveMaximum = (context) ->
  cls = @constructor
  ps = {
    maximum: context.nodeIn.maximum
    exclusiveMaximum: context.nodeIn.exclusiveMaximum
  }

  if ps.maximum == undefined and ps.exclusiveMaximum == undefined
    return

  if @_eAssert(context, ps.maximum == undefined or cls.isNumber(ps.maximum), { group: 'json-schema-validation', section: '5.1.2.1.a' }, ps)
    return

  if @_eAssert(context, ps.exclusiveMaximum == undefined or cls.isBoolean(ps.exclusiveMaximum), { group: 'json-schema-validation', section: '5.1.2.1.b' }, ps)
    return

  if @_eAssert(context, ps.exclusiveMaximum == undefined or ps.maximum != undefined, { group: 'json-schema-validation', section: '5.1.2.1.c' }, ps)
    return

  context.nodeOut.maximum = ps.maximum
  context.nodeOut.exclusiveMaximum = ps.exclusiveMaximum ? false

  return
