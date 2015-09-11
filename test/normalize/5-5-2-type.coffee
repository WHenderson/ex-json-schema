assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.5.2 type', () ->

  testNormalize(
    '5.5.2.1.a',
    {
      type: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.2.1.a"
          }
          "partialSchema": {
            "type": true
          }
        }
        "level": "error"
        "message": "The value of \"type\" MUST be either a string or an array."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.2.1.b',
    {
      type: [true]
    },
    {
      type: []
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.2.1.b"
          }
          "partialSchema": {
            "type": [
              true
            ]
          }
        }
        "level": "error"
        "message": "If \"type\" is an array, elements of the array MUST be strings."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.2.1.c',
    {
      type: ['string','integer','string']
    },
    {
      type: ['string','integer']
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.2.1.c"
          }
          "partialSchema": {
            "type": [
              "string"
              "integer"
              "string"
            ]
          }
        }
        "level": "error"
        "message": "If \"type\" is an array, elements of the array MUST be unique."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.2.1.d (array)',
    {
      type: ['undefined']
    },
    {
      type: []
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.2.1.d"
          }
          "partialSchema": {
            "type": [
              "undefined"
            ]
          }
        }
        "level": "error"
        "message": "The value(s) of \"type\" MUST be one of the seven primitive types defined by the core specification."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.2.1.d (string)',
    {
      type: 'undefined'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.5.2.1.d"
          }
          "partialSchema": {
            "type": "undefined"
          }
        }
        "level": "error"
        "message": "The value(s) of \"type\" MUST be one of the seven primitive types defined by the core specification."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.5.2.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.5.2.1. Valid array'
    {
      type: ['array','boolean','integer','number','null','object','string']
    }
  )

  testNormalize(
    '5.5.2.1. Valid string'
    {
      type: 'array'
    },
    {
      type: ['array']
    }
  )
)
