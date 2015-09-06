Engine::_m_json_schema_validation__5_4_3_1_a = (id, partialSchema, context) ->
  'The value of "required" keyword MUST be an array'

Engine::_m_json_schema_validation__5_4_3_1_b = (id, partialSchema, context) ->
  'The value of "required" array MUST have at least one element'

Engine::_m_json_schema_validation__5_4_3_1_c = (id, partialSchema, context) ->
  'Elements of "required" MUST be strings'

Engine::_m_json_schema_validation__5_4_3_1_d = (id, partialSchema, context) ->
  'Elements of "required" MUST be unique'


Engine::_n_json_schema_validation__5_4_3_required = (context) ->
  cls = @constructor
  ps = {
    required: context.nodeIn.required
  }
  rs = {
  }

  if ps.required == undefined
    return

  if @_eAssert(context, cls.isArray(ps.required), { group: 'json-schema-validation', section: '5.4.3.1.a' }, ps)
    return

  if @_eAssert(context, ps.required.length != 0, { group: 'json-schema-validation', section: '5.4.3.1.b' }, ps)
    return

  allStrings = true
  rs.required = for element in ps.required
    if not cls.isString(element)
      allStrings = false
      continue
    element

  @_eAssert(context, allStrings, { group: 'json-schema-validation', section: '5.4.3.1.c' }, ps)

  if @_eAssert(context, cls.areJsonArrayElementsUnique(rs.required), { group: 'json-schema-validation', section: '5.4.3.1.d' }, ps)
    rs.required = cls.jsonArrayFilterDuplicates(rs.required)

  if rs.required.length == 0
    return

  context.nodeOut.required = rs.required

  return
