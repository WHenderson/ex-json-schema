##
# Return true (if argument is of any type)
Engine.isAny = () ->
  true

##
# Return true if value is a function type
# Note: This check isn't 100% accurate. Ensure this covers the cases you need!
Engine.isFunction = (value) ->
  typeof value == 'function'

##
# Returns true if value is a simple primitive type
Engine.isJsonPrimitive = (value) ->
  @isBoolean(value) or
  @isInteger(value) or
  @isNumber(value) or
  @isNull(value) or
  @isString(value)

##
# Returns true if value is a json container type
Engine.isJsonContainer = (value) ->
  @isArray(value) or
  @isObject(value)

##
# Returns true if value is any of the primitive json types
Engine.isJsonType = (value) ->
  @isArray(value) or
  @isBoolean(value) or
  @isInteger(value) or
  @isNumber(value) or
  @isNull(value) or
  @isObject(value) or
  @isString(value)

##
# Returns true if everything contained in value is a json primitive type
Engine.isJsonDeep = (value) ->
  if (
    @isBoolean(value) or
    @isInteger(value) or
    @isNumber(value) or
    @isNull(value) or
    @isString(value)
  )
    return true

  if @isObject(value)
    for own key, val of value
      if not @isJsonDeep(val)
        return false
    return true

  if @isArray(value)
    for val in value
      if not @isJsonDeep(val)
        return false
    return true

  return false
