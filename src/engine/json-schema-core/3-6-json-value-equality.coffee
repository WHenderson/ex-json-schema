##
# Returns true if lhs and rhs are equal according to json_schema_core#3.6
# Note that this only works for json values. Results are undefined for non-json data
Engine.isJsonEqual = (lhs, rhs) ->
  if @isNull(lhs) and @isNull(rhs)
    return true

  if @isBoolean(lhs) and @isBoolean(rhs) and lhs == rhs
    return true

  if @isString(lhs) and @isString(rhs) and lhs == rhs
    return true

  if @isNumber(lhs) and @isNumber(rhs) and lhs == rhs
    return true

  if @isArray(lhs) and @isArray(rhs)
    lhsLength = lhs.length
    rhsLength = rhs.length

    if lhsLength != rhsLength
      return false

    i = 0
    while i != lhsLength
      if not @isJsonEqual(lhs[i], rhs[i])
        return false
      ++i

    return true

  if @isObject(lhs) and @isObject(rhs)
    lhsKeys = Object.keys(lhs)
    rhsKeys = Object.keys(rhs)

    if not @isJsonEqual(lhsKeys, rhsKeys)
      return false

    for key in lhsKeys
      if not @isJsonEqual(lhs[key], rhs[key])
        return false

    return true

  return false
