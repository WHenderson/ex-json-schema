assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.4 anyOf', () ->

  testNormalize(
    '5.5.4.1.a',
    {
      anyOf: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.4.1.a"
          }
          "partialSchema": {
            "anyOf": true
          }
        }
        "level": "error"
        "message": "The value of \"anyOf\" MUST be an array."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.4.1.b',
    {
      anyOf: []
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.4.1.b"
          }
          "partialSchema": {
            "anyOf": []
          }
        }
        "level": "error"
        "message": "The value of \"anyOf\" MUST have at least one element."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.4.1.c',
    {
      anyOf: [{}, true]
    },
    {
      anyOf: [{}]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.4.1.c"
          }
          "partialSchema": {
            "anyOf": [
              {}
              true
            ]
          }
        }
        "level": "error"
        "message": "Elements of \"anyOf\" MUST be objects"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.4.1.d',
    {
      anyOf: [{ minimum: true }]
    },
    {
      anyOf: [{}]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.4.1.d"
          }
          "partialSchema": {
            "anyOf": [
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
            "path": "/anyOf/0"
          }
        ]
        "level": "error"
        "message": "Elements of \"anyOf\" MUST be valid JSON Schemas"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.4.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.4.1. Valid'
    {
      anyOf: [{}]
    }
  )
)
