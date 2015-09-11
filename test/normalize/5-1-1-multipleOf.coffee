assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.1.1 multipleOf', () ->

  testNormalize(
    '5.1.1.1.a',
    {
      multipleOf: 'incorrect'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.1.1.a"
          }
          "partialSchema": {
            "multipleOf": "incorrect"
          }
        }
        "level": "error"
        "message": "The value of \"multipleOf\" MUST be a JSON number"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.1.1.1.b',
    {
      multipleOf: 0
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.1.1.b"
          }
          "partialSchema": {
            "multipleOf": 0
          }
        }
        "level": "error"
        "message": "The value of \"multipleOf\" MUST be strictly greater than 0"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.1.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.1.1.1. Valid'
    {
      multipleOf: 1
    }
  )
)
