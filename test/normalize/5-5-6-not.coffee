assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.6 not', () ->

  testNormalize(
    '5.5.6.1.a',
    {
      not: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.6.1.a"
          }
          "partialSchema": {
            "not": true
          }
        }
        "level": "error"
        "message": "The value of \"not\" MUST be an object."
      }
    ]
  )

  testNormalize(
    '5.5.6.1.b',
    {
      not: { minimum: true }
    },
    {
      "not": {}
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.6.1.b"
          }
          "partialSchema": {
            "not": {
              "minimum": true
            }
          }
        }
        "innerErrors": [
          {
            "info": {
              "errorId": {
                "group": "json-schema-validation"
                "section": "5.1.3.1.a"
              }
              "partialSchema": {
                "exclusiveMinimum": undefined
                "minimum": true
              }
            }
            "message": "The value of \"minimum\" MUST be a JSON number."
          }
        ]
        "level": "error"
        "message": "The value of \"not\" MUST be a valid JSON Schema."
      }
    ]
  )

  testNormalize(
    '5.5.6.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.6.1. Valid'
    {
      not: {}
    }
  )
)
