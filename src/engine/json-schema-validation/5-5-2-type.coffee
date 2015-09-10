Engine::_m_json_schema_validation__5_5_2_1_a = (id, info, nContext) ->
  'The value of "type" MUST be either a string or an array.'

Engine::_m_json_schema_validation__5_5_2_1_b = (id, info, nContext) ->
  'If "type" is an array, elements of the array MUST be strings.'

Engine::_m_json_schema_validation__5_5_2_1_c = (id, info, nContext) ->
  'If "type" is an array, elements of the array MUST be unique.'

Engine::_m_json_schema_validation__5_5_2_1_d = (id, info, nContext) ->
  'The value(s) of "type" MUST be one of the seven primitive types defined by the core specification.'

Engine::_m_json_schema_validation__5_5_2_2_a = (id, info, vContext) ->
  if partialSchema.type.length == 1
    l_type = partialSchema.type[0]
    if l_type.length != 0 and 'aeiou'.indexOf(l_type[0].toLowerCase()) != -1
      adverb = 'an'
    else
      adverb = 'a'

    return "must be #{adverb} #{l_type[0]}"
  else
    return "must be one of #{partialSchema.type.join(', ')}"

Engine::_n_json_schema_validation__5_5_2_type = (nContext) ->
  cls = @constructor
  ps = {
    type: nContext.nodeIn.type
  }

  if ps.type == undefined
    return

  ei = {
    partialSchema: ps
  }

  rs = {
    type: ps.type
  }

  if @_eAssert(nContext, cls.isString(rs.type) or cls.isArray(rs.type), { group: 'json-schema-validation', section: '5.5.2.1.a' }, ei)
    return

  if cls.isArray(rs.type)
    rs.type = do =>
      results = []
      for element in rs.type
        if @_eAssert(nContext, cls.isString(element), { group: 'json-schema-validation', section: '5.5.2.1.b' }, ei)
          continue
        if @_eAssert(nContext, ['array', 'boolean', 'integer', 'number', 'null', 'object', 'string'].indexOf(element) != -1, { group: 'json-schema-validation', section: '5.5.2.1.d' }, ei)
          continue
        results.push(element)
      return results

    if @_eAssert(nContext, cls.areJsonArrayElementsUnique(rs.type), { group: 'json-schema-validation', section: '5.5.2.1.c' }, ei)
      rs.type = cls.jsonArrayFilterDuplicates(rs.type)
  else
    if @_eAssert(nContext, ['array', 'boolean', 'integer', 'number', 'null', 'object', 'string'].indexOf(rs.type) != -1, { group: 'json-schema-validation', section: '5.5.2.1.d' }, ei)
      return

    rs.type = [rs.type]

  nContext.nodeOut.type = rs.type

  return

Engine::_c_json_schema_validation__5_5_2_type = (cContext) ->
  cls = @constructor
  ps = {
    type: cContext.node.type
  }

  if ps.type == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  v = {
  }

  v.type = do ->
    results = []
    for type in ps.type
      isType = switch type
        when 'array' then cls.isArray
        when 'boolean' then cls.isBoolean
        when 'integer' then cls.isInteger
        when 'number' then cls.isNumber
        when 'null' then cls.isNull
        when 'object' then cls.isObject
        when 'string' then cls.isString

      results.push(isType.bind(cls))

    return results

  return (vContext) ->
    @_eAssert(
      vContext,
      v.type.some(
        (isType) ->
          isType(vContext.value)
      ),
      { group: 'json-schema-validation', section: '5.5.2.2.a' },
      ps
    )

    return

