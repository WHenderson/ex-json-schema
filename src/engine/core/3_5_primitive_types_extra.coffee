##
# Return true (if argument is of any type)
Engine.is_any = () ->
  true

##
# Return true if value is a function type
# Note: This check isn't 100% accurate. Ensure this covers the cases you need!
Engine.is_function = (value) ->
  typeof value == 'function'

##
# Returns true if value is any of the primitive json types
Engine.is_json_primitive = (value) ->
  Engine.is_array(value) or
  Engine.is_boolean(value) or
  Engine.is_integer(value) or
  Engine.is_number(value) or
  Engine.is_null(value) or
  Engine.is_object(value) or
  Engine.is_string(value)
