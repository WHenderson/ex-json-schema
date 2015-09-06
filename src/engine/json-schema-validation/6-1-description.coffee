Engine::_m_json_schema_validation__6_1_1_b = (id, partialSchema, context) ->
  'The value of "description" MUST be a string.'

Engine::_n_json_schema_validation__6_1_description = (context) ->
  cls = @constructor
  ps = {
    description: context.nodeIn.description
  }

  if ps.description == undefined
    return

  if @_eAssert(context, cls.isString(ps.description), { group: 'json-schema-validation', section: '6.1.1.b' }, ps)
    return

  context.nodeOut.description = ps.description

  return
