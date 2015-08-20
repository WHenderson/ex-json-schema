assert = require('chai').assert
testDatas = require('./test-datas.coffee')
util = require('util')

suite('3-6-json-value-equality', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  simpleJson = testDatas.simpleJson()
  complexJson = testDatas.complexJson()

  allValues = []

  for own typeName, values of simpleJson
    allValues = allValues.concat(values)

  allValues = allValues.concat(complexJson)

  test('isJsonEqual', () ->
    for lhs in allValues
      for rhs in allValues
        assert.equal(exJsonSchema.isJsonEqual(lhs, rhs), JSON.stringify(lhs) == JSON.stringify(rhs), "incorrect identification between `#{util.inspect(lhs, { depth: null })}` and `#{util.inspect(rhs, { depth: null })}`")
  )
)
