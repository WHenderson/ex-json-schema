Engine::_m_multipleOf__n_not_a_number = (info, context) ->
  'The value of "multipleOf" MUST be a JSON number.'

Engine::_m_multipleOf__n_not_greater_than_0 = (info, context) ->
  'The value of "multipleOf" MUST be strictly greater than 0.'

Engine::_m_multipleOf__c_not_multiple_of = (info, context) ->
  "is not a multiple of #{info.multipleOf}"

##
# 5.1.1.  multipleOf
Engine::_n_multipleOf = (context) ->
  cls = @constructor
  l_multipleOf = context.nodeIn.multipleOf

  if l_multipleOf == undefined
    return

  # 5.1.1.1.  Valid values
  # The value of "multipleOf" MUST be a JSON number.
  # This number MUST be strictly greater than 0.

  if @_eAssert(context, cls.isNumber(l_multipleOf), @_m_multipleOf__n_not_a_number, { multipleOf: l_multipleOf })
    return

  if @_eAssert(context, l_multipleOf > 0, @_m_multipleOf__n_not_greater_than_0, { multipleOf: l_multipleOf })
    return

  context.nodeOut.multipleOf = l_multipleOf

  return
