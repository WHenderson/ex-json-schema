Engine.stringLengthSimple = (value) ->
  value.length

Engine.stringLengthUnicode = (value) ->
  value.replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g, '_').length

Engine.stringLength = Engine.stringLengthUnicode
