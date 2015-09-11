assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.4.5 dependencies', () ->

  testNormalize(
    '5.4.5.1.a',
    {
      dependencies: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.5.1.a"
          }
          "partialSchema": {
            "dependencies": true
          }
        }
        "level": "error"
        "message": "The value of \"dependencies\" MUST be an object."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.5.1.b',
    {
      dependencies: {
        a: true
      }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.5.1.b"
          }
          "partialSchema": {
            "dependencies": {
              "a": true
            }
          }
        }
        "level": "error"
        "message": "Each value of \"dependencies\" MUST be either an object or an array."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.5.1.c',
    {
      dependencies: {
        a: { minimum: true }
      }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.5.1.c"
          }
          "partialSchema": {
            "dependencies": {
              "a": {
                "minimum": true
              }
            }
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
            "path": "/dependencies/a"
          }
        ]
        "level": "error"
        "message": "If the value in \"dependencies\" is an object, it MUST be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.5.1.d',
    {
      dependencies: {
        a: []
      }
    },
    {
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.5.1.d"
          }
          "partialSchema": {
            "dependencies": {
              "a": []
            }
          }
        }
        "level": "error"
        "message": "If the value in \"dependencies\" is an array, it MUST have at least one element."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.5.1.e',
    {
      dependencies: {
        a: [true]
      }
    },
    {
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.5.1.e"
          }
          "partialSchema": {
            "dependencies": {
              "a": [
                true
              ]
            }
          }
        }
        "level": "error"
        "message": "If the value in \"dependencies\" is an array, each element MUST be a string."
        "path": "/"
      }
    ]
  )


  testNormalize(
    '5.4.5.1.f',
    {
      dependencies: {
        a: ['duplicate','duplicate']
      }
    },
    {
      dependencies: {
        a: ['duplicate']
      }
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.5.1.f"
          }
          "partialSchema": {
            "dependencies": {
              "a": [
                "duplicate"
                "duplicate"
              ]
            }
          }
        }
        "level": "error"
        "message": "If the value in \"dependencies\" is an array, elements in the array MUST be unique."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.5.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.4.5.1. Valid'
    {
      dependencies: {
        a: ['b']
        b: { minimum: 1 }
      }
    },
    {
      "dependencies": {
        "a": [
          "b"
        ]
        "b": {
          "exclusiveMinimum": false
          "minimum": 1
        }
      }
    }
  )
)
