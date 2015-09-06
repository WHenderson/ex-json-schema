Engine::_m_json_schema_validation__5_1_3_1_a = (info) ->
  'The value of "minimum" MUST be a JSON number.'

Engine::_m_json_schema_validation__5_1_3_1_b = (info) ->
  'The value of "exclusiveMinimum" MUST be a boolean.'

Engine::_m_json_schema_validation__5_1_3_1_c = (info) ->
  'If "exclusiveMinimum" is present, "minimum" MUST also be present.'

Engine::_n_json_schema_validation__5_1_3_minimum_exclusiveMinimum = (context) ->
  cls = @constructor
  ps = {
    minimum: context.nodeIn.minimum
    exclusiveMinimum: context.nodeIn.exclusiveMinimum
  }

  if ps.minimum == undefined and ps.exclusiveMinimum == undefined
    return

  if @_eAssert(context, ps.minimum == undefined or cls.isNumber(ps.minimum), { group: 'json-schema-validation', section: '5.1.3.1.a' }, ps)
    return

  if @_eAssert(context, ps.exclusiveMinimum == undefined or cls.isBoolean(ps.exclusiveMinimum), { group: 'json-schema-validation', section: '5.1.3.1.b' }, ps)
    return

  if @_eAssert(context, ps.exclusiveMinimum == undefined or ps.minimum != undefined, { group: 'json-schema-validation', section: '5.1.3.1.c' }, ps)
    return

  context.nodeOut.minimum = ps.minimum
  context.nodeOut.exclusiveMinimum = ps.exclusiveMinimum ? false

  return
