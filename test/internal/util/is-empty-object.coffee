assert = require('chai').assert

suite('isEmptyObject', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  test('Empty Object Literal', () ->
    assert(exJsonSchema.isEmptyObject({}), 'expected empty object')
  )
  test('Empty Classed Object', () ->
    class TestClass
      func: () ->
    obj = new TestClass()
    assert(exJsonSchema.isEmptyObject(obj), 'expected empty object')
  )
  test('Non-Empty Object Literal', () ->
    assert(not exJsonSchema.isEmptyObject({a:1}), 'expected empty object')
  )
  test('Non-Empty Classed Object', () ->
    class TestClass
      func: () ->
    obj = new TestClass()
    obj.a = 1
    assert(not exJsonSchema.isEmptyObject(obj), 'expected empty object')
  )
)
