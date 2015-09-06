assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.3 allOf', () ->

  testNormalize(
    '5.5.3.1.a',
    {
      allOf: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.3.1.a"
          }
          "partialSchema": {
            "allOf": true
          }
        }
        "level": "error"
        "message": "The value of \"allOf\" MUST be an array."
      }
    ]
  )

  testNormalize(
    '5.5.3.1.b',
    {
      allOf: []
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.3.1.b"
          }
          "partialSchema": {
            "allOf": []
          }
        }
        "level": "error"
        "message": "The value of \"allOf\" MUST have at least one element."
      }
    ]
  )

  testNormalize(
    '5.5.3.1.c',
    {
      allOf: [{}, true]
    },
    {
      allOf: [{}]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.3.1.c"
          }
          "partialSchema": {
            "allOf": [
              {}
              true
            ]
          }
        }
        "level": "error"
        "message": "Elements of \"allOf\" MUST be objects"
      }
    ]
  )

  testNormalize(
    '5.5.3.1.d',
    {
      allOf: [{ minimum: true }]
    },
    {
      allOf: [{}]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.3.1.d"
          }
          "partialSchema": {
            "allOf": [
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
        "message": "Elements of \"allOf\" MUST be valid JSON Schemas"
      }
    ]
  )

  testNormalize(
    '5.5.3.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.3.1. Valid'
    {
      allOf: [{}]
    }
  )
)
