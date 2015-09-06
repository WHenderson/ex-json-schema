assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('6.2 default', () ->

  func = () ->
  testNormalize(
    '6.2.1.a',
    {
      default: func
    },
    {
      default: func
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "6.2.1.a"
          }
          "partialSchema": {
            "default": func
          }
        }
        "level": "warning"
        "message": "The value of \"default\" is not valid JSON data."
      }
    ]
  )

  testNormalize(
    '6.2.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '6.2.1. Valid'
    {
      default: 'value'
    }
  )
)
