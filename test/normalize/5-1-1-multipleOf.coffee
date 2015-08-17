assert = require('chai').assert

suite('5.1.1 multipleOf', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../dist/ex-json-schema.coffee')
  )

  testNormalize = (
    inSchema,
    outSchema,
    outMessages=[]
  ) ->
    outSchema ?= inSchema
    engine = new exJsonSchema()
    context = engine.normalize(inSchema)
    assert.deepEqual(context.nodeOut, outSchema, 'failed to normalize schema correctly')
    if outMessages.length == 0
      assert(context.messages.length == 0, 'expected silent operation')
    else
      messages = context.messages.map((message) ->
        {
          level: message.level
          message: message.error.message
          info: message.error.info
        }
      )
      assert.deepEqual(messages, outMessages, 'incorrect message output')
    return context

  test('5.1.1.1. The value of "multipleOf" MUST be a JSON number', () ->
    testNormalize(
      {
        multipleOf: 'incorrect'
      },
      {},
      [
        {
          "info": {
            "multipleOf": "incorrect"
          }
          "level": "error"
          "message": "The value of \"multipleOf\" MUST be a JSON number."
        }
      ]
    )
  )
  test('5.1.1.1. The value of "multipleOf" MUST be strictly greater than 0', () ->
    testNormalize(
      {
        multipleOf: 0
      },
      {},
      [
        {
          "info": {
            "multipleOf": 0
          }
          "level": "error"
          "message": "The value of \"multipleOf\" MUST be strictly greater than 0."
        }
      ]
    )
  )
  test('5.1.1.1. Valid', () ->
    testNormalize({
      multipleOf: 1
    })
  )
)
