assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.2.1 maxLength', () ->

  testNormalize(
    '5.2.1.1.a',
    {
      maxLength: 'incorrect'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.2.1.1.a"
          }
          "partialSchema": {
            "maxLength": "incorrect"
          }
        }
        "level": "error"
        "message": "The value of \"maxLength\" keyword MUST be an integer"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.2.1.1.b',
    {
      maxLength: -1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.2.1.1.b"
          }
          "partialSchema": {
            "maxLength": -1
          }
        }
        "level": "error"
        "message": "The value of \"maxLength\" MUST be greater than, or equal to, 0"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.2.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.2.1.1. Valid'
    {
      maxLength: 0
    }
  )
)
