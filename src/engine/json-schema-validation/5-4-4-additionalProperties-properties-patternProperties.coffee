Engine::_m_json_schema_validation__5_4_4_1_a = (id, info, nContext) ->
  'The value of "additionalProperties" MUST be a boolean or an object.'

Engine::_m_json_schema_validation__5_4_4_1_b = (id, info, nContext) ->
  'If "additionalProperties" is an object, it MUST also be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_4_1_c = (id, info, nContext) ->
  'The value of "properties" object MUST be an object.'

Engine::_m_json_schema_validation__5_4_4_1_d = (id, info, nContext) ->
  'Each value of "properties" MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_4_1_e = (id, info, nContext) ->
  'The value of "patternProperties" MUST be an object.'

Engine::_m_json_schema_validation__5_4_4_1_f = (id, info, nContext) ->
  'Each property name of "patternProperties" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect.'

Engine::_m_json_schema_validation__5_4_4_1_g = (id, info, nContext) ->
  'Each value of "patternProperties" object MUST be an object and MUST be a valid JSON Schema'

Engine::_m_json_schema_validation__5_4_4_2_a = (id, info, vContext) ->
  'has additional properties'

##
# 5.4.4.  additionalProperties, properties and patternProperties
Engine::_n_json_schema_validation__5_4_4_additionalProperties_properties_patternProperties = (nContext) ->
  cls = @constructor
  ps = {
    additionalProperties: nContext.nodeIn.additionalProperties
    properties: nContext.nodeIn.properties
    patternProperties: nContext.nodeIn.patternProperties
  }

  if ps.additionalProperties == undefined and ps.properties == undefined and ps.patternProperties == undefined
    return

  ei = {
    partialSchema: ps
  }

  rs = {
    additionalProperties: ps.additionalProperties
    properties: ps.properties
    patternProperties: ps.patternProperties
  }

  if rs.properties == undefined
    rs.properties = {}
  if rs.patternProperties == undefined
    rs.patternProperties = {}
  if rs.additionalProperties == undefined or rs.additionalProperties == true
    rs.additionalProperties = {}

  if @_eAssert(nContext, cls.isBoolean(rs.additionalProperties) or cls.isObject(rs.additionalProperties), { group: 'json-schema-validation', section: '5.4.4.1.a' }, ei)
    return

  if cls.isObject(rs.additionalProperties)
    rs.additionalProperties = @_normalizeAssert(nContext, rs.additionalProperties, ['additionalProperties'], { group: 'json-schema-validation', section: '5.4.4.1.b' }, ei)

  if @_eAssert(nContext, cls.isObject(rs.properties), { group: 'json-schema-validation', section: '5.4.4.1.c' }, ei)
    return

  rs.properties = do =>
    results = {}
    for name, subSchema of rs.properties
      if @_eAssert(nContext, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.4.4.1.d' }, ei)
        continue

      results[name] = @_normalizeAssert(nContext, subSchema, ['properties', name], { group: 'json-schema-validation', section: '5.4.4.1.d' }, ei)

    return results

  if @_eAssert(nContext, cls.isObject(rs.patternProperties), { group: 'json-schema-validation', section: '5.4.4.1.e' }, ei)
    return

  rs.patternProperties = do =>
    results = {}
    for pattern, subSchema of rs.patternProperties
      if @_eAssert(nContext, cls.isPattern(pattern), { group: 'json-schema-validation', section: '5.4.4.1.f' }, ei)
        continue

      if @_eAssert(nContext, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.4.4.1.g' }, ei)
        continue

      results[pattern] = @_normalizeAssert(nContext, subSchema, ['patternProperties', pattern], { group: 'json-schema-validation', section: '5.4.4.1.g' }, ei)

    return results

  if cls.isObject(rs.additionalProperties) and cls.isEmptyObject(rs.additionalProperties) and cls.isEmptyObject(rs.properties) and cls.isEmptyObject(rs.patternProperties)
    return

  nContext.nodeOut.additionalProperties = rs.additionalProperties
  nContext.nodeOut.properties = rs.properties
  nContext.nodeOut.patternProperties = rs.patternProperties

  return

Engine::_c_json_schema_validation__5_4_4_additionalProperties_properties_patternProperties = (cContext) ->
  cls = @constructor
  ps = {
    additionalProperties: cContext.node.additionalProperties
    properties: cContext.node.properties
    patternProperties: cContext.node.patternProperties
  }

  if ps.additionalProperties == undefined and ps.properties == undefined and ps.patternProperties == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  v = {
  }

  v.properties = do =>
    results = {}
    for own name, subSchema of ps.properties
      results[name] = @_compileChild(cContext, subSchema, ['properties', name])

    return results

  hasProperty = {}.hasOwnProperty.bind(v.properties)

  v.patternProperties = do =>
    results = []
    for own name, subSchema of ps.patternProperties
      results.push({
        e: new RegExp(name)
        v: @_compileChild(cContext, subSchema, ['patternProperties', name])
      })

    return results

  v.additionalProperties = if ps.additionalProperties == false then false else @_compileChild(cContext, ps.additionalProperties, ['additionalProperties'])

  return (vContext) =>
    if cls.isObject(vContext.value)
      hasAdditionalProperties = false

      for own name, value of vContext.value
        found = false

        if hasProperty(name)
          if (validator = v.properties[name])
            @_validateChild(vContext, validator, value, [name])
          found = true

        for patternProperty in v.patternProperties
          if patternProperty.e.test(name)
            if (validator = patternProperty.v)
              @_validateChild(vContext, validator, value, [name])
            found = true

        if not found
          hasAdditionalProperties = true
          if (validator = v.additionalProperties) != false and validator?
            @_validateChild(vContext, validator, value, [name])

      @_eAssert(vContext, not hasAdditionalProperties or v.additionalProperties != false, { group: 'json-schema-validation', section: '5.4.4.2.a' }, ei)

    return




