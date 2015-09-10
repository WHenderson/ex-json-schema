Engine::_m_json_schema_validation__6_2_1_a = (id, partialSchema, nContext) ->
  'The value of "default" is not valid JSON data.'

Engine::_n_json_schema_validation__6_2_default = (nContext) ->
  if not {}.hasOwnProperty.call(nContext.nodeIn, 'default')
    return

  cls = @constructor
  ps = {
    default: nContext.nodeIn.default
  }

  @_wAssert(nContext, cls.isJsonDeep(ps.default), { group: 'json-schema-validation', section: '6.2.1.a' }, ps)

  nContext.nodeOut.default = ps.default

  return
