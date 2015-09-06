Engine::_m_json_schema_validation__5_5_2_1_a = (id, partialSchema, context) ->
  'The value of "type" MUST be either a string or an array.'

Engine::_m_json_schema_validation__5_5_2_1_b = (id, partialSchema, context) ->
  'If "type" is an array, elements of the array MUST be strings.'

Engine::_m_json_schema_validation__5_5_2_1_c = (id, partialSchema, context) ->
  'If "type" is an array, elements of the array MUST be unique.'

Engine::_m_json_schema_validation__5_5_2_1_d = (id, partialSchema, context) ->
  'The value(s) of "type" MUST be one of the seven primitive types defined by the core specification.'

Engine::_n_json_schema_validation__5_5_2_type = (context) ->
  cls = @constructor
  ps = {
    type: context.nodeIn.type
  }

  if ps.type == undefined
    return

  rs = {
    type: ps.type
  }

  if @_eAssert(context, cls.isString(rs.type) or cls.isArray(rs.type), { group: 'json-schema-validation', section: '5.5.2.1.a' }, ps)
    return

  if cls.isArray(rs.type)
    rs.type = do =>
      results = []
      for element in rs.type
        if @_eAssert(context, cls.isString(element), { group: 'json-schema-validation', section: '5.5.2.1.b' }, ps)
          continue
        if @_eAssert(context, ['array', 'boolean', 'integer', 'number', 'null', 'object', 'string'].indexOf(element) != -1, { group: 'json-schema-validation', section: '5.5.2.1.d' }, ps)
          continue
        results.push(element)
      return results

    if @_eAssert(context, cls.areJsonArrayElementsUnique(rs.type), { group: 'json-schema-validation', section: '5.5.2.1.c' }, ps)
      rs.type = cls.jsonArrayFilterDuplicates(rs.type)
  else
    if @_eAssert(context, ['array', 'boolean', 'integer', 'number', 'null', 'object', 'string'].indexOf(rs.type) != -1, { group: 'json-schema-validation', section: '5.5.2.1.d' }, ps)
      return

    rs.type = [rs.type]

  context.nodeOut.type = rs.type

  return
