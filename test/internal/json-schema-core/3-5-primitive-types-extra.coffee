assert = require('chai').assert
testDatas = require('./test-datas.coffee')
util = require('util')

suite('3-5-primitive-types-extra', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  simpleJson = testDatas.simpleJson()
  simpleNonJson = testDatas.simpleNonJson()
  allSimpleValues = []

  complexJson = testDatas.complexJson()
  complexNonJson = testDatas.complexNonJson()

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

  test('isJsonPrimitive', () ->
    for own typeName, values of simpleJson
      for value in values
        assert(exJsonSchema.isJsonPrimitive(value), "isJsonPrimitive failed to detect #{typeName} for value #{value}")

    for own typeName, values of simpleNonJson
      for value in values
        assert(not exJsonSchema.isJsonPrimitive(value), "isJsonPrimitive erroneously identified #{typeName} as a json primitive for value #{value}")
  )

  test('isJson', () ->
    for own typeName, values of simpleJson
      for value in values
        assert(exJsonSchema.isJson(value), "isJson failed to detect #{typeName} for value `#{util.inspect(value, { depth: null })}`")

    for own typeName, values of simpleNonJson
      for value in values
        assert(not exJsonSchema.isJson(value), "isJson erroneously identified #{typeName} as json for value `#{util.inspect(value, { depth: null })}`")

    for value in complexJson
      assert(exJsonSchema.isJson(value), "isJson failed to detect json for value `#{util.inspect(value, { depth: null })}`")

    for value in complexNonJson
      assert(not exJsonSchema.isJson(value), "isJson erroneously detected json for value `#{util.inspect(value, { depth: null })}`")
  )
)
