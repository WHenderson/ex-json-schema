assert = require('chai').assert
jsonDatas = require('../../util/json-datas.coffee')

suite('3.5. primitive-types', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  simpleJson = jsonDatas.simpleJson()
  simpleNonJson = jsonDatas.simpleNonJson()
  allValues = []

  for own key, values of simpleJson
    allValues = allValues.concat(values)
  for own key, values of simpleNonJson
    allValues = allValues.concat(values)

  for own typeName, validValues of simpleJson
    do (typeName, validValues) ->
      funcName = 'is' + typeName.slice(0,1).toUpperCase() + typeName.slice(1)

      invalidValues = allValues.filter(
        (value) ->
          validValues.indexOf(value) == -1
      )

      test(funcName, () ->
        func = exJsonSchema[funcName].bind(exJsonSchema)

        for value in validValues
          assert(func(value), "#{funcName} failed to detect #{typeName} for value #{value}")

        for value in invalidValues
          assert(not func(value), "#{funcName} erroneously detected #{typeName} for value #{value}")
      )
)
