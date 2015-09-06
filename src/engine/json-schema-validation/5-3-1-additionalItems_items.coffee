Engine::_m_json_schema_validation__5_3_1_1_a = (id, partialSchema, context) ->
  'The value of "additionalItems" MUST be either a boolean or an object.'

Engine::_m_json_schema_validation__5_3_1_1_b = (id, partialSchema, context) ->
  'If "additionalItems" is an object, it MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_3_1_1_c = (id, partialSchema, context) ->
  'The value of "items" MUST be either an object or an array.'

Engine::_m_json_schema_validation__5_3_1_1_d = (id, partialSchema, context) ->
  'If "items" is an object, this object MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_3_1_1_e = (id, partialSchema, context) ->
  'If "items" is an array, items of this array MUST be objects, and each of these objects MUST be a valid JSON Schema.'

Engine::_n_json_schema_validation__5_3_1_additionalItems_items = (context) ->
  cls = @constructor
  ps = {
    additionalItems: context.nodeIn.additionalItems,
    items: context.nodeIn.items
  }
  rs = {
  }

  if ps.items == undefined and ps.additionalItems == undefined
    return

  if ps.additionalItems != undefined
    if @_eAssert(context, cls.isBoolean(ps.additionalItems) or cls.isObject(ps.additionalItems), { group: 'json-schema-validation', section: '5.3.1.1.a' }, ps)
      rs.additionalItems = {}
    else
      if cls.isObject(ps.additionalItems)
        rs.additionalItems = @_normalizeAssert(context, ps.additionalItems, ['additionalItems'], { group: 'json-schema-validation', section: '5.3.1.1.b' }, ps)
      else
        rs.additionalItems = if ps.additionalItems then {} else false
  else
    rs.additionalItems = {}

  if ps.items != undefined
    if @_eAssert(context, cls.isObject(ps.items) or cls.isArray(ps.items), { group: 'json-schema-validation', section: '5.3.1.1.c' }, ps)
      rs.items = {}
      rs.additionalItems = undefined
    else
      if cls.isObject(ps.items)
        rs.items = @_normalizeAssert(context, ps.items, ['items'], { group: 'json-schema-validation', section: '5.3.1.1.d' }, ps)
        rs.additionalItems = undefined
      else
        rs.items = ps.items.map(
          (item, iItem) =>
            if @_eAssert(context, cls.isObject(item), { group: 'json-schema-validation', section: '5.3.1.1.e' }, ps)
              return {}
            return @_normalizeAssert(context, item, ['items', iItem], { group: 'json-schema-validation', section: '5.3.1.1.e' }, ps)
        )
  else
    rs.items = {}
    rs.additionalItems = undefined

  if (cls.isObject(rs.items) and cls.isEmptyObject(rs.items)) and ((cls.isObject(rs.additionalItems) and cls.isEmptyObject(rs.additionalItems)) or (rs.additionalItems == undefined))
    return

  if rs.additionalItems != undefined
    context.nodeOut.additionalItems = rs.additionalItems
  context.nodeOut.items = rs.items

  return
