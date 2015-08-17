##
# Return true if value is an array type
Engine.isArray = (value) ->
  Array.isArray(value)

##
# Return true if value is a boolean type
Engine.isBoolean = (value) ->
  typeof value == 'boolean'

##
# Return true if value is an integer type
Engine.isInteger = (value) ->
  typeof value == 'number' and (value | 0) == value

##
# Return true if value is a number type
Engine.isNumber = (value) ->
  typeof value == 'number'

##
# Return true if value is null
Engine.isNull = (value) ->
  value is null

##
# Return true if value is an object type
Engine.isObject = (value) ->
  typeof value == 'object' and value != null and not Array.isArray(value)

##
# Return true if value is a string type
Engine.isString = (value) ->
  typeof value == 'string'
