assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.1.2 maximum and exclusiveMaximum', () ->

  testNormalize(
    '5.1.2.1.a',
    {
      maximum: 'incorrect'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.2.1.a"
          }
          "partialSchema": {
            "exclusiveMaximum": undefined
            "maximum": "incorrect"
          }
        }
        "level": "error"
        "message": "The value of \"maximum\" MUST be a JSON number."
      }
    ]
  )

  testNormalize(
    '5.1.2.1.b',
    {
      maximum: 0
      exclusiveMaximum: 0
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.2.1.b"
          }
          "partialSchema": {
            "exclusiveMaximum": 0
            "maximum": 0
          }
        }
        "level": "error"
        "message": "The value of \"exclusiveMaximum\" MUST be a boolean."
      }
    ]
  )


  testNormalize(
    '5.1.2.1.c',
    {
      exclusiveMaximum: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.1.2.1.c"
          }
          "partialSchema": {
            "exclusiveMaximum": true
            "maximum": undefined
          }
        }
        "level": "error"
        "message": "If \"exclusiveMaximum\" is present, \"maximum\" MUST also be present."
      }
    ]
  )

  testNormalize(
    '5.1.2.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.1.2.1. Valid maximum'
    {
      maximum: 1
    },
    {
      "exclusiveMaximum": false
      "maximum": 1
    }
  )

  testNormalize(
    '5.1.2.1. Valid maximum and exclusiveMaximum'
    {
      maximum: 1
      exclusiveMaximum: true
    },
    {
      "exclusiveMaximum": true
      "maximum": 1
    }
  )
)
