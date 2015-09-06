assert = require('chai').assert
jsonDatas = require('../../util/json-datas.coffee')
util = require('util')

suite('3.5. primitive-types-extra', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  simpleJson = jsonDatas.simpleJson()
  simpleNonJson = jsonDatas.simpleNonJson()
  allSimpleValues = []

  complexJson = jsonDatas.complexJson()
  complexNonJson = jsonDatas.complexNonJson()

  for own key, values of simpleJson
    allSimpleValues = allSimpleValues.concat(values)
  for own key, values of simpleNonJson
    allSimpleValues = allSimpleValues.concat(values)

  test('isAny', () ->
    for value in allSimpleValues
      assert(exJsonSchema.isAny(value), 'isAny should always return true')
  )

  test('isFunction', () ->
    validValues = simpleNonJson.function
    invalidValues = allSimpleValues.filter(
      (value) ->
        validValues.indexOf(value) == -1
    )

    for value in validValues
      assert(exJsonSchema.isFunction(value), "isFunction failed to detect function for value #{value}")

    for value in invalidValues
      assert(not exJsonSchema.isFunction(value), "isFunction erroneously detected function for value #{value}")
  )

  test('isJsonType', () ->
    for own typeName, values of simpleJson
      for value in values
        assert(exJsonSchema.isJsonType(value), "isJsonType failed to detect #{typeName} for value #{value}")

    for own typeName, values of simpleNonJson
      for value in values
        assert(not exJsonSchema.isJsonType(value), "isJsonType erroneously identified #{typeName} as a json primitive for value #{value}")
  )

  test('isJsonPrimitive', () ->
    assert(exJsonSchema.isJsonPrimitive(true), 'boolean')
    assert(exJsonSchema.isJsonPrimitive(1), 'integer')
    assert(exJsonSchema.isJsonPrimitive(1.1), 'number')
    assert(exJsonSchema.isJsonPrimitive(null), 'null')
    assert(exJsonSchema.isJsonPrimitive('string'), 'string')
  )

  test('isJsonPrimitive', () ->
    assert(exJsonSchema.isJsonContainer([]), 'array')
    assert(exJsonSchema.isJsonContainer({}), 'object')
  )

  test('isJsonPrimitive and isJsonContainer', () ->
    for own typeName, values of simpleJson
      for value in values
        assert(exJsonSchema.isJsonPrimitive(value) ^ exJsonSchema.isJsonContainer(value), 'cannot be both primitive and container')
  )

  test('isJsonDeep', () ->
    for own typeName, values of simpleJson
      for value in values
        assert(exJsonSchema.isJsonDeep(value), "isJsonDeep failed to detect #{typeName} for value `#{util.inspect(value, { depth: null })}`")

    for own typeName, values of simpleNonJson
      for value in values
        assert(not exJsonSchema.isJsonDeep(value), "isJsonDeep erroneously identified #{typeName} as json for value `#{util.inspect(value, { depth: null })}`")

    for value in complexJson
      assert(exJsonSchema.isJsonDeep(value), "isJsonDeep failed to detect json for value `#{util.inspect(value, { depth: null })}`")

    for value in complexNonJson
      assert(not exJsonSchema.isJsonDeep(value), "isJsonDeep erroneously detected json for value `#{util.inspect(value, { depth: null })}`")
  )
)
