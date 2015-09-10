Engine::_m_json_schema_validation__5_5_7_1_a = (id, partialSchema, nContext) ->
  'The value of "definitions" MUST be an object.'

Engine::_m_json_schema_validation__5_5_7_1_b = (id, partialSchema, nContext) ->
  'Each member of "definitions" MUST be a valid JSON Schema.'

Engine::_n_json_schema_validation__5_5_7_definitions = (nContext) ->
  cls = @constructor
  ps = {
    definitions: nContext.nodeIn.definitions
  }

  if ps.definitions == undefined
    return

  rs = {
    definitions: ps.definitions
  }

  if @_eAssert(nContext, cls.isObject(rs.definitions), { group: 'json-schema-validation', section: '5.5.7.1.a' }, ps)
    return

  rs.definitions = do =>
    results = {}
    for name, subSchema of rs.definitions
      if @_eAssert(nContext, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.5.7.1.b' }, ps)
        continue

      results[name] = @_normalizeAssert(nContext, subSchema, ['definitions', name], { group: 'json-schema-validation', section: '5.5.7.1.b' }, ps)
    return results

  if cls.isEmptyObject(rs.definitions)
    return

  nContext.nodeOut.definitions = rs.definitions

  return
