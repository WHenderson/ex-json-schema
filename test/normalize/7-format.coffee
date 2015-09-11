assert = require('chai').assert
testNormalize = require('../util/test-normalize.coffee')

suite('7 format', () ->

  testNormalize(
    '7.1.a',
    {
      format: true
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "7.1.a"
          }
          "partialSchema": {
            "format": true
          }
        }
        "level": "error"
        "message": "The value of \"format\" MUST be a string."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '7.1.b',
    {
      format: 'unknown'
    },
    {},
    [
      {
        "info": {
          "errorId": {
            "group": "json-schema-validation"
            "section": "7.1.b"
          }
          "partialSchema": {
            "format": "unknown"
          }
        }
        "level": "warning"
        "message": "The value of \"format\" SHOULD be a known format string."
        "path": "/"
      }
    ]
  )

  testNormalize(
    '7.3.1. date-time',
    {
      format: 'date-time'
    }
  )

  testNormalize(
    '7.3.2. email',
    {
      format: 'email'
    }
  )

  testNormalize(
    '7.3.3. hostname',
    {
      format: 'hostname'
    }
  )

  testNormalize(
    '7.3.4. ipv4',
    {
      format: 'ipv4'
    }
  )

  testNormalize(
    '7.3.5. ipv6',
    {
      format: 'ipv6'
    }
  )

  testNormalize(
    '7.3.6. uri',
    {
      format: 'uri'
    }
  )

)
