Engine::_m_json_schema_validation__5_1_1_1_a = (id, info, nContext) ->
  'The value of \"multipleOf\" MUST be a JSON number'

Engine::_m_json_schema_validation__5_1_1_1_b = (id, info, nContext) ->
  'The value of \"multipleOf\" MUST be strictly greater than 0'

Engine::_m_json_schema_validation__5_1_1_2_a = (id, info, vContext) ->
  "is not a multiple of #{partialSchema.multipleOf}"

Engine::_n_json_schema_validation__5_1_1_multipleOf = (nContext) ->
  cls = @constructor
  ps = {
    multipleOf: nContext.nodeIn.multipleOf
  }

  if ps.multipleOf == undefined
    return

  ei = {
    partialSchema: ps
  }

  if @_eAssert(nContext, cls.isNumber(ps.multipleOf), { group: 'json-schema-validation', section: '5.1.1.1.a' }, ei)
    return

  if @_eAssert(nContext, ps.multipleOf > 0, { group: 'json-schema-validation', section: '5.1.1.1.b' }, ei)
    return

  nContext.nodeOut.multipleOf = ps.multipleOf

  return

Engine::_c_json_schema_validation__5_1_1_multipleOf = (cContext) ->
  cls = @constructor
  ps = {
    multipleOf: cContext.node.multipleOf
  }

  if ps.multipleOf == undefined
    return

  ei = {
    partialSchema: ps
    cContext: cContext
  }

  if cls.isInteger(ps.multipleOf)
    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, vContext.value % ps.multipleOf == 0, { group: 'json-schema-validation', section: '5.1.1.2.a' }, ei)

      return
  else
    power = ps.multipleOf.toString().split('.')[1].length
    factor = Math.pow(10, power)
    multipleOf = ps.multipleOf * factor

    return (vContext) =>
      if cls.isNumber(vContext.value)
        @_eAssert(vContext, (vContext.value * factor) % multipleOf == 0, { group: 'json-schema-validation', section: '5.1.1.2.a' }, ei)

      return
