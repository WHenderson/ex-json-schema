assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.3.4 uniqueItems', () ->

  testNormalize(
    '5.3.4.1.a',
    {
      uniqueItems: 1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.4.1.a"
          }
          "partialSchema": {
            "uniqueItems": 1
          }
        }
        "level": "error"
        "message": "The value of \"uniqueItems\" keyword MUST be a boolean"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.4.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.3.4.1. Ignore default',
    {
      uniqueItems: false
    },
    {},
    []
  )

  testNormalize(
    '5.3.4.1. Valid'
    {
      uniqueItems: true
    }
  )
)
