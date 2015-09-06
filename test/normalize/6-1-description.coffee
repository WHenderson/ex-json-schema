assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('6.1 description', () ->

  testNormalize(
    '6.1.1.b',
    {
      description: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "6.1.1.b"
          }
          "partialSchema": {
            "description": true
          }
        }
        "level": "error"
        "message": "The value of \"description\" MUST be a string."
      }
    ]
  )

  testNormalize(
    '6.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '6.1.1. Valid'
    {
      description: 'my description'
    }
  )
)
