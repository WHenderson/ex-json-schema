Engine::_m_json_schema_validation__7_1_a = (id, partialSchema, context) ->
  'The value of "format" MUST be a string.'

Engine::_m_json_schema_validation__7_1_b = (id, partialSchema, context) ->
  'The value of "format" SHOULD be a known format string.'

Engine::formats = new Formats()

Engine::_n_json_schema_validation__7_format = (context) ->
  cls = @constructor
  ps = {
    format: context.nodeIn.format
  }

  if ps.format == undefined
    return

  if @_eAssert(context, cls.isString(ps.format), { group: 'json-schema-validation', section: '7.1.a' }, ps)
    return

  if @_wAssert(context, "is_#{ps.format}" of @formats, { group: 'json-schema-validation', section: '7.1.b' }, ps)
    return

  context.nodeOut.format = ps.format

  return
