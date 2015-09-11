assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.3.2 maxItems', () ->

  testNormalize(
    '5.3.2.1.a',
    {
      maxItems: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.2.1.a"
          }
          "partialSchema": {
            "maxItems": true
          }
        }
        "level": "error"
        "message": "The value of \"maxItems\" keyword MUST be an integer."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.2.1.b',
    {
      maxItems: -1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.2.1.b"
          }
          "partialSchema": {
            "maxItems": -1
          }
        }
        "level": "error"
        "message": "The value of \"maxItems\" MUST be greater than, or equal to, 0"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.2.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.3.2.1. Valid'
    {
      maxItems: 1
    }
  )
)
