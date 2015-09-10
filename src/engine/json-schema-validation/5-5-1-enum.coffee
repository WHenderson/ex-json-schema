Engine::_m_json_schema_validation__5_5_1_1_a = (id, partialSchema, nContext) ->
  'The value of "enum" MUST be an array.'

Engine::_m_json_schema_validation__5_5_1_1_b = (id, partialSchema, nContext) ->
  'The value of "enum" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_1_1_c = (id, partialSchema, nContext) ->
  'Elements in "enum" MUST be unique.'

Engine::_m_json_schema_validation__5_5_1_2_a = (id, partialSchema, vContext) ->
  'must be an enum value'

Engine::_n_json_schema_validation__5_5_1_enum = (nContext) ->
  cls = @constructor
  ps = {
    enum: nContext.nodeIn.enum
  }

  if ps.enum == undefined
    return

  rs = {
    enum: ps.enum
  }

  if @_eAssert(nContext, cls.isArray(rs.enum), { group: 'json-schema-validation', section: '5.5.1.1.a' }, ps)
    return

  rs.enum = cls.jsonDeepCopy(rs.enum)

  if @_eAssert(nContext, rs.enum.length != 0, { group: 'json-schema-validation', section: '5.5.1.1.b' }, ps)
    return

  if @_eAssert(nContext, cls.areJsonArrayElementsUnique(rs.enum), { group: 'json-schema-validation', section: '5.5.1.1.c' }, ps)
    rs.enum = cls.jsonArrayFilterDuplicates(rs.enum)

  nContext.nodeOut.enum = rs.enum

  return

Engine::_c_json_schema_validation__5_5_1_enum = (cContext) ->
  cls = @constructor
  ps = {
    enum: cContext.node.enum
  }

  if ps.enum == undefined
    return

  return (vContext) =>
    found = false
    for element in ps.enum
      if cls.isJsonDeepEqual(element, vContext.value)
        found = true
        break

    @_eAssert(vContext, found, { group: 'json-schema-validation', section: '5.5.1.2.a' }, ps)
    return
