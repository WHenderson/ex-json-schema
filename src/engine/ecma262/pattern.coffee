Engine.isPatternEcma262 = (value) ->
  try
    re = new RegExp(value)
  catch ex
    return false
  return true

Engine.isPattern = Engine.isPatternEcma262

