assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('5.2.3 pattern', () ->

  testNormalize(
    '5.2.3.1.a',
    {
      pattern: 1
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.2.3.1.a"
          }
          "partialSchema": {
            "pattern": 1
          }
        }
        "level": "error"
        "message": "The value of \"pattern\" MUST be a string."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.2.3.1.b',
    {
      pattern: '['
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "5.2.3.1.b"
          }
          "partialSchema": {
            "pattern": "["
          }
        }
        "level": "warning"
        "message": "The value of \"pattern\" SHOULD be a valid regular expression, according to the ECMA 262 regular expression dialect."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '5.2.3.1. Ignore empty',
    {},
    {},
    []
  )

  testNormalize(
    '5.2.3.1. Ignore default'
    {
      pattern: ''
    },
    {}
  )

  testNormalize(
    '5.2.3.1. Valid'
    {
      pattern: '^[abc][a-z][^abc][a-z]a+a*a?a+?a*?a??a{1}a{1,2}a{1,}(a)(a|b)$'
    }
  )
)
