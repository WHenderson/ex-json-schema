Engine::_m_json_schema_validation__7_1_a = (id, info, nContext) ->
  'The value of "format" MUST be a string.'

Engine::_m_json_schema_validation__7_1_b = (id, info, nContext) ->
  'The value of "format" SHOULD be a known format string.'

Engine::_m_json_schema_validation__7_1_failure = (id, info, nContext) ->
  "not a valid #{info.partialSchema.format}"

Engine::formats = new Formats()

Engine::_n_json_schema_validation__7_format = (nContext) ->
  cls = @constructor
  ps = {
    format: nContext.nodeIn.format
  }

  if ps.format == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isString(ps.format), { group: 'json-schema-validation', section: '7.1.a' }, ei)
    return

  if @_wAssert(nContext, ("assertIs_#{ps.format}" of @formats) or ("is_#{ps.format}" of @formats), { group: 'json-schema-validation', section: '7.1.b' }, ei)
    return

  nContext.nodeOut.format = ps.format

  return

Engine::_c_json_schema_validation__7_format = (cContext) ->
  cls = @constructor
  ps = {
    format: cContext.node.format
  }

  if ps.format == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  name = "assertIs_#{ps.format}"
  if name of @formats
    return (vContext) =>
      try
        @formats[name](vContext.value)
      catch ex
        @_eAssert(
          vContext,
          false,
          { group: 'json-schema-validation', section: '7.1.failure' },
          {
            partialSchema: ps
            cContext: cContext
            details: {
              exception: ex
            }
          }
        )
      return
  else
    name = "is_#{ps.format}"
    return (vContext) =>
      @_eAssert(
        vContext,
        @formats[name](vContext.value),
        { group: 'json-schema-validation', section: '7.1.failure' },
        ei
      )

      return

