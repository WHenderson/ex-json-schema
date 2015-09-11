assert = require('chai').assert

testNormalize = (
  testName,
  inSchema,
  outSchema,
  outMessages=[]
) ->

  if testName?
    test(testName, () -> testNormalize(null, inSchema, outSchema, outMessages))
    return

  exJsonSchema = require('../../dist/ex-json-schema.coffee')

  outSchema ?= inSchema

  engine = new exJsonSchema()
  context = engine.normalize(inSchema)

  assert.deepEqual(context.nodeOut, outSchema, 'failed to normalize schema correctly')

  if outMessages.length == 0
    assert(context.messages.length == 0, 'expected silent operation')
  else
    mapErrors = (errors) ->
      errors.map((error) ->
        result = {
          message: error.message
          info: error.info
          path: error.context.pathString()
        }
        if error.innerErrors? and error.innerErrors.length != 0
          result.innerErrors = mapErrors(error.innerErrors)
        return result
      )

    mapMessages = (messages) ->
      messages.map((message) ->
        result = {
          level: message.level
          message: message.error.message
          info: message.error.info
          path: message.error.context.pathString()
        }
        if message.error.innerErrors? and message.error.innerErrors.length != 0
          result.innerErrors = mapErrors(message.error.innerErrors)
        return result
      )

    messages = mapMessages(context.messages)
    assert.deepEqual(messages, outMessages, 'incorrect message output')
  return context

module.exports = testNormalize
