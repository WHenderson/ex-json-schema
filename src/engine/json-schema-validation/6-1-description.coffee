Engine::_m_json_schema_validation__6_1_1_b = (id, partialSchema, nContext) ->
  'The value of "description" MUST be a string.'

Engine::_n_json_schema_validation__6_1_description = (nContext) ->
  cls = @constructor
  ps = {
    description: nContext.nodeIn.description
  }

  if ps.description == undefined
    return

  if @_eAssert(nContext, cls.isString(ps.description), { group: 'json-schema-validation', section: '6.1.1.b' }, ps)
    return

  nContext.nodeOut.description = ps.description

  return
