assert = require('chai').assert

suite('string length', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../../dist/ex-json-schema.coffee')
  )

  suite('stringLengthSimple', () ->
    test('empty', () ->
      assert.equal(exJsonSchema.stringLengthSimple(''), 0, 'wrong length')
    )
    test('simple', () ->
      assert.equal(exJsonSchema.stringLengthSimple('12345'), 5, 'wrong length')
    )
    test('surrogate', () ->
      assert.equal(exJsonSchema.stringLengthSimple('\uD83D\uDCA9'), 2, 'wrong length')
    )
    test('broken surrogate', () ->
      assert.equal(exJsonSchema.stringLengthSimple('\uD83D'), 1, 'wrong length')
    )
    test('multiple surrogates', () ->
      assert.equal(exJsonSchema.stringLengthSimple('\uD83D\uDCA9\uD83D\uDCA9'), 4, 'wrong length')
    )
    test('mixed', () ->
      assert.equal(exJsonSchema.stringLengthSimple('(\uD83D\uDCA9\uD83D\uDCA9)'), 6, 'wrong length')
    )
  )

  suite('stringLengthUnicode)', () ->
    test('empty', () ->
      assert.equal(exJsonSchema.stringLengthUnicode(''), 0, 'wrong length')
    )
    test('simple', () ->
      assert.equal(exJsonSchema.stringLengthUnicode('12345'), 5, 'wrong length')
    )
    test('surrogate', () ->
      assert.equal(exJsonSchema.stringLengthUnicode('\uD83D\uDCA9'), 1, 'wrong length')
    )
    test('broken surrogate', () ->
      assert.equal(exJsonSchema.stringLengthUnicode('\uD83D'), 1, 'wrong length')
    )
    test('multiple surrogates', () ->
      assert.equal(exJsonSchema.stringLengthUnicode('\uD83D\uDCA9\uD83D\uDCA9'), 2, 'wrong length')
    )
    test('mixed', () ->
      assert.equal(exJsonSchema.stringLengthUnicode('(\uD83D\uDCA9\uD83D\uDCA9)'), 4, 'wrong length')
    )
  )
)
