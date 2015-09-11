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
        "path": "/"
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
        "path": "/"
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
        "path": "/"
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
            "path": "/allOf/0"
          }
        ]
        "level": "error"
        "message": "Elements of \"allOf\" MUST be valid JSON Schemas"
        "path": "/"
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
