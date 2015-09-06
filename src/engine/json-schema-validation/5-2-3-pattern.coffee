Engine::_m_json_schema_validation__5_2_3_1_a = (id, partialSchema, context) ->
  'The value of "pattern" MUST be a string.'

Engine::_m_json_schema_validation__5_2_3_1_b = (id, partialSchema, context) ->
  'The value of "pattern" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect.'

Engine::_n_json_schema_validation__5_2_3_pattern = (context) ->
  cls = @constructor
  ps = {
    pattern: context.nodeIn.pattern
  }

  if ps.pattern == undefined
    return

  if @_eAssert(context, cls.isString(ps.pattern), { group: 'json-schema-validation', section: '5.2.3.1.a' }, ps)
    return

  if @_wAssert(context, cls.isPattern(ps.pattern), { group: 'json-schema-validation', section: '5.2.3.1.b' }, ps)
    return

  if ps.pattern == ''
    return

  context.nodeOut.pattern = ps.pattern

  return
