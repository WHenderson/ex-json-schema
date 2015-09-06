Engine::_m_json_schema_validation__5_5_3_1_a = (id, partialSchema, context) ->
  'The value of "allOf" MUST be an array.'

Engine::_m_json_schema_validation__5_5_3_1_b = (id, partialSchema, context) ->
  'The value of "allOf" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_3_1_c = (id, partialSchema, context) ->
  'Elements of "allOf" MUST be objects'

Engine::_m_json_schema_validation__5_5_3_1_d = (id, partialSchema, context) ->
  'Elements of "allOf" MUST be valid JSON Schemas'

Engine::_n_json_schema_validation__5_5_3_allOf = (context) ->
  cls = @constructor
  ps = {
    allOf: context.nodeIn.allOf
  }

  if ps.allOf == undefined
    return

  rs = {
    allOf: ps.allOf
  }

  if @_eAssert(context, cls.isArray(rs.allOf), { group: 'json-schema-validation', section: '5.5.3.1.a' }, ps)
    return

  rs.allOf = do =>
    results = []
    for subSchema, iSubSchema in rs.allOf
      if @_eAssert(context, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.5.3.1.c' }, ps)
        continue
      subSchema = @_normalizeAssert(context, subSchema, ['allOf', iSubSchema], { group: 'json-schema-validation', section: '5.5.3.1.d' }, ps)
      results.push(subSchema)
    return results

  if @_eAssert(context, rs.allOf.length != 0, { group: 'json-schema-validation', section: '5.5.3.1.b' }, ps)
    return

  context.nodeOut.allOf = rs.allOf

  return
