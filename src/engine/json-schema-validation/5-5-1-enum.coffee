Engine::_m_json_schema_validation__5_5_1_1_a = (id, partialSchema, context) ->
  'The value of "enum" MUST be an array.'

Engine::_m_json_schema_validation__5_5_1_1_b = (id, partialSchema, context) ->
  'The value of "enum" MUST have at least one element.'

Engine::_m_json_schema_validation__5_5_1_1_c = (id, partialSchema, context) ->
  'Elements in "enum" MUST be unique.'

Engine::_n_json_schema_validation__5_5_1_enum = (context) ->
  cls = @constructor
  ps = {
    enum: context.nodeIn.enum
  }

  if ps.enum == undefined
    return

  rs = {
    enum: ps.enum
  }

  if @_eAssert(context, cls.isArray(rs.enum), { group: 'json-schema-validation', section: '5.5.1.1.a' }, ps)
    return

  rs.enum = cls.jsonDeepCopy(rs.enum)

  if @_eAssert(context, rs.enum.length != 0, { group: 'json-schema-validation', section: '5.5.1.1.b' }, ps)
    return

  if @_eAssert(context, cls.areJsonArrayElementsUnique(rs.enum), { group: 'json-schema-validation', section: '5.5.1.1.c' }, ps)
    rs.enum = cls.jsonArrayFilterDuplicates(rs.enum)

  context.nodeOut.enum = rs.enum

  return
