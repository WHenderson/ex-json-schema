Engine::_m_json_schema_validation__5_5_5_1_a = (id, partialSchema, context) ->
  'The value of "oneOf" MUST be an array.'

Engine::_m_json_schema_validation__5_5_5_1_b = (id, partialSchema, context) ->
  'The value of "oneOf" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_5_1_c = (id, partialSchema, context) ->
  'Elements of "oneOf" MUST be objects'

Engine::_m_json_schema_validation__5_5_5_1_d = (id, partialSchema, context) ->
  'Elements of "oneOf" MUST be valid JSON Schemas'

Engine::_n_json_schema_validation__5_5_5_oneOf = (context) ->
  cls = @constructor
  ps = {
    oneOf: context.nodeIn.oneOf
  }

  if ps.oneOf == undefined
    return

  rs = {
    oneOf: ps.oneOf
  }

  if @_eAssert(context, cls.isArray(rs.oneOf), { group: 'json-schema-validation', section: '5.5.5.1.a' }, ps)
    return

  rs.oneOf = do =>
    results = []
    for subSchema, iSubSchema in rs.oneOf
      if @_eAssert(context, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.5.5.1.c' }, ps)
        continue
      subSchema = @_normalizeAssert(context, subSchema, ['oneOf', iSubSchema], { group: 'json-schema-validation', section: '5.5.5.1.d' }, ps)
      results.push(subSchema)
    return results

  if @_eAssert(context, rs.oneOf.length != 0, { group: 'json-schema-validation', section: '5.5.5.1.b' }, ps)
    return

  context.nodeOut.oneOf = rs.oneOf

  return
