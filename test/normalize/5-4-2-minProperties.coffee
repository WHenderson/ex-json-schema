assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.4.2 minProperties', () ->

  testNormalize(
    '5.4.2.1.a',
    {
      minProperties: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.2.1.a"
          }
          "partialSchema": {
            "minProperties": true
          }
        }
        "level": "error"
        "message": "The value of \"minProperties\" keyword MUST be an integer."
      }
    ]
  )

  testNormalize(
    '5.4.2.1.b',
    {
      minProperties: -1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.2.1.b"
          }
          "partialSchema": {
            "minProperties": -1
          }
        }
        "level": "error"
        "message": "The value of \"minProperties\" MUST be greater than, or equal to, 0."
      }
    ]
  )

  testNormalize(
    '5.4.2.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.4.2.1. Ignore defaults',
    {
      minProperties: 0
    },
    {},
    []
  )

  testNormalize(
    '5.4.2.1. Valid'
    {
      minProperties: 1
    }
  )
)
