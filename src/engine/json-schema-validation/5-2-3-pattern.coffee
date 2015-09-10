Engine::_m_json_schema_validation__5_2_3_1_a = (id, info, nContext) ->
  'The value of "pattern" MUST be a string.'

Engine::_m_json_schema_validation__5_2_3_1_b = (id, info, nContext) ->
  'The value of "pattern" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect.'

Engine::_m_json_schema_validation__5_2_3_2_a = (id, info, vContext) ->
  "does not match pattern #{partialSchema.pattern}"

Engine::_n_json_schema_validation__5_2_3_pattern = (nContext) ->
  cls = @constructor
  ps = {
    pattern: nContext.nodeIn.pattern
  }

  if ps.pattern == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isString(ps.pattern), { group: 'json-schema-validation', section: '5.2.3.1.a' }, ei)
    return

  if @_wAssert(nContext, cls.isPattern(ps.pattern), { group: 'json-schema-validation', section: '5.2.3.1.b' }, ei)
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

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  expression = new RegExp(ps.pattern)
  return (vContext) =>
    if cls.isString(vContext.value)
      @_eAssert(vContext, expression.test(vContext.value), { group: 'json-schema-validation', section: '5.2.3.2.a' }, ei)

    return
