Engine::_m_json_schema_validation__5_3_4_1_a = (id, partialSchema, context) ->
  'The value of "uniqueItems" keyword MUST be a boolean'

##
# 5.3.4.  uniqueItems
Engine::_n_json_schema_validation__5_3_4_uniqueItems = (context) ->
  cls = @constructor
  ps = {
    uniqueItems: context.nodeIn.uniqueItems
  }

  if ps.uniqueItems == undefined
    return

  if @_eAssert(context, cls.isBoolean(ps.uniqueItems), { group: 'json-schema-validation', section: '5.3.4.1.a' }, ps)
    return

  if ps.uniqueItems == false
    return

  context.nodeOut.uniqueItems = ps.uniqueItems

  return
