assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('6.1 title', () ->

  testNormalize(
    '6.1.1.a',
    {
      title: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "6.1.1.a"
          }
          "partialSchema": {
            "title": true
          }
        }
        "level": "error"
        "message": "The value of \"title\" MUST be a string."
      }
    ]
  )

  testNormalize(
    '6.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '6.1.1. Valid'
    {
      title: 'my title'
    }
  )
)
