assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.7 definitions', () ->

  testNormalize(
    '5.5.7.1.a',
    {
      definitions: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.7.1.a"
          }
          "partialSchema": {
            "definitions": true
          }
        }
        "level": "error"
        "message": "The value of \"definitions\" MUST be an object."
      }
    ]
  )

  testNormalize(
    '5.5.7.1.b',
    {
      definitions: {
        a: true
      }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.7.1.b"
          }
          "partialSchema": {
            "definitions": {
              "a": true
            }
          }
        }
        "level": "error"
        "message": "Each member of \"definitions\" MUST be a valid JSON Schema."
      }
    ]
  )

  testNormalize(
    '5.5.7.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.7.1. Valid'
    {
      definitions: {
        a: {}
      }
    }
  )
)
