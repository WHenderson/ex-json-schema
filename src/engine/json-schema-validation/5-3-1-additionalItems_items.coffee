Engine::_m_json_schema_validation__5_3_1_1_a = (id, info, nContext) ->
  'The value of "additionalItems" MUST be either a boolean or an object.'

Engine::_m_json_schema_validation__5_3_1_1_b = (id, info, nContext) ->
  'If "additionalItems" is an object, it MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_3_1_1_c = (id, info, nContext) ->
  'The value of "items" MUST be either an object or an array.'

Engine::_m_json_schema_validation__5_3_1_1_d = (id, info, nContext) ->
  'If "items" is an object, this object MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_3_1_1_e = (id, info, nContext) ->
  'If "items" is an array, items of this array MUST be objects, and each of these objects MUST be a valid JSON Schema.'

Engine::_m_json_schema_validation__5_3_1_2_a = (id, info, vContext) ->
  'has additional items'

Engine::_n_json_schema_validation__5_3_1_additionalItems_items = (nContext) ->
  cls = @constructor
  ps = {
    additionalItems: nContext.nodeIn.additionalItems,
    items: nContext.nodeIn.items
  }
  rs = {
  }

  if ps.items == undefined and ps.additionalItems == undefined
    return

  ei = {
    partialSchema: ps
  }

  if ps.additionalItems != undefined
    if @_eAssert(nContext, cls.isBoolean(ps.additionalItems) or cls.isObject(ps.additionalItems), { group: 'json-schema-validation', section: '5.3.1.1.a' }, ei)
      rs.additionalItems = {}
    else
      if cls.isObject(ps.additionalItems)
        rs.additionalItems = @_normalizeAssert(nContext, ps.additionalItems, ['additionalItems'], { group: 'json-schema-validation', section: '5.3.1.1.b' }, ei)
      else
        rs.additionalItems = if ps.additionalItems then {} else false
  else
    rs.additionalItems = {}

  if ps.items != undefined
    if @_eAssert(nContext, cls.isObject(ps.items) or cls.isArray(ps.items), { group: 'json-schema-validation', section: '5.3.1.1.c' }, ei)
      rs.items = {}
      rs.additionalItems = undefined
    else
      if cls.isObject(ps.items)
        rs.items = @_normalizeAssert(nContext, ps.items, ['items'], { group: 'json-schema-validation', section: '5.3.1.1.d' }, ei)
        rs.additionalItems = undefined
      else
        rs.items = ps.items.map(
          (item, iItem) =>
            if @_eAssert(nContext, cls.isObject(item), { group: 'json-schema-validation', section: '5.3.1.1.e' }, ei)
              return {}
            return @_normalizeAssert(nContext, item, ['items', iItem], { group: 'json-schema-validation', section: '5.3.1.1.e' }, ei)
        )
  else
    rs.items = {}
    rs.additionalItems = undefined

  if (cls.isObject(rs.items) and cls.isEmptyObject(rs.items)) and ((cls.isObject(rs.additionalItems) and cls.isEmptyObject(rs.additionalItems)) or (rs.additionalItems == undefined))
    return

  if rs.additionalItems != undefined
    nContext.nodeOut.additionalItems = rs.additionalItems
  nContext.nodeOut.items = rs.items

  return

Engine::_c_json_schema_validation__5_3_1_additionalItems_items = (cContext) ->
  cls = @constructor
  ps = {
    additionalItems: cContext.node.additionalItems,
    items: cContext.node.items
  }

  if ps.items == undefined and ps.additionalItems == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  v = {
  }

  if not cls.isArray(ps.items)
    # 8.2.3.1.  If `items` is a schema

    v.items = @_compileChild(cContext, ps.items, ['items'])

    if not v.items?
      return

    return (vContext) =>
      if cls.isArray(vContext.value)
        for element, iElement in vContext.value
          @_validateChild(vContext, v.items, element, [iElement])
      return
  else
    # 8.2.3.2.  If `items` is an array

    v.items = for item, iItem in ps.items
      @_compileChild(cContext, item, ['items', iItem])

    v.additionalItems = if ps.additionalItems == false then false else @_compileChild(cContext, ps.additionalItems, ['additionalItems'])

    # No validation required
    if not v.items.some((item) -> item?) and not v.additionalItems?
      return

    return (vContext) =>
      if cls.isArray(vContext.value)
        for vItem, iItem in v.items
          if vItem?
            @_validateChild(vContext, vItem, vContext.value[iItem], [iItem])

        if v.additionalItems == false
          @_eAssert(vContext, iItem == vContext.value.length, { group: 'json-schema-validation', section: '5.3.1.2.a' }, ei)
        else if v.additionalItems?
          while iItem != vContext.value.length
            @_validateChild(vContext, v.additionalItems, vContext.value[iItem], [iItem])
            iItem += 1

      return
