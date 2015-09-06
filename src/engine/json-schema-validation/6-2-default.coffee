Engine::_m_json_schema_validation__6_2_1_a = (id, partialSchema, context) ->
  'The value of "default" is not valid JSON data.'

Engine::_n_json_schema_validation__6_2_default = (context) ->
  if not {}.hasOwnProperty.call(context.nodeIn, 'default')
    return

  cls = @constructor
  ps = {
    default: context.nodeIn.default
  }

  @_wAssert(context, cls.isJsonDeep(ps.default), { group: 'json-schema-validation', section: '6.2.1.a' }, ps)

  context.nodeOut.default = ps.default

  return
