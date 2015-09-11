assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.2.2 minLength', () ->

  testNormalize(
    '5.2.2.1.a',
    {
      minLength: 'incorrect'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.2.2.1.a"
          }
          "partialSchema": {
            "minLength": "incorrect"
          }
        }
        "level": "error"
        "message": "The value of \"minLength\" keyword MUST be an integer"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.2.2.1.b',
    {
      minLength: -1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.2.2.1.b"
          }
          "partialSchema": {
            "minLength": -1
          }
        }
        "level": "error"
        "message": "The value of \"minLength\" MUST be greater than, or equal to, 0"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.2.2.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.2.2.1. Ignore default'
    {
      minLength: 0
    },
    {}
  )

  testNormalize(
    '5.2.2.1. Valid'
    {
      minLength: 1
    }
  )
)
