simpleJson = () ->
  return {
    array: [
      [],
      Array(),
      new Array()
    ],
    boolean: [
      true,
      false
    ],
    integer: [
      0,
      1
    ],
    number: [
      0,
      1,
      0.1
    ],
    null: [
      null
    ],
    object: [
      {},
      Object(),
      new Object()
    ],
    string: [
      'string',
      String('string')
    ]
  }

simpleNonJson = () ->
  return {
    undefined: [
      undefined
    ],
    function: [
      () -> undefined
    ]
  }

complexJson = () ->
  json = simpleJson()

  results = []
  for own key, values of json
    for value in values
      for array in simpleJson().array
        array.push(value)
        results.push(array)

      for object in simpleJson().object
        object[key] = value
        results.push(object)

  return results

complexNonJson = () ->
  nonJson = simpleNonJson()

  results = []
  for own key, values of nonJson
    for value in values
      for array in simpleJson().array
        array.push(value)
        results.push(array)

      for object in simpleJson().object
        object[key] = value
        results.push(object)

  return results


module.exports = {
  simpleJson: simpleJson,
  simpleNonJson: simpleNonJson,
  complexJson: complexJson,
  complexNonJson: complexNonJson
}
