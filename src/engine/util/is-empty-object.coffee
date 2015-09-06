Engine.isEmptyObject = (value) ->
  for own key of value
    return false
  return true
