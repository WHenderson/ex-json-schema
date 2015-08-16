##
# Return true if value is an array type
Engine.is_array = (value) ->
  Array.isArray(value)

##
# Return true if value is a boolean type
Engine.is_boolean = (value) ->
  typeof value == 'boolean'

##
# Return true if value is an integer type
Engine.is_integer = (value) ->
  typeof value == 'number' and (value | 0) == value

##
# Return true if value is a number type
Engine.is_number = (value) ->
  typeof value == 'number'

##
# Return true if value is null
Engine.is_null = (value) ->
  value is null

##
# Return true if value is an object type
Engine.is_object = (value) ->
  typeof value == 'object' and value != null and not Array.isArray(value)

##
# Return true if value is a string type
Engine.is_string = (value) ->
  typeof value == 'string'
