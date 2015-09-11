assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.1.3 minimum and exclusiveMinimum', () ->

  testNormalize(
    '5.1.3.1.a',
    {
      minimum: 'incorrect'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.3.1.a"
          }
          "partialSchema": {
            "exclusiveMinimum": undefined
            "minimum": "incorrect"
          }
        }
        "level": "error"
        "message": "The value of \"minimum\" MUST be a JSON number."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.1.3.1.b',
    {
      minimum: 0
      exclusiveMinimum: 0
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.3.1.b"
          }
          "partialSchema": {
            "exclusiveMinimum": 0
            "minimum": 0
          }
        }
        "level": "error"
        "message": "The value of \"exclusiveMinimum\" MUST be a boolean."
        "path": "/"
      }
    ]
  )


  testNormalize(
    '5.1.3.1.c',
    {
      exclusiveMinimum: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.3.1.c"
          }
          "partialSchema": {
            "exclusiveMinimum": true
            "minimum": undefined
          }
        }
        "level": "error"
        "message": "If \"exclusiveMinimum\" is present, \"minimum\" MUST also be present."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.1.3.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.1.3.1. Valid minimum'
    {
      minimum: 1
    },
    {
      "exclusiveMinimum": false
      "minimum": 1
    }
  )

  testNormalize(
    '5.1.3.1. Valid minimum and exclusiveMinimum'
    {
      minimum: 1
      exclusiveMinimum: true
    },
    {
      "exclusiveMinimum": true
      "minimum": 1
    }
  )
)
