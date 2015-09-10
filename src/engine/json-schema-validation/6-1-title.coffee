Engine::_m_json_schema_validation__6_1_1_a = (id, info, nContext) ->
  'The value of "title" MUST be a string.'

Engine::_n_json_schema_validation__6_1_title = (nContext) ->
  cls = @constructor
  ps = {
    title: nContext.nodeIn.title
  }

  if ps.title == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isString(ps.title), { group: 'json-schema-validation', section: '6.1.1.a' }, ei)
    return

  nContext.nodeOut.title = ps.title

  return
