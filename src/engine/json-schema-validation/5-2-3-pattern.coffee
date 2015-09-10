Engine::_m_json_schema_validation__5_2_3_1_a = (id, partialSchema, nContext) ->
  'The value of "pattern" MUST be a string.'

Engine::_m_json_schema_validation__5_2_3_1_b = (id, partialSchema, nContext) ->
  'The value of "pattern" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect.'

Engine::_m_json_schema_validation__5_2_3_2_a = (id, partialSchema, vContext) ->
  "does not match pattern #{partialSchema.pattern}"

Engine::_n_json_schema_validation__5_2_3_pattern = (nContext) ->
  cls = @constructor
  ps = {
    pattern: nContext.nodeIn.pattern
  }

  if ps.pattern == undefined
    return

  if @_eAssert(nContext, cls.isString(ps.pattern), { group: 'json-schema-validation', section: '5.2.3.1.a' }, ps)
    return

  if @_wAssert(nContext, cls.isPattern(ps.pattern), { group: 'json-schema-validation', section: '5.2.3.1.b' }, ps)
    return

  if ps.pattern == ''
    return

  nContext.nodeOut.pattern = ps.pattern

  return

Engine::_c_json_schema_validation__5_2_3_pattern = (cContext) ->
  cls = @constructor
  ps = {
    pattern: cContext.node.pattern
  }

  if ps.pattern == undefined
    return

  expression = new RegExp(ps.pattern)
  return (vContext) =>
    if cls.isString(vContext.value)
      @_eAssert(vContext, expression.test(vContext.value), { group: 'json-schema-validation', section: '5.2.3.2.a' }, ps)

    return
