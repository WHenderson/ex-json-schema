assert = require('chai').assert

suite('context', () ->
  exJsonSchema = null

  setup(() ->
    exJsonSchema = require('../../dist/ex-json-schema.coffee')
  )

  suite('path', () ->
    test('root', () ->
      context = new exJsonSchema.Context()
      assert.deepEqual(context.pathLocal(), [], 'bad pathLocal')
      assert.deepEqual(context.pathGlobal(), [], 'bad pathGlobal')
      assert.equal(context.pathLocalString(), '', 'bad pathLocalString')
      assert.equal(context.pathGlobalString(), '', 'bad pathGlobalString')
    )

    test('child', () ->
      rootContext = new exJsonSchema.Context(['a'])
      context = rootContext.newChildContext(['b','c'])

      assert.deepEqual(context.pathLocal(), ['b','c'], 'bad pathLocal')
      assert.deepEqual(context.pathGlobal(), ['a','b','c'], 'bad pathGlobal')
      assert.equal(context.pathLocalString(), 'b/c', 'bad pathLocalString')
      assert.equal(context.pathGlobalString(), 'a/b/c', 'bad pathGlobalString')
    )

    test('escaping', () ->

      assert.equal(exJsonSchema.Context.pathEscapeSegment('[/~/~]'), '[~1~0~1~0]', 'incorrect escaping')
      assert.equal(exJsonSchema.Context.pathUnescapeSegment('[~1~0~1~0]'), '[/~/~]', 'incorrect escaping')


      rootContext = new exJsonSchema.Context(['a/a'])
      context = rootContext.newChildContext(['b/b','c~c'])

      assert.equal(context.pathLocalString(), 'b~1b/c~0c', 'bad pathLocalString')
      assert.equal(context.pathGlobalString(), 'a~1a/b~1b/c~0c', 'bad pathGlobalString')
    )
  )

  suite('messages', () ->
    test('error', () ->
      context = new exJsonSchema.Context()
    )
  )


)
