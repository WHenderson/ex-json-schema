assert = require('chai').assert

suite('3-5-primitive-types', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )


  validTestData = {
    isArray: [
      []
    ],
    isBoolean: [
      true,
      false
    ],
    isInteger: [
      0,
      1
    ],
    isNumber: [
      0,
      1,
      0.1
    ],
    isNull: [
      null
    ],
    isObject: [
      {}
    ],
    isString: [
      'string',
      String('string')
    ]
  }

  # Compile list of all test datas
  completeTestDatas = [
    undefined,
    () -> undefined
  ]
  for own funcName, testDatas of validTestData
    completeTestDatas = completeTestDatas.concat(testDatas)

  for own funcName, validDatas of validTestData
    do (funcName, validDatas) ->
      test(funcName, () ->
        invalidTestDatas = [].concat(completeTestDatas)

        for validData in validDatas
          assert(exJsonSchema[funcName](validData), "#{funcName} failed to detect type")

          invalidTestDatas = invalidTestDatas.filter((element) -> element != validData)

        for invalidData in invalidTestDatas
          assert(exJsonSchema[funcName](validData), "#{funcName} erroneously detected type")
      ))
