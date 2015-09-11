Engine::_m_json_schema_validation__5_3_4_1_a = (id, info, nContext) ->
  'The value of "uniqueItems" keyword MUST be a boolean'

Engine::_m_json_schema_validation__5_3_4_2_a = (id, info, vContext) ->
  'elements are not unique'

##
# 5.3.4.  uniqueItems
Engine::_n_json_schema_validation__5_3_4_uniqueItems = (nContext) ->
  cls = @constructor
  ps = {
    uniqueItems: nContext.nodeIn.uniqueItems
  }

  if ps.uniqueItems == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isBoolean(ps.uniqueItems), { group: 'json-schema-validation', section: '5.3.4.1.a' }, ei)
    return

  if ps.uniqueItems == false
    return

  nContext.nodeOut.uniqueItems = ps.uniqueItems

  return

Engine::_c_json_schema_validation__5_3_4_uniqueItems = (cContext) ->
  cls = @constructor
  ps = {
    uniqueItems: cContext.node.uniqueItems
  }

  if ps.uniqueItems == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  return (vContext) =>
    if cls.isArray(vContext.value)
      @_eAssert(vContext, cls.areJsonArrayElementsUnique(vContext.value), { group: 'json-schema-validation', section: '5.3.4.2.a' }, ei)

    return
