Engine::_m_json_schema_validation__7_1_a = (id, partialSchema, nContext) ->
  'The value of "format" MUST be a string.'

Engine::_m_json_schema_validation__7_1_b = (id, partialSchema, nContext) ->
  'The value of "format" SHOULD be a known format string.'

Engine::formats = new Formats()

Engine::_n_json_schema_validation__7_format = (nContext) ->
  cls = @constructor
  ps = {
    format: nContext.nodeIn.format
  }

  if ps.format == undefined
    return

  if @_eAssert(nContext, cls.isString(ps.format), { group: 'json-schema-validation', section: '7.1.a' }, ps)
    return

  if @_wAssert(nContext, "is_#{ps.format}" of @formats, { group: 'json-schema-validation', section: '7.1.b' }, ps)
    return

  nContext.nodeOut.format = ps.format

  return
