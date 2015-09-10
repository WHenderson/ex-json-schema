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

  ###
  suite('messages', () ->

    msgText = "test message"
    msgInfo = { data: "test data" }
    msgInnerErrors = []

    test('error', () ->
      context = new exJsonSchema.Context()
      context.msgError(msgText, msgInfo, msgInnerErrors)

      assert.equal(context.messages.length, 1, 'message not saved')

      msg = context.messages[0]
      assert.equal(msg.level, 'error', 'incorrect error level')
      assert.equal(msg.error.message, msgText, 'incorrect message')
      assert.equal(msg.error.info, msgInfo, 'incorrect info')
      assert.equal(msg.error.innerErrors, msgInnerErrors, 'incorrect inner errors')
    )

    test('warning', () ->
      context = new exJsonSchema.Context()
      context.msgWarning(msgText, msgInfo, msgInnerErrors)

      assert.equal(context.messages.length, 1, 'message not saved')

      msg = context.messages[0]
      assert.equal(msg.level, 'warning', 'incorrect error level')
      assert.equal(msg.error.message, msgText, 'incorrect message')
      assert.equal(msg.error.info, msgInfo, 'incorrect info')
      assert.equal(msg.error.innerErrors, msgInnerErrors, 'incorrect inner errors')
    )

    test('information', () ->
      context = new exJsonSchema.Context()
      context.msgInformation(msgText, msgInfo, msgInnerErrors)

      assert.equal(context.messages.length, 1, 'message not saved')

      msg = context.messages[0]
      assert.equal(msg.level, 'information', 'incorrect error level')
      assert.equal(msg.error.message, msgText, 'incorrect message')
      assert.equal(msg.error.info, msgInfo, 'incorrect info')
      assert.equal(msg.error.innerErrors, msgInnerErrors, 'incorrect inner errors')
    )
  )
  ###

)
