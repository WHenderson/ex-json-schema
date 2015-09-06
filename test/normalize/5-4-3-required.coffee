assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.4.3 required', () ->

  testNormalize(
    '5.4.3.1.a',
    {
      required: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.3.1.a"
          }
          "partialSchema": {
            "required": true
          }
        }
        "level": "error"
        "message": "The value of \"required\" keyword MUST be an array"
      }
    ]
  )

  testNormalize(
    '5.4.3.1.b',
    {
      required: []
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.3.1.b"
          }
          "partialSchema": {
            "required": []
          }
        }
        "level": "error"
        "message": "The value of \"required\" array MUST have at least one element"
      }
    ]
  )

  testNormalize(
    '5.4.3.1.c',
    {
      required: [1,2,3]
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.3.1.c"
          }
          "partialSchema": {
            "required": [
              1
              2
              3
            ]
          }
        }
        "level": "error"
        "message": "Elements of \"required\" MUST be strings"
      }
    ]
  )

  testNormalize(
    '5.4.3.1.d',
    {
      required: ['duplicate','duplicate']
    },
    {
      "required": [
        "duplicate"
      ]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.3.1.d"
          }
          "partialSchema": {
            "required": [
              "duplicate"
              "duplicate"
            ]
          }
        }
        "level": "error"
        "message": "Elements of \"required\" MUST be unique"
      }
    ]
  )

  testNormalize(
    '5.4.3.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.4.3.1. Valid'
    {
      required: ['a','b','c']
    }
  )
)
