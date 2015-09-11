assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.4.4 additionalProperties, properties and patternProperties', () ->

  testNormalize(
    '5.4.4.1.a',
    {
      additionalProperties: 1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.a"
          }
          "partialSchema": {
            "additionalProperties": 1
            "patternProperties": undefined
            "properties": undefined
          }
        }
        "level": "error"
        "message": "The value of \"additionalProperties\" MUST be a boolean or an object."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.b',
    {
      additionalProperties: { minimum: true }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.b"
          }
          "partialSchema": {
            "additionalProperties": {
              "minimum": true
            }
            "patternProperties": undefined
            "properties": undefined
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
            "path": "/additionalProperties"
          }
        ]
        "level": "error"
        "message": "If \"additionalProperties\" is an object, it MUST also be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.c',
    {
      properties: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.c"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": undefined
            "properties": true
          }
        }
        "level": "error"
        "message": "The value of \"properties\" object MUST be an object."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.d (not an object)',
    {
      properties: {
        a: true
      }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.d"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": undefined
            "properties": {
              "a": true
            }
          }
        }
        "level": "error"
        "message": "Each value of \"properties\" MUST be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.d (invalid schema)',
    {
      properties: {
        a: { minimum: true }
      }
    },
    {
      "additionalProperties": {}
      "patternProperties": {}
      "properties": {
        "a": {}
      }
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.d"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": undefined
            "properties": {
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
            "path": "/properties/a"
          }
        ]
        "level": "error"
        "message": "Each value of \"properties\" MUST be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.e',
    {
      patternProperties: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.e"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": true
            "properties": undefined
          }
        }
        "level": "error"
        "message": "The value of \"patternProperties\" MUST be an object."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.f',
    {
      patternProperties: {
        '***': true
      }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.f"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": {
              "***": true
            }
            "properties": undefined
          }
        }
        "level": "error"
        "message": "Each property name of \"patternProperties\" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.g (not an object)',
    {
      patternProperties: {
        '.': true
      }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.g"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": {
              ".": true
            }
            "properties": undefined
          }
        }
        "level": "error"
        "message": "Each value of \"patternProperties\" object MUST be an object and MUST be a valid JSON Schema"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1.g (invalid schema)',
    {
      patternProperties: {
        '.': { minimum: true }
      }
    },
    {
      "additionalProperties": {}
      "patternProperties": {
        ".": {}
      }
      "properties": {}
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.4.4.1.g"
          }
          "partialSchema": {
            "additionalProperties": undefined
            "patternProperties": {
              ".": {
                "minimum": true
              }
            }
            "properties": undefined
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
            "path": "/patternProperties/."
          }
        ]
        "level": "error"
        "message": "Each value of \"patternProperties\" object MUST be an object and MUST be a valid JSON Schema"
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.4.4.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.4.4.1. Ignore default'
    {
      additionalProperties: {}
      properties: {}
      patternProperties: {}
    },
    {}
  )

  testNormalize(
    '5.4.4.1. Ignore additionalProperties'
    {
      additionalProperties: true
      properties: {}
      patternProperties: {}
    },
    {}
  )

  testNormalize(
    '5.4.4.1. Keep additionalProperties'
    {
      additionalProperties: false
    },
    {
      additionalProperties: false
      properties: {}
      patternProperties: {}
    }
  )

  testNormalize(
    '5.4.4.1. Normalize additionalProperties'
    {
      additionalProperties: true
      properties: { a: {} }
      patternProperties: {}
    },
    {
      additionalProperties: {}
      properties: { a: {} }
      patternProperties: {}
    }
  )
)
