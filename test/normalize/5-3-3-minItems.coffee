assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.3.3 minItems', () ->

  testNormalize(
    '5.3.3.1.a',
    {
      minItems: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.3.1.a"
          }
          "partialSchema": {
            "minItems": true
          }
        }
        "level": "error"
        "message": "The value of \"minItems\" keyword MUST be an integer."
      }
    ]
  )

  testNormalize(
    '5.3.3.1.b',
    {
      minItems: -1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.3.1.b"
          }
          "partialSchema": {
            "minItems": -1
          }
        }
        "level": "error"
        "message": "The value of \"minItems\" MUST be greater than, or equal to, 0"
      }
    ]
  )

  testNormalize(
    '5.3.3.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.3.3.1. Ignore default',
    {
      minItems: 0
    },
    {},
    []
  )

  testNormalize(
    '5.3.3.1. Valid'
    {
      minItems: 1
    }
  )
)
