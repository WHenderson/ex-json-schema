Engine::_m_json_schema_validation__5_4_4_1_a = (id, partialSchema, context) ->
  'The value of "additionalProperties" MUST be a boolean or an object.'

Engine::_m_json_schema_validation__5_4_4_1_b = (id, partialSchema, context) ->
  'If "additionalProperties" is an object, it MUST also be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_4_1_c = (id, partialSchema, context) ->
  'The value of "properties" object MUST be an object.'

Engine::_m_json_schema_validation__5_4_4_1_d = (id, partialSchema, context) ->
  'Each value of "properties" MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_4_4_1_e = (id, partialSchema, context) ->
  'The value of "patternProperties" MUST be an object.'

Engine::_m_json_schema_validation__5_4_4_1_f = (id, partialSchema, context) ->
  'Each property name of "patternProperties" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect.'

Engine::_m_json_schema_validation__5_4_4_1_g = (id, partialSchema, context) ->
  'Each value of "patternProperties" object MUST be an object and MUST be a valid JSON Schema'

##
# 5.4.4.  additionalProperties, properties and patternProperties
Engine::_n_json_schema_validation__5_4_4_additionalProperties_properties_patternProperties = (context) ->
  cls = @constructor
  ps = {
    additionalProperties: context.nodeIn.additionalProperties
    properties: context.nodeIn.properties
    patternProperties: context.nodeIn.patternProperties
  }

  if ps.additionalProperties == undefined and ps.properties == undefined and ps.patternProperties == undefined
    return

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

  if @_eAssert(context, cls.isBoolean(rs.additionalProperties) or cls.isObject(rs.additionalProperties), { group: 'json-schema-validation', section: '5.4.4.1.a' }, ps)
    return

  if cls.isObject(rs.additionalProperties)
    rs.additionalProperties = @_normalizeAssert(context, rs.additionalProperties, ['additionalProperties'], { group: 'json-schema-validation', section: '5.4.4.1.b' }, ps)

  if @_eAssert(context, cls.isObject(rs.properties), { group: 'json-schema-validation', section: '5.4.4.1.c' }, ps)
    return

  rs.properties = do =>
    results = {}
    for name, subSchema of rs.properties
      if @_eAssert(context, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.4.4.1.d' }, ps)
        continue

      results[name] = @_normalizeAssert(context, subSchema, ['properties', name], { group: 'json-schema-validation', section: '5.4.4.1.d' }, ps)

    return results

  if @_eAssert(context, cls.isObject(rs.patternProperties), { group: 'json-schema-validation', section: '5.4.4.1.e' }, ps)
    return

  rs.patternProperties = do =>
    results = {}
    for pattern, subSchema of rs.patternProperties
      if @_eAssert(context, cls.isPattern(pattern), { group: 'json-schema-validation', section: '5.4.4.1.f' }, ps)
        continue

      if @_eAssert(context, cls.isObject(subSchema), { group: 'json-schema-validation', section: '5.4.4.1.g' }, ps)
        continue

      results[pattern] = @_normalizeAssert(context, subSchema, ['patternProperties', pattern], { group: 'json-schema-validation', section: '5.4.4.1.g' }, ps)

    return results

  if cls.isObject(rs.additionalProperties) and cls.isEmptyObject(rs.additionalProperties) and cls.isEmptyObject(rs.properties) and cls.isEmptyObject(rs.patternProperties)
    return

  context.nodeOut.additionalProperties = rs.additionalProperties
  context.nodeOut.properties = rs.properties
  context.nodeOut.patternProperties = rs.patternProperties

  return
