assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.5 oneOf', () ->

  testNormalize(
    '5.5.5.1.a',
    {
      oneOf: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.5.1.a"
          }
          "partialSchema": {
            "oneOf": true
          }
        }
        "level": "error"
        "message": "The value of \"oneOf\" MUST be an array."
      }
    ]
  )

  testNormalize(
    '5.5.5.1.b',
    {
      oneOf: []
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.5.1.b"
          }
          "partialSchema": {
            "oneOf": []
          }
        }
        "level": "error"
        "message": "The value of \"oneOf\" MUST have at least one element."
      }
    ]
  )

  testNormalize(
    '5.5.5.1.c',
    {
      oneOf: [{}, true]
    },
    {
      oneOf: [{}]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.5.1.c"
          }
          "partialSchema": {
            "oneOf": [
              {}
              true
            ]
          }
        }
        "level": "error"
        "message": "Elements of \"oneOf\" MUST be objects"
      }
    ]
  )

  testNormalize(
    '5.5.5.1.d',
    {
      oneOf: [{ minimum: true }]
    },
    {
      oneOf: [{}]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.5.1.d"
          }
          "partialSchema": {
            "oneOf": [
              {
                "minimum": true
              }
            ]
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
        "message": "Elements of \"oneOf\" MUST be valid JSON Schemas"
      }
    ]
  )

  testNormalize(
    '5.5.5.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.5.1. Valid'
    {
      oneOf: [{}]
    }
  )
)
