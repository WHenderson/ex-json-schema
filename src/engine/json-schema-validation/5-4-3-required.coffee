Engine::_m_json_schema_validation__5_4_3_1_a = (id, partialSchema, nContext) ->
  'The value of "required" keyword MUST be an array'

Engine::_m_json_schema_validation__5_4_3_1_b = (id, partialSchema, nContext) ->
  'The value of "required" array MUST have at least one element'

Engine::_m_json_schema_validation__5_4_3_1_c = (id, partialSchema, nContext) ->
  'Elements of "required" MUST be strings'

Engine::_m_json_schema_validation__5_4_3_1_d = (id, partialSchema, nContext) ->
  'Elements of "required" MUST be unique'

Engine::_m_json_schema_validation__5_4_3_2_a = (id, partialSchema, vContext) ->
  "is missing required field #{partialSchema.required}"

Engine::_n_json_schema_validation__5_4_3_required = (nContext) ->
  cls = @constructor
  ps = {
    required: nContext.nodeIn.required
  }
  rs = {
  }

  if ps.required == undefined
    return

  if @_eAssert(nContext, cls.isArray(ps.required), { group: 'json-schema-validation', section: '5.4.3.1.a' }, ps)
    return

  if @_eAssert(nContext, ps.required.length != 0, { group: 'json-schema-validation', section: '5.4.3.1.b' }, ps)
    return

  allStrings = true
  rs.required = for element in ps.required
    if not cls.isString(element)
      allStrings = false
      continue
    element

  @_eAssert(nContext, allStrings, { group: 'json-schema-validation', section: '5.4.3.1.c' }, ps)

  if @_eAssert(nContext, cls.areJsonArrayElementsUnique(rs.required), { group: 'json-schema-validation', section: '5.4.3.1.d' }, ps)
    rs.required = cls.jsonArrayFilterDuplicates(rs.required)

  if rs.required.length == 0
    return

  nContext.nodeOut.required = rs.required

  return

Engine::_c_json_schema_validation__5_4_3_required = (cContext) ->
  cls = @constructor
  ps = {
    required: cContext.node.required
  }

  if ps.required == undefined
    return

  hasProp = {}.hasOwnProperty

  return (vContext) =>
    if cls.isObject(vContext.value)
      for own name, iName of ps.required
        @_eAssert(vContext, hasProp.call(vContext.value, name), { group: 'json-schema-validation', section: '5.4.3.2.a' }, ps)

    return
