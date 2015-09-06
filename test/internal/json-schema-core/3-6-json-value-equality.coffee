assert = require('chai').assert
jsonDatas = require('../../util/json-datas.coffee')
util = require('util')

suite('3.6. json-value-equality', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  simpleJson = jsonDatas.simpleJson()
  complexJson = jsonDatas.complexJson()

  allValues = []

  for own typeName, values of simpleJson
    allValues = allValues.concat(values)

  allValues = allValues.concat(complexJson)

  test('isJsonDeepEqual', () ->
    for lhs in allValues
      for rhs in allValues
        assert.equal(exJsonSchema.isJsonDeepEqual(lhs, rhs), JSON.stringify(lhs) == JSON.stringify(rhs), "incorrect identification between `#{util.inspect(lhs, { depth: null })}` and `#{util.inspect(rhs, { depth: null })}`")
  )
)
