Engine::_m_json_schema_validation__6_1_1_a = (id, partialSchema, context) ->
  'The value of "title" MUST be a string.'

Engine::_n_json_schema_validation__6_1_title = (context) ->
  cls = @constructor
  ps = {
    title: context.nodeIn.title
  }

  if ps.title == undefined
    return

  if @_eAssert(context, cls.isString(ps.title), { group: 'json-schema-validation', section: '6.1.1.a' }, ps)
    return

  context.nodeOut.title = ps.title

  return
