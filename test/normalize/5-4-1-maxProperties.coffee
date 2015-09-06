assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.4.1 maxProperties', () ->

  testNormalize(
    '5.4.1.1.a',
    {
      maxProperties: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.1.1.a"
          }
          "partialSchema": {
            "maxProperties": true
          }
        }
        "level": "error"
        "message": "The value of \"maxProperties\" keyword MUST be an integer."
      }
    ]
  )

  testNormalize(
    '5.4.1.1.b',
    {
      maxProperties: -1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.1.1.b"
          }
          "partialSchema": {
            "maxProperties": -1
          }
        }
        "level": "error"
        "message": "The value of \"maxProperties\" MUST be greater than, or equal to, 0."
      }
    ]
  )

  testNormalize(
    '5.4.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.4.1.1. Valid'
    {
      maxProperties: 1
    }
  )
)
