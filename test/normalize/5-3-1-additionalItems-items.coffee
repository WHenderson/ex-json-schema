assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.3.1 additionalItems and items', () ->

  testNormalize(
    '5.3.1.1.a',
    {
      additionalItems: 1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.1.1.a"
          }
          "partialSchema": {
            "additionalItems": 1
            "items": undefined
          }
        }
        "level": "error"
        "message": "The value of \"additionalItems\" MUST be either a boolean or an object."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.1.1.b',
    {
      additionalItems: { minimum: true }
      items: []
    },
    {
      "additionalItems": {}
      "items": []
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.1.1.b"
          }
          "partialSchema": {
            "additionalItems": {
              "minimum": true
            }
            "items": []
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
            "path": "/additionalItems"
          }
        ]
        "level": "error"
        "message": "If \"additionalItems\" is an object, it MUST be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.1.1.c',
    {
      additionalItems: true
      items: 1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.1.1.c"
          }
          "partialSchema": {
            "additionalItems": true
            "items": 1
          }
        }
        "level": "error"
        "message": "The value of \"items\" MUST be either an object or an array."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.1.1.d',
    {
      additionalItems: true
      items: { minimum: true }
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.1.1.d"
          }
          "partialSchema": {
            "additionalItems": true
            "items": {
              "minimum": true
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
            "path": "/items"
          }
        ]
        "level": "error"
        "message": "If \"items\" is an object, this object MUST be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.1.1.e',
    {
      additionalItems: true
      items: [1]
    },
    {
      "additionalItems": {}
      "items": [
        {}
      ]
    },
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.3.1.1.e"
          }
          "partialSchema": {
            "additionalItems": true
            "items": [
              1
            ]
          }
        }
        "level": "error"
        "message": "If \"items\" is an array, items of this array MUST be objects, and each of these objects MUST be a valid JSON Schema."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.3.1.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.3.1.1. Ignore default',
    {
      additionalItems: {}
      items: {}
    },
    {},
    []
  )

  testNormalize(
    '5.3.1.1. Normalize additionalItems',
    {
      additionalItems: true
      items: []
    },
    {
      "additionalItems": {}
      "items": []
    },
    []
  )


  testNormalize(
    '5.3.1.1. Default items',
    {
      additionalItems: false
    },
    {},
    []
  )

  testNormalize(
    '5.3.1.1. Ignore defaults',
    {
      additionalItems: true
      items: {}
    },
    {},
    []
  )

  testNormalize(
    '5.3.1.1. additionalItems=false'
    {
      additionalItems: false
      items: []
    }
  )

  testNormalize(
    '5.3.1.1. additionalItems=true'
    {
      additionalItems: true
      items: []
    }
    {
      "additionalItems": {}
      "items": []
    }
  )

  testNormalize(
    '5.3.1.1. additionalItems=schema'
    {
      additionalItems: { minimum: 0 }
      items: []
    }
    {
      "additionalItems": {
        "exclusiveMinimum": false
        "minimum": 0
      }
      "items": []
    }
  )

  testNormalize(
    '5.3.1.1. items=schema'
    {
      items:{ minimum: 0 }
    }
    {
      "items": {
        "exclusiveMinimum": false
        "minimum": 0
      }
    }
  )

  testNormalize(
    '5.3.1.1. items=array'
    {
      items:[{ minimum: 0 }]
    }
    {
      "additionalItems": {}
      "items": [
        {
          "exclusiveMinimum": false
          "minimum": 0
        }
      ]
    }
  )
)
