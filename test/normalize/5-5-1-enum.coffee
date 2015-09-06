assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.1 enum', () ->

  testNormalize(
    '5.5.1.1.a',
    {
      enum: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.1.1.a"
          }
          "partialSchema": {
            "enum": true
          }
        }
        "level": "error"
        "message": "The value of \"enum\" MUST be an array."
      }
    ]
  )

  testNormalize(
    '5.5.1.1.b',
    {
      enum: []
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.1.1.b"
          }
          "partialSchema": {
            "enum": []
          }
        }
        "level": "error"
        "message": "The value of \"enum\" MUST have at least one element."
      }
    ]
  )

  testNormalize(
    '5.5.1.1.c',
    {
      enum: [
        {
          b: 2,
          a: 1
        },
        {
          a: 1,
          b: 2
        }
      ]
    },
    {
      enum: [
        {
          b: 2,
          a: 1
        }
      ]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.1.1.c"
          }
          "partialSchema": {
            "enum": [
              {
                "a": 1
                "b": 2
              }
              {
                "a": 1
                "b": 2
              }
            ]
          }
        }
        "level": "error"
        "message": "Elements in \"enum\" MUST be unique."
      }
    ]
  )

  testNormalize(
    '5.5.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.1.1. Valid'
    {
      enum: [1,2,3]
    }
  )
)
