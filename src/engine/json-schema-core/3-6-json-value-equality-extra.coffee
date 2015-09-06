##
# Acts like Array::indexOf, but does a deep json comparison for equality matching
Engine.jsonArrayIndexOf = (array, value, position = 0) ->
  for iElement in [position..array.length]
    if @isJsonDeepEqual(value, array[iElement])
      return iElement
  return -1

##
# Returns true if all array elements are unique
Engine.areJsonArrayElementsUnique = (array) ->
  for element, iElement in array
    if @jsonArrayIndexOf(array, element, iElement + 1) != -1
      return false
  return true

##
# Returns a duplicate array with duplicate elements removed
Engine.jsonArrayFilterDuplicates = (array) ->
  results = []

  for element in array
    if @jsonArrayIndexOf(results, element) == -1
      results.push(element)

  return results

##
# Returns a deep copy of the provided json, skipping any non-json values
Engine.jsonDeepCopy = (value) ->
  if @isObject(value)
    result = {}
    for own key, val of value
      val = @jsonDeepCopy(val)
      if val != undefined
        result[key] = val

    return result
  else if @isArray(value)
    result = []
    for el in value
      el = @jsonDeepCopy(el)
      if el != undefined
        result.push(el)

    return result
  else if Engine.isJsonPrimitive(value)
    return value
  else
    return undefined

##
# Returns a deep copy of the provided value. Only arrays and objects are considered containers.
Engine.deepCopy = (value) ->
  if @isObject(value)
    result = {}
    for own key, val of value
      result[key] = @deepCopy(val)

    return result
  else if @isArray(value)
    result = []
    for el in value
      result.push(@deepCopy(el))

    return result
  else
    return value

