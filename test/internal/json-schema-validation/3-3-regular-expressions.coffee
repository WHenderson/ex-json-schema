assert = require('chai').assert

suite('3.3. regular expressions', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  suite('assertPatternIsSimple', () ->
    test('valid', () ->
      exJsonSchema.assertPatternIsSimple('')
    )

    test('invalid', () ->
      exJsonSchema.assertPatternIsSimple('')
    )
  )
)
