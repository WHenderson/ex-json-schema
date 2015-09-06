assert = require('chai').assert

suite('pattern', () ->
  exJsonSchema = null

  setup(() ->
    @timeout(3000)
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  suite('isPatternEcma262', () ->
    test('Valid', () ->
      assert(exJsonSchema.isPatternEcma262('^(abc)([abc][a-z])([^abc][^a-z])(a+b*c?)(a+?b*?c??)(a{1}b{2,3}c{4,})(a{1}?b{2,3}?c{4,}?)(a|b|c)$'), 'failed to detect regular expression')
    )
    test('Invalid', () ->
      assert(not exJsonSchema.isPatternEcma262('*'), 'erroneously detected regular expression')
    )
    test('Unsupported', () ->
      assert(not exJsonSchema.isPatternEcma262('*'), 'erroneously detected regular expression')
    )
  )

)
